import { useNavigate } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { ArrowLeft, Users } from 'lucide-react';
import { useSession } from '@/context/SessionContext';

export default function PatientDetail() {
  const navigate = useNavigate();
  const { isSessionActive } = useSession();

  return (
    <div className="flex flex-col items-center justify-center py-24 gap-4">
      <Card>
        <CardContent className="py-12 px-8 text-center">
          <Users className="h-10 w-10 text-muted-foreground/50 mx-auto mb-4" />
          <h3 className="text-lg font-medium">
            {isSessionActive
              ? 'Session Already Active'
              : 'Start a Session to View Patient Records'}
          </h3>
          <p className="text-muted-foreground mt-2 max-w-md text-sm">
            {isSessionActive
              ? 'You have an active session. Return to it or end it before starting a new one.'
              : 'Search for a patient on the Patients page and start a session to access their medical records.'}
          </p>
          <div className="flex gap-3 justify-center mt-4">
            {isSessionActive ? (
              <Button onClick={() => navigate('/session')}>
                Go to Active Session
              </Button>
            ) : (
              <Button
                variant="outline"
                onClick={() => navigate('/patients')}
                className="gap-2"
              >
                <ArrowLeft className="h-4 w-4" /> Go to Patients
              </Button>
            )}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
