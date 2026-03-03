import { useEffect, useState, useCallback, useRef } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { CheckCircle2, X, Keyboard, Search, Loader2, ShieldCheck, Smartphone, XCircle, ScanLine } from 'lucide-react';
import { toast } from 'sonner';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { useAccessSession } from '@/hooks/useAccessSession';
import axiosInstance from '@/utils/axiosInstance';
import { Client } from '@stomp/stompjs';

type ScanState =
  | 'idle'
  | 'manual'
  | 'loading'
  | 'waiting'
  | 'accepted'
  | 'rejected'
  | 'already-scanned';

export default function ScanCareTag() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  const expectedCaretagId = searchParams.get('expect')?.toUpperCase() || null;
  const expectedPatientName = searchParams.get('name') || null;
  const expectedPatientId = searchParams.get('id') || null;

  const [scanState, setScanState] = useState<ScanState>('idle');
  const [manualId, setManualId] = useState('');
  const [isSearching, setIsSearching] = useState(false);
  const [rfidBuffer, setRfidBuffer] = useState('');
  const rfidTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  const processingRef = useRef(false);
  const stompClient = useRef<Client | null>(null);
  const { startSession } = useAccessSession();

  // Listen for RFID reader keyboard input
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (scanState === 'manual' || processingRef.current) return;

      if (e.key === 'Enter' && rfidBuffer.length > 0) {
        e.preventDefault();
        const scannedId = rfidBuffer.trim();
        setRfidBuffer('');
        if (scannedId) processScannedId(scannedId);
        return;
      }

      if (/^[a-zA-Z0-9\-]$/.test(e.key)) {
        setRfidBuffer(prev => prev + e.key);
        if (rfidTimeoutRef.current) clearTimeout(rfidTimeoutRef.current);
        rfidTimeoutRef.current = setTimeout(() => setRfidBuffer(''), 100);
      }
    };

    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
      if (rfidTimeoutRef.current) clearTimeout(rfidTimeoutRef.current);
    };
  }, [scanState, rfidBuffer]);

  const processScannedId = useCallback(async (caretagId: string) => {
    if (processingRef.current) return;
    processingRef.current = true;

    try {
      setScanState('loading');

      const response = await axiosInstance.post('/link/request', caretagId, {
        headers: { 'Content-Type': 'text/plain' }
      });
      const { docId } = response.data;
      console.log("response data = ")
      console.log(response.data)
      setScanState('waiting');

      // Always read token AFTER the axios call (it may have been refreshed)
      const token = localStorage.getItem('token');
      const client = new Client({
        brokerURL: 'wss://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/ws',
        connectHeaders: { Authorization: `Bearer ${token}` },
        onConnect: () => {
          client.subscribe('/user/queue/approval', (message) => {
            console.log(message)
            const data = JSON.parse(message.body);
            console.log("Data recevied from the websocket:",data)
            if('DENIED' in  data && data.status === 'DENIED'){
              console.log("DENIEDDDDDDDDDDDDDDDDDD")
            }
            if (data.status === 'APPROVED') {
              setScanState('accepted');
              setTimeout(() => {
                client.deactivate();
                navigate(`/patients/${data.patientId || expectedPatientId || ''}`);
              }, 2000);
            } else if (data.status === 'DENIED') {
              setScanState('rejected');
              client.deactivate();
            }
            else if(data.status === 'ALREADY SCANNED') {
              setScanState('already-scanned');
              client.deactivate();
            }else{
              console.log("fucl");
            }
          });
        }
      });

      client.activate();
      stompClient.current = client;

    } catch (err) {
      toast.error('Scan failed or Patient not found');
      setScanState('idle');
    } finally {
      processingRef.current = false;
    }
  }, [navigate, expectedPatientId]);

  const handleManualSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!manualId.trim()) return;
    setIsSearching(true);
    await processScannedId(manualId.trim());
    setIsSearching(false);
  };

  return (
    <div className="fixed inset-0 bg-background/95 backdrop-blur-sm flex flex-col items-center justify-center z-50">
      <Button
        variant="ghost"
        size="icon"
        onClick={() => { stompClient.current?.deactivate(); navigate(-1); }}
        className="absolute top-6 right-6 h-12 w-12 rounded-full text-muted-foreground hover:text-foreground hover:bg-muted border border-border"
      >
        <X className="h-6 w-6" />
      </Button>

      <div className="flex flex-col items-center gap-8 px-6 max-w-sm w-full">

        {/* Idle - waiting for RFID */}
        {scanState === 'idle' && (
          <>
            <div className="relative flex items-center justify-center">
              <div className="absolute w-40 h-40 rounded-full border-2 border-primary/30 animate-ping" style={{ animationDuration: '2s' }} />
              <div className="absolute w-32 h-32 rounded-full border-2 border-primary/40 animate-pulse" />
              <div className="relative w-24 h-24 rounded-full bg-primary/10 flex items-center justify-center">
                <Smartphone className="h-10 w-10 text-primary animate-pulse" />
              </div>
            </div>
            <div className="text-center space-y-3">
              {expectedPatientName ? (
                <>
                  <h1 className="text-lg font-semibold text-foreground">Verify Patient</h1>
                  <div className="p-3 rounded-lg bg-muted border">
                    <p className="font-medium">{expectedPatientName}</p>
                    <p className="text-xs text-muted-foreground font-mono">{expectedCaretagId}</p>
                  </div>
                  <p className="text-sm text-muted-foreground">Scan this patient's CareTag to access their records</p>
                </>
              ) : (
                <>
                  <h1 className="text-lg font-semibold text-foreground">Ready to Scan</h1>
                  <p className="text-sm text-muted-foreground">Tap the RFID CareTag on the reader</p>
                </>
              )}
              <div className="flex items-center justify-center gap-1 pt-1">
                <span className="w-1.5 h-1.5 rounded-full bg-primary animate-bounce" style={{ animationDelay: '0ms' }} />
                <span className="w-1.5 h-1.5 rounded-full bg-primary animate-bounce" style={{ animationDelay: '150ms' }} />
                <span className="w-1.5 h-1.5 rounded-full bg-primary animate-bounce" style={{ animationDelay: '300ms' }} />
              </div>
              {rfidBuffer && (
                <p className="text-xs text-primary font-mono">Reading: {rfidBuffer}</p>
              )}
            </div>
            <div className="flex flex-col gap-2 w-full max-w-xs">
              <Button onClick={() => setScanState('manual')} variant="outline" className="gap-2 w-full">
                <Keyboard className="h-4 w-4" />
                Enter ID Manually
              </Button>
            </div>
            <p className="text-xs text-muted-foreground text-center max-w-xs">
              Using a USB RFID reader? Just tap the card — it will be detected automatically.
            </p>
          </>
        )}
   {/* Already Scanned */}
        {scanState === 'already-scanned' && (
          <div className="flex flex-col items-center gap-6">
            <div className="relative flex items-center justify-center">
              <div className="absolute w-40 h-40 rounded-full border-2 border-amber-500/30 animate-ping" style={{ animationDuration: '2s' }} />
              <div className="absolute w-32 h-32 rounded-full border-2 border-amber-500/40 animate-pulse" />
              <div className="relative w-24 h-24 rounded-full bg-amber-500/10 flex items-center justify-center">
                <ScanLine className="h-10 w-10 text-amber-500" />
              </div>
            </div>
            <div className="text-center space-y-2">
              <h1 className="text-xl font-bold text-amber-500">Already Scanned</h1>
              <p className="text-sm text-muted-foreground">
                This CareTag has already been scanned and a request is pending.
              </p>
              <p className="text-xs text-muted-foreground">
                Please wait for the existing request to be resolved before scanning again.
              </p>
            </div>
            <div className="flex flex-col gap-2 w-full max-w-xs">
              <Button
                onClick={() => setScanState('idle')}
                className="w-full gap-2 bg-amber-500 hover:bg-amber-600 text-white"
              >
                <ScanLine className="h-4 w-4" />
                Scan Again
              </Button>
              <Button
                variant="ghost"
                onClick={() => { stompClient.current?.deactivate(); navigate(-1); }}
                className="w-full text-muted-foreground"
              >
                Cancel
              </Button>
            </div>
          </div>
        )}
        {/* Manual entry */}
        {scanState === 'manual' && (
          <div className="w-full max-w-xs space-y-6">
            <div className="relative w-24 h-24 mx-auto rounded-full bg-muted flex items-center justify-center">
              <Keyboard className="h-10 w-10 text-muted-foreground" />
            </div>
            <div className="text-center">
              <h1 className="text-lg font-semibold text-foreground">Manual Entry</h1>
              <p className="text-sm text-muted-foreground">Enter the CareTag ID printed on the tag</p>
            </div>
            <form onSubmit={handleManualSearch} className="space-y-3">
              <div className="space-y-2">
                <Label htmlFor="caretag-id" className="text-sm">CareTag ID</Label>
                <Input
                  id="caretag-id"
                  placeholder="e.g., CT-2026-1234"
                  value={manualId}
                  onChange={(e) => setManualId(e.target.value.toUpperCase())}
                  className="text-center font-mono"
                  autoFocus
                />
              </div>
              <Button type="submit" className="w-full gap-2" disabled={!manualId.trim() || isSearching}>
                {isSearching ? <Loader2 className="h-4 w-4 animate-spin" /> : <Search className="h-4 w-4" />}
                {isSearching ? 'Searching...' : 'Search Patient'}
              </Button>
            </form>
            <Button variant="ghost" size="sm" onClick={() => setScanState('idle')} className="w-full text-muted-foreground">
              Back to scanning
            </Button>
          </div>
        )}

        {/* Loading */}
        {scanState === 'loading' && (
          <>
            <div className="relative w-24 h-24 rounded-full bg-primary/10 flex items-center justify-center">
              <Loader2 className="h-10 w-10 text-primary animate-spin" />
            </div>
            <div className="text-center space-y-2">
              <h1 className="text-lg font-semibold text-foreground">Processing...</h1>
              <p className="text-sm text-muted-foreground">Looking up patient record</p>
            </div>
          </>
        )}

        {/* Waiting for patient consent */}
        {scanState === 'waiting' && (
          <div className="flex flex-col items-center gap-6">
            <div className="h-24 w-24 rounded-full border-4 border-primary border-t-transparent animate-spin" />
            <div className="text-center space-y-2">
              <h1 className="text-xl font-bold">Awaiting Consent...</h1>
              <p className="text-sm text-muted-foreground">The patient must tap "Accept" on their phone.</p>
            </div>
            <Button variant="ghost" onClick={() => { stompClient.current?.deactivate(); setScanState('idle'); }}>
              Cancel Request
            </Button>
          </div>
        )}

        {/* Accepted */}
        {scanState === 'accepted' && (
          <div className="flex flex-col items-center gap-4">
            <CheckCircle2 className="h-12 w-12 text-success" />
            <h1 className="text-lg font-semibold text-success">Access Accepted</h1>
            <p className="text-sm text-muted-foreground">Redirecting to patient record...</p>
          </div>
        )}

        {/* Rejected */}
        {scanState === 'rejected' && (
          <div className="flex flex-col items-center gap-4">
            <XCircle className="h-12 w-12 text-destructive" />
            <h1 className="text-lg font-semibold text-destructive">Access Rejected</h1>
            <p className="text-sm text-muted-foreground">Patient denied the request.</p>
            <Button onClick={() => setScanState('idle')}>Back to Scan</Button>
          </div>
        )}

      </div>
    </div>
  );
}
