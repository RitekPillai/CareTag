import { createContext, useContext, useState, useCallback, ReactNode } from 'react';
import type { ActiveSessionState, SessionPrescription } from '@/types/session.types';

interface SessionContextValue {
  session: ActiveSessionState | null;
  isSessionActive: boolean;
  startSession: (data: ActiveSessionState) => void;
  updatePrescriptions: (prescriptions: SessionPrescription[]) => void;
  updateSessionField: (updates: Partial<Pick<ActiveSessionState, 'invoice' | 'description' | 'nextSessionDate'>>) => void;
  endSession: () => void;
}

const SessionContext = createContext<SessionContextValue | undefined>(undefined);

export function SessionProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<ActiveSessionState | null>(null);

  const startSession = useCallback((data: ActiveSessionState) => {
    setSession(data);
  }, []);

  const updatePrescriptions = useCallback((prescriptions: SessionPrescription[]) => {
    setSession((prev) => {
      if (!prev) return prev;
      return { ...prev, prescriptions };
    });
  }, []);

  const updateSessionField = useCallback(
    (updates: Partial<Pick<ActiveSessionState, 'invoice' | 'description' | 'nextSessionDate'>>) => {
      setSession((prev) => {
        if (!prev) return prev;
        return { ...prev, ...updates };
      });
    },
    []
  );

  const endSession = useCallback(() => {
    setSession((prev) => {
      // Zero out the AES key bytes for defense-in-depth
      if (prev?.aesKeyBytes) {
        try {
          new Uint8Array(prev.aesKeyBytes).fill(0);
        } catch {
          // ArrayBuffer may already be detached
        }
      }
      return null;
    });
  }, []);

  return (
    <SessionContext.Provider
      value={{
        session,
        isSessionActive: session !== null,
        startSession,
        updatePrescriptions,
        updateSessionField,
        endSession,
      }}
    >
      {children}
    </SessionContext.Provider>
  );
}

export function useSession() {
  const context = useContext(SessionContext);
  if (!context) {
    throw new Error('useSession must be used within a SessionProvider');
  }
  return context;
}
