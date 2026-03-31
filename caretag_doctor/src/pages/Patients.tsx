import { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Search, ScanLine, Users, Loader2, Activity } from 'lucide-react';
import { toast } from 'sonner';
import axiosInstance from '@/utils/axiosInstance';
import { useSession } from '@/context/SessionContext';
import StartSessionDialog from '@/components/session/StartSessionDialog';

interface PatientResult {
  careTagId: string;
  paitentName: string;
}

export default function Patients() {
  const navigate = useNavigate();
  const { isSessionActive, session } = useSession();
  const [search, setSearch] = useState('');
  const [patients, setPatients] = useState<PatientResult[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [hasSearched, setHasSearched] = useState(false);
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  // Session dialog state
  const [selectedPatient, setSelectedPatient] = useState<{
    name: string;
    careTagId: string;
  } | null>(null);

  // Debounced search
  useEffect(() => {
    if (debounceRef.current) clearTimeout(debounceRef.current);

    if (!search.trim()) {
      setPatients([]);
      setHasSearched(false);
      return;
    }

    setIsLoading(true);
    debounceRef.current = setTimeout(async () => {
      try {
        const response = await axiosInstance.post('/doctor/search', search, {
          headers: { 'Content-Type': 'text/plain' },
        });
        const data = Array.isArray(response.data) ? response.data : [];
        console.log(data)
        setPatients(
          data.map((p: any) => ({
            careTagId: p.careTagId ?? '',
            paitentName: p.paitentName ?? '',
          }))
        );
      } catch {
        setPatients([]);
      } finally {
        setIsLoading(false);
        setHasSearched(true);
      }
    }, 500);

    return () => {
      if (debounceRef.current) clearTimeout(debounceRef.current);
    };
  }, [search]);

  const handlePatientClick = (patient: PatientResult) => {
    if (isSessionActive) {
      toast.error('End current session before starting a new one');
      return;
    }
    setSelectedPatient({
      name: patient.paitentName,
      careTagId: patient.careTagId,
    });
  };

  return (
    <div className="space-y-6">
      {/* Active Session Banner */}
      {isSessionActive && session && (
        <div
          onClick={() => navigate('/session')}
          className="flex items-center justify-between p-4 rounded-lg bg-destructive/10 border border-destructive/20 cursor-pointer hover:bg-destructive/15 transition-colors"
        >
          <div className="flex items-center gap-3">
            <div className="h-2.5 w-2.5 rounded-full bg-destructive animate-pulse" />
            <div>
              <p className="text-sm font-medium text-destructive">
                Session active with {session.basicDataDTO.fullName}
              </p>
              <p className="text-xs text-destructive/70">
                Click to return to active session
              </p>
            </div>
          </div>
          <Activity className="h-5 w-5 text-destructive" />
        </div>
      )}

      {/* Header */}
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold">Patients</h1>
          <p className="text-muted-foreground text-sm mt-1">
            Search for a patient to start a session
          </p>
        </div>
        <Button
          className="gap-2"
          onClick={() => navigate('/scan')}
          disabled={isSessionActive}
        >
          <ScanLine className="h-4 w-4" />
          Scan CareTag
        </Button>
      </div>

      {/* Search */}
      <div className="relative flex-1 max-w-md">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <Input
          placeholder="Search by name or CareTag ID..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="pl-10"
          autoFocus
        />
      </div>

      {/* Loading */}
      {isLoading && (
        <div className="flex items-center justify-center py-8">
          <Loader2 className="h-6 w-6 animate-spin text-primary" />
          <span className="ml-2 text-sm text-muted-foreground">Searching...</span>
        </div>
      )}

      {/* Patient Grid */}
      {!isLoading && patients.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {patients.map((patient) => (
           <Card
  key={patient.careTagId}
  className="transition-all cursor-pointer hover:border-primary/50 hover:shadow-md min-h-[100px]" // Added min-h for consistency
  onClick={() => handlePatientClick(patient)}
>
  <CardContent className="p-4">
    <div className="flex items-center gap-3 w-full"> {/* Changed items-start to items-center for better alignment */}
      
      {/* 1. Avatar: Fixed width to prevent shrinking */}
      <div className="h-10 w-10 rounded-lg bg-muted flex items-center justify-center flex-shrink-0">
        <span className="font-medium text-xs text-muted-foreground uppercase">
          {patient.paitentName
            .split(' ')
            .filter(Boolean) // Handle extra spaces
            .map((n) => n[0])
            .slice(0, 2) // Limit to 2 characters
            .join('')}
        </span>
      </div>

      {/* 2. Text Container: flex-1 and min-w-0 are the "Magic" classes for truncation */}
      <div className="flex-1 min-w-0 overflow-hidden">
        <div className="flex flex-col"> {/* Use column for name and ID */}
          <p className="font-medium text-sm leading-tight truncate" title={patient.paitentName}>
            {patient.paitentName}
          </p>
          <p className="text-[10px] text-muted-foreground font-mono truncate">
            {patient.careTagId}
          </p>
        </div>
      </div>

      {/* 3. Badge: flex-shrink-0 ensures the badge doesn't get crushed */}
      <Badge
        variant="outline"
        className="flex-shrink-0 text-[10px] ml-auto whitespace-nowrap"
      >
        Start
      </Badge>
    </div>
  </CardContent>
</Card>          ))}
        </div>
      )}

      {/* Empty state */}
      {!isLoading && patients.length === 0 && (
        <Card>
          <CardContent className="py-16 text-center">
            <Users className="h-10 w-10 text-muted-foreground/50 mx-auto mb-4" />
            <h3 className="text-lg font-medium">
              {hasSearched ? 'No patients found' : 'Search for a patient'}
            </h3>
            <p className="text-muted-foreground mt-1 max-w-md mx-auto text-sm">
              {hasSearched
                ? 'Try a different search term or scan a CareTag.'
                : 'Enter a patient name or CareTag ID above to search.'}
            </p>
            {hasSearched && (
              <Button
                className="gap-2 mt-4"
                onClick={() => navigate('/scan')}
                disabled={isSessionActive}
              >
                <ScanLine className="h-4 w-4" /> Scan CareTag
              </Button>
            )}
          </CardContent>
        </Card>
      )}

      {/* Start Session Dialog */}
      <StartSessionDialog
        open={!!selectedPatient}
        onOpenChange={(open) => {
          if (!open) setSelectedPatient(null);
        }}
        patientName={selectedPatient?.name ?? ''}
        careTagId={selectedPatient?.careTagId ?? ''}
      />
    </div>
  );
}
