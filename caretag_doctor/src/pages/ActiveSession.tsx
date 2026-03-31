import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  User,
  FileText,
  Pill,
  Image,
  StopCircle,
  AlertTriangle,
  Timer,
} from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { useSession } from '@/context/SessionContext';
import { useSessionTimer } from '@/hooks/useSessionTimer';
import PatientInfoCard from '@/components/session/PatientInfoCard';
import SessionPrescriptionForm from '@/components/session/SessionPrescriptionForm';

export default function ActiveSession() {
  const navigate = useNavigate();
  const { session, isSessionActive } = useSession();
  const elapsed = useSessionTimer(session?.startedAt ?? null);

  // Guard: redirect if no active session
  useEffect(() => {
    if (!isSessionActive) {
      navigate('/patients', { replace: true });
    }
  }, [isSessionActive, navigate]);

  if (!session) return null;

  const { basicDataDTO, decryptedMedicalData, xrayUrls, prescriptions } =
    session;

  return (
    <div className="space-y-6 max-w-5xl mx-auto">
      {/* Session Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="h-2.5 w-2.5 rounded-full bg-destructive animate-pulse" />
          <div>
            <h1 className="text-2xl font-bold">Active Session</h1>
            <div className="flex items-center gap-2 text-sm text-muted-foreground mt-0.5">
              <Timer className="h-3.5 w-3.5" />
              <span className="font-mono">{elapsed}</span>
              <span>with</span>
              <span className="font-medium text-foreground">
                {basicDataDTO.fullName}
              </span>
            </div>
          </div>
        </div>
        <Button
          variant="destructive"
          onClick={() => navigate('/session/end')}
          className="gap-2"
        >
          <StopCircle className="h-4 w-4" />
          End Session
        </Button>
      </div>

      {/* Tabs */}
      <Tabs defaultValue="patient" className="space-y-4">
        <TabsList className="grid w-full grid-cols-4">
          <TabsTrigger value="patient" className="gap-1.5">
            <User className="h-4 w-4" />
            <span className="hidden sm:inline">Patient</span>
          </TabsTrigger>
          <TabsTrigger value="records" className="gap-1.5">
            <FileText className="h-4 w-4" />
            <span className="hidden sm:inline">Records</span>
          </TabsTrigger>
          <TabsTrigger value="reports" className="gap-1.5">
            <Image className="h-4 w-4" />
            <span className="hidden sm:inline">Reports</span>
          </TabsTrigger>
          <TabsTrigger value="prescriptions" className="gap-1.5 relative">
            <Pill className="h-4 w-4" />
            <span className="hidden sm:inline">Prescriptions</span>
            {prescriptions.length > 0 && (
              <Badge
                variant="secondary"
                className="absolute -top-1 -right-1 h-5 w-5 p-0 flex items-center justify-center text-[10px]"
              >
                {prescriptions.length}
              </Badge>
            )}
          </TabsTrigger>
        </TabsList>

        {/* Patient Info Tab */}
        <TabsContent value="patient" className="space-y-4">
          <PatientInfoCard data={basicDataDTO} />
        </TabsContent>

        {/* Medical Records Tab */}
        <TabsContent value="records" className="space-y-4">
          {decryptedMedicalData ? (
            <Card>
              <CardHeader>
                <CardTitle className="text-base flex items-center gap-2">
                  <FileText className="h-4 w-4 text-blue-500" />
                  Medical Records
                </CardTitle>
              </CardHeader>
              <CardContent>
                {typeof decryptedMedicalData === 'string' ? (
                  <p className="text-sm whitespace-pre-wrap">
                    {decryptedMedicalData}
                  </p>
                ) : (
                  <div className="space-y-4">
                    {/* Render known fields if they exist */}
                    {decryptedMedicalData.allergies && (
                      <div>
                        <p className="text-sm font-medium flex items-center gap-1.5 mb-1">
                          <AlertTriangle className="h-4 w-4 text-destructive" />
                          Allergies
                        </p>
                        <p className="text-sm text-muted-foreground">
                          {typeof decryptedMedicalData.allergies === 'string'
                            ? decryptedMedicalData.allergies
                            : JSON.stringify(decryptedMedicalData.allergies)}
                        </p>
                      </div>
                    )}
                    {decryptedMedicalData.conditions && (
                      <div>
                        <p className="text-sm font-medium mb-1">
                          Chronic Conditions
                        </p>
                        <p className="text-sm text-muted-foreground">
                          {typeof decryptedMedicalData.conditions === 'string'
                            ? decryptedMedicalData.conditions
                            : JSON.stringify(decryptedMedicalData.conditions)}
                        </p>
                      </div>
                    )}
                    {decryptedMedicalData.medications && (
                      <div>
                        <p className="text-sm font-medium mb-1">
                          Current Medications
                        </p>
                        <p className="text-sm text-muted-foreground">
                          {typeof decryptedMedicalData.medications === 'string'
                            ? decryptedMedicalData.medications
                            : JSON.stringify(decryptedMedicalData.medications)}
                        </p>
                      </div>
                    )}
                    {/* Render all other fields as key-value pairs */}
                    {Object.entries(decryptedMedicalData)
                      .filter(
                        ([key]) =>
                          !['allergies', 'conditions', 'medications', 'xrayUrls'].includes(key)
                      )
                      .map(([key, value]) => (
                        <div key={key}>
                          <p className="text-sm font-medium mb-1 capitalize">
                            {key.replace(/([A-Z])/g, ' $1').trim()}
                          </p>
                          <p className="text-sm text-muted-foreground">
                            {typeof value === 'string'
                              ? value
                              : JSON.stringify(value, null, 2)}
                          </p>
                        </div>
                      ))}
                  </div>
                )}
              </CardContent>
            </Card>
          ) : (
            <Card>
              <CardContent className="py-16 text-center">
                <FileText className="h-10 w-10 text-muted-foreground/50 mx-auto mb-4" />
                <h3 className="text-lg font-medium">No Medical Records</h3>
                <p className="text-sm text-muted-foreground mt-1">
                  No decrypted medical data available for this patient.
                </p>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        {/* Reports Tab (X-rays, PDFs, images) */}
        <TabsContent value="reports" className="space-y-4">
          {xrayUrls && xrayUrls.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              {xrayUrls.map((url, index) => {
                const isPdf = url.toLowerCase().endsWith('.pdf');
                return (
                  <Card key={index}>
                    <CardContent className="p-4">
                      {isPdf ? (
                        <div className="space-y-2">
                          <div className="flex items-center gap-2">
                            <FileText className="h-5 w-5 text-blue-500" />
                            <span className="text-sm font-medium">
                              Report {index + 1}
                            </span>
                          </div>
                          <iframe
                            src={url}
                            className="w-full h-64 rounded border"
                            title={`Report ${index + 1}`}
                          />
                          <Button
                            variant="outline"
                            size="sm"
                            className="w-full"
                            onClick={() => window.open(url, '_blank')}
                          >
                            Open Full Report
                          </Button>
                        </div>
                      ) : (
                        <div className="space-y-2">
                          <span className="text-sm font-medium">
                            Image {index + 1}
                          </span>
                          <img
                            src={url}
                            alt={`Report ${index + 1}`}
                            className="w-full rounded border object-contain max-h-64"
                          />
                          <Button
                            variant="outline"
                            size="sm"
                            className="w-full"
                            onClick={() => window.open(url, '_blank')}
                          >
                            View Full Size
                          </Button>
                        </div>
                      )}
                    </CardContent>
                  </Card>
                );
              })}
            </div>
          ) : (
            <Card>
              <CardContent className="py-16 text-center">
                <Image className="h-10 w-10 text-muted-foreground/50 mx-auto mb-4" />
                <h3 className="text-lg font-medium">No Reports Available</h3>
                <p className="text-sm text-muted-foreground mt-1">
                  No X-rays, images, or PDF reports found for this patient.
                </p>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        {/* Prescriptions Tab */}
        <TabsContent value="prescriptions" className="space-y-4">
          <SessionPrescriptionForm />
        </TabsContent>
      </Tabs>
    </div>
  );
}
