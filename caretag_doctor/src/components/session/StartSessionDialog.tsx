import { useState, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Client } from '@stomp/stompjs';
import { Loader2, ShieldCheck, XCircle, ShieldAlert } from 'lucide-react';
import { toast } from 'sonner';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { useSession } from '@/context/SessionContext';
import { useAuth } from '@/hooks/useAuth';

// UPDATE: Import the correct unified function and the key getter
import { getPrivateKey, decryptPatientRecord } from '@/utils/crptogrphy';

import axiosInstance from '@/utils/axiosInstance';
import type {
  RecordApprovalMessage,
  ActiveSessionState,
} from '@/types/session.types';

type DialogState =
  | 'confirm'
  | 'requesting'
  | 'waiting'
  | 'decrypting'
  | 'denied'
  | 'error';

interface StartSessionDialogProps {
  patientName: string;
  careTagId: string;
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

const BASE_URL = 'https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev';

export default function StartSessionDialog({
  patientName,
  careTagId,
  open,
  onOpenChange,
}: StartSessionDialogProps) {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { startSession } = useSession();
  const [state, setState] = useState<DialogState>('confirm');
  const [errorMsg, setErrorMsg] = useState('');
  const stompClient = useRef<Client | null>(null);

  const cleanup = useCallback(() => {
    if (stompClient.current) {
      stompClient.current.deactivate();
      stompClient.current = null;
    }
  }, []);

  const handleClose = useCallback(
    (isOpen: boolean) => {
      if (!isOpen) {
        cleanup();
        setState('confirm');
        setErrorMsg('');
      }
      onOpenChange(isOpen);
    },
    [cleanup, onOpenChange]
  );

  const handleStartSession = useCallback(async () => {
    setState('requesting');

    try {
      // 1. Request record access from Backend
      await axiosInstance.post('/doctor/record/request', careTagId, {
        headers: { 'Content-Type': 'text/plain' },
      });

      setState('waiting');

      // 2. Connect WebSocket to listen for patient response
      const token = localStorage.getItem('token');
      const client = new Client({
        brokerURL: `wss://${new URL(BASE_URL).host}/ws`,
        connectHeaders: { Authorization: `Bearer ${token}` },
        onConnect: () => {
          // Subscribe to the private queue
          client.subscribe('/user/queue/record/approval', async (message) => {
            const data = JSON.parse(message.body) as RecordApprovalMessage;

            // Handle Denial
            if ('status' in data && data.status === 'DENIED') {
              setState('denied');
              client.deactivate();
              return;
            }

            // Handle Acceptance
            if ('encounterId' in data) {
              setState('decrypting');
              client.deactivate();

              try {
                // A. Retrieve Private Key from IndexedDB
                const privKey = await getPrivateKey();
                if (!privKey) {
                  throw new Error("Security Error: Doctor's Private Key not found on this device.");
                }

                // B. Decrypt the Patient Record (Unified RSA + AES-GCM logic)
                const decryptedJson = await decryptPatientRecord(
                    data.ciphyerText, // Check spelling: 'ciphyerText' matches your DTO
                    data.encrptedAesKey, 
                    privKey
                );
                
                let decryptedMedicalData;
                try {
                    decryptedMedicalData = JSON.parse(decryptedJson);
                } catch (e) {
                    decryptedMedicalData = decryptedJson;
                }

                // C. Build the Active Session State
                const sessionData: ActiveSessionState = {
                  encounterId: data.encounterId,
                  patientId: data.patientId,
                  docId: user?.id ?? 0,
                  docEmail: data.docEmail,
                  basicDataDTO: data.basicDataDTO,
                  decryptedMedicalData,
                  encrptedAESKey: data.encrptedAesKey,
                  originalCipherText: data.ciphyerText,
                  xrayUrls: decryptedMedicalData?.xrayUrls ?? [],
                  prescriptions: [],
                  invoice: '',
                  description: '',
                  nextSessionDate: null,
                  startedAt: Date.now(),
                  aesKeyBytes: undefined
                };

                // D. Activate Session and Navigate
                startSession(sessionData);
                onOpenChange(false);
                navigate('/session');
                toast.success('Session decrypted and started!');

              } catch (cryptoErr: any) {
                console.error('Cryptographic failure:', cryptoErr);
                setErrorMsg(cryptoErr.message || 'Decryption failed. Data might be corrupted.');
                setState('error');
              }
            }
          });
        },
        onStompError: (frame) => {
          console.error('STOMP error:', frame);
          setErrorMsg('Secure connection lost.');
          setState('error');
        },
      });

      client.activate();
      stompClient.current = client;
    } catch (err: any) {
      console.error('Request failed:', err);
      setErrorMsg(err.response?.data?.message || err.message || 'Failed to request access');
      setState('error');
    }
  }, [careTagId, user, startSession, onOpenChange, navigate, cleanup]);

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="max-w-md">
        {state === 'confirm' && (
          <>
            <DialogHeader>
              <DialogTitle>Start Session</DialogTitle>
              <DialogDescription>
                Requesting access to <strong>{patientName}</strong>'s records. 
                They must approve the request on their phone.
              </DialogDescription>
            </DialogHeader>
            <div className="p-4 rounded-lg bg-muted border text-center">
              <p className="font-medium text-lg">{patientName}</p>
              <p className="text-xs text-muted-foreground font-mono mt-1">{careTagId}</p>
            </div>
            <div className="flex gap-3 justify-end">
              <Button variant="outline" onClick={() => handleClose(false)}>Cancel</Button>
              <Button onClick={handleStartSession}>
                <ShieldCheck className="h-4 w-4 mr-2" />
                Request Access
              </Button>
            </div>
          </>
        )}

        {state === 'requesting' && (
          <div className="flex flex-col items-center gap-4 py-8">
            <Loader2 className="h-10 w-10 text-primary animate-spin" />
            <p className="text-sm text-muted-foreground">Initializing handshake...</p>
          </div>
        )}

        {state === 'waiting' && (
          <div className="flex flex-col items-center gap-6 py-8">
            <div className="h-20 w-20 rounded-full border-4 border-primary border-t-transparent animate-spin" />
            <div className="text-center space-y-2">
              <p className="text-lg font-semibold">Awaiting Patient Consent</p>
              <p className="text-sm text-muted-foreground">Check patient device for notification.</p>
            </div>
          </div>
        )}

        {state === 'decrypting' && (
          <div className="flex flex-col items-center gap-4 py-8">
            <ShieldCheck className="h-10 w-10 text-primary animate-bounce" />
            <p className="text-sm text-muted-foreground">Performing RSA/AES-GCM Decryption...</p>
          </div>
        )}

        {state === 'denied' && (
          <div className="flex flex-col items-center gap-4 py-8">
            <XCircle className="h-12 w-12 text-destructive" />
            <p className="text-lg font-semibold text-destructive">Access Denied</p>
            <Button variant="outline" onClick={() => handleClose(false)}>Close</Button>
          </div>
        )}

        {state === 'error' && (
          <div className="flex flex-col items-center gap-4 py-8 text-center">
            <ShieldAlert className="h-12 w-12 text-destructive" />
            <p className="text-lg font-semibold text-destructive">Error</p>
            <p className="text-xs text-muted-foreground max-w-[250px]">{errorMsg}</p>
            <Button onClick={() => setState('confirm')}>Try Again</Button>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}