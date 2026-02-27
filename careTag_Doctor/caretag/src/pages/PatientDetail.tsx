import { useParams, useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { User, Heart, AlertTriangle, FileText, Pill, Activity, Calendar, Phone, Mail, MapPin, Clock, FlaskConical, UserCheck, Plus, ShieldAlert, ShieldCheck, ScanLine, LogOut } from 'lucide-react';
import { format, differenceInYears } from 'date-fns';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';
import { AIHealthInsights } from '@/components/patients/AIHealthInsights';
import { SmartDiagnosis } from '@/components/patients/SmartDiagnosis';
import { Telemedicine } from '@/components/telemedicine/Telemedicine';
import { MedicalHistoryTimeline } from '@/components/patients/MedicalHistoryTimeline';
import { VoiceToText } from '@/components/voice/VoiceToText';
import { VoiceNotesHistory } from '@/components/voice/VoiceNotesHistory';
import { LabResultsPanel } from '@/components/lab-results/LabResultsPanel';
import { ReferralManagement } from '@/components/referrals/ReferralManagement';
import { NewPrescriptionForm } from '@/components/prescriptions/NewPrescriptionForm';
import { Dialog, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { Textarea } from '@/components/ui/textarea';
import { useState } from 'react';

// ─── HARDCODED MOCK DATA ───────────────────────────────────────────────────────
const MOCK_PATIENT = {
  id: 'mock-001',
  full_name: 'Ahmed Ali Khan',
  caretag_id: 'CT-2024-00123',
  date_of_birth: '1990-05-15',
  gender: 'Male',
  blood_group: 'B+',
  phone: '+92 300 1234567',
  email: 'ahmed.khan@email.com',
  address: 'House 12, Block C, Gulberg III, Lahore',
  allergies: ['Penicillin', 'Aspirin'],
  chronic_conditions: ['Type 2 Diabetes', 'Hypertension'],
  current_medications: ['Metformin 500mg', 'Amlodipine 5mg', 'Lisinopril 10mg'],
  emergency_contact_name: 'Sara Khan (Wife)',
  emergency_contact_phone: '+92 301 7654321',
  insurance_provider: 'State Life Insurance',
  insurance_id: 'SLI-9988776',
};

const MOCK_VITALS = [
  { id: '1', recorded_at: '2024-11-01T08:00:00Z', heart_rate: 78, blood_pressure_systolic: 130, blood_pressure_diastolic: 85, spo2: 97, temperature: '98.6' },
  { id: '2', recorded_at: '2024-11-15T09:00:00Z', heart_rate: 82, blood_pressure_systolic: 128, blood_pressure_diastolic: 82, spo2: 98, temperature: '98.4' },
  { id: '3', recorded_at: '2024-12-01T10:00:00Z', heart_rate: 76, blood_pressure_systolic: 125, blood_pressure_diastolic: 80, spo2: 99, temperature: '98.7' },
  { id: '4', recorded_at: '2024-12-15T11:00:00Z', heart_rate: 80, blood_pressure_systolic: 122, blood_pressure_diastolic: 78, spo2: 98, temperature: '98.5' },
];

const MOCK_MEDICAL_RECORDS = [
  {
    id: 'r1', record_type: 'Consultation', created_at: '2024-12-10T00:00:00Z',
    diagnosis: 'Type 2 Diabetes - Follow Up',
    symptoms: ['Increased thirst', 'Fatigue'],
    notes: 'Blood sugar levels improving. Continue current medication.',
  },
  {
    id: 'r2', record_type: 'Emergency Visit', created_at: '2024-11-05T00:00:00Z',
    diagnosis: 'Hypertensive Episode',
    symptoms: ['Severe headache', 'Dizziness', 'Nausea'],
    notes: 'BP was 160/100. Administered IV medication. Stabilized within 2 hours.',
  },
];

const MOCK_PRESCRIPTIONS = [
  {
    id: 'p1', status: 'active', created_at: '2024-12-10T00:00:00Z',
    diagnosis: 'Type 2 Diabetes',
    medications: [
      { name: 'Metformin', dosage: '500mg', frequency: 'Twice daily', duration: '3 months' },
      { name: 'Glucophage', dosage: '1000mg', frequency: 'Once at night', duration: '3 months' },
    ],
    notes: 'Take with meals. Monitor blood sugar daily.',
  },
  {
    id: 'p2', status: 'completed', created_at: '2024-10-01T00:00:00Z',
    diagnosis: 'Hypertension',
    medications: [
      { name: 'Amlodipine', dosage: '5mg', frequency: 'Once daily', duration: '1 month' },
    ],
    notes: 'Completed. Switched to Lisinopril.',
  },
];

const MOCK_SESSION = {
  id: 'session-001',
  started_at: new Date().toISOString(),
  patient_id: 'mock-001',
};
// ──────────────────────────────────────────────────────────────────────────────

export default function PatientDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [sessionNotes, setSessionNotes] = useState('');
  const [showEndDialog, setShowEndDialog] = useState(false);

  // ── Using mock data instead of Supabase ──
  const patient = MOCK_PATIENT;
  const vitals = MOCK_VITALS;
  const medicalRecords = MOCK_MEDICAL_RECORDS;
  const prescriptions = MOCK_PRESCRIPTIONS;
  const activeSession = MOCK_SESSION;
  const hasActiveSession = true;
  const patientLoading = false;
  const sessionLoading = false;
  const recordsLoading = false;
  const prescriptionsLoading = false;
  const vitalsLoading = false;
  const isEnding = false;

  const handleEndSession = () => {
    setShowEndDialog(false);
    navigate('/patients');
  };

  const age = differenceInYears(new Date(), new Date(patient.date_of_birth));

  const vitalsChartData = vitals.map(v => ({
    date: format(new Date(v.recorded_at), 'MMM d'),
    heartRate: v.heart_rate,
    systolic: v.blood_pressure_systolic,
    diastolic: v.blood_pressure_diastolic,
    spo2: v.spo2,
    temperature: v.temperature ? Number(v.temperature) : null,
  }));

  return (
    <div className="space-y-6">
      {/* Active Session Banner */}
      <Card className="border-primary/30 bg-primary/5">
        <CardContent className="p-4 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <ShieldCheck className="h-5 w-5 text-primary" />
            <div>
              <p className="font-medium text-sm">Active Access Session</p>
              <p className="text-xs text-muted-foreground">
                Started {format(new Date(activeSession.started_at), 'h:mm a')}
              </p>
            </div>
          </div>
          <Dialog open={showEndDialog} onOpenChange={setShowEndDialog}>
            <DialogTrigger asChild>
              <Button variant="outline" size="sm" className="gap-2">
                <LogOut className="h-4 w-4" />
                End Session
              </Button>
            </DialogTrigger>
            <DialogContent>
              <DialogHeader>
                <DialogTitle>End Access Session</DialogTitle>
                <DialogDescription>
                  This will end your access to {patient.full_name}'s records.
                </DialogDescription>
              </DialogHeader>
              <Textarea
                placeholder="Optional session notes..."
                value={sessionNotes}
                onChange={(e) => setSessionNotes(e.target.value)}
                rows={4}
              />
              <DialogFooter>
                <Button variant="outline" onClick={() => setShowEndDialog(false)}>Cancel</Button>
                <Button onClick={handleEndSession}>End Session</Button>
              </DialogFooter>
            </DialogContent>
          </Dialog>
        </CardContent>
      </Card>

      {/* Patient Header */}
      <div className="flex items-start justify-between">
        <div className="flex items-center gap-4">
          <div className="h-16 w-16 rounded-full bg-primary/10 flex items-center justify-center">
            <User className="h-8 w-8 text-primary" />
          </div>
          <div>
            <h1 className="text-3xl font-bold">{patient.full_name}</h1>
            <p className="text-muted-foreground">{patient.caretag_id} • Age {age} • {patient.gender}</p>
          </div>
        </div>
        <div className="flex items-center gap-2">
          <Badge variant="secondary">{patient.chronic_conditions?.length ? 'Has Conditions' : 'Healthy'}</Badge>
        </div>
      </div>

      {/* Emergency Info Card */}
      <Card className="border-destructive/30 bg-destructive/5">
        <CardHeader className="pb-2">
          <CardTitle className="text-destructive flex items-center gap-2">
            <AlertTriangle className="h-5 w-5" />Emergency Info
          </CardTitle>
        </CardHeader>
        <CardContent className="flex flex-wrap gap-6 text-sm">
          <div><span className="text-muted-foreground">Blood:</span> <strong>{patient.blood_group}</strong></div>
          <div><span className="text-muted-foreground">Allergies:</span> <strong className="text-destructive">{patient.allergies.join(', ')}</strong></div>
          <div><span className="text-muted-foreground">Conditions:</span> <strong>{patient.chronic_conditions.join(', ')}</strong></div>
          <div><span className="text-muted-foreground">Emergency Contact:</span> <strong>{patient.emergency_contact_name} ({patient.emergency_contact_phone})</strong></div>
        </CardContent>
      </Card>

      {/* Tabs */}
      <Tabs defaultValue="overview">
        <TabsList className="h-auto gap-1 bg-muted/50 p-1.5 flex-wrap">
          <TabsTrigger value="overview" className="rounded-full px-4 py-1.5 text-xs font-medium data-[state=active]:bg-primary data-[state=active]:text-primary-foreground">Overview</TabsTrigger>
          <TabsTrigger value="history" className="rounded-full px-4 py-1.5 text-xs font-medium data-[state=active]:bg-primary data-[state=active]:text-primary-foreground">Medical History</TabsTrigger>
          <TabsTrigger value="prescriptions" className="rounded-full px-4 py-1.5 text-xs font-medium data-[state=active]:bg-primary data-[state=active]:text-primary-foreground">Prescriptions</TabsTrigger>
          <TabsTrigger value="vitals" className="rounded-full px-4 py-1.5 text-xs font-medium data-[state=active]:bg-primary data-[state=active]:text-primary-foreground">Vitals Timeline</TabsTrigger>
        </TabsList>

        {/* Overview Tab */}
        <TabsContent value="overview" className="space-y-4 mt-4">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <Card>
              <CardHeader><CardTitle className="text-base flex items-center gap-2"><Phone className="h-4 w-4" /> Contact Info</CardTitle></CardHeader>
              <CardContent className="text-sm space-y-2">
                <p className="flex items-center gap-2"><Phone className="h-3 w-3 text-muted-foreground" /> {patient.phone}</p>
                <p className="flex items-center gap-2"><Mail className="h-3 w-3 text-muted-foreground" /> {patient.email}</p>
                <p className="flex items-center gap-2"><MapPin className="h-3 w-3 text-muted-foreground" /> {patient.address}</p>
              </CardContent>
            </Card>
            <Card>
              <CardHeader><CardTitle className="text-base flex items-center gap-2"><Pill className="h-4 w-4" /> Current Medications</CardTitle></CardHeader>
              <CardContent className="text-sm space-y-1">
                {patient.current_medications.map((med, i) => <p key={i}>• {med}</p>)}
              </CardContent>
            </Card>
            <Card>
              <CardHeader><CardTitle className="text-base">Insurance</CardTitle></CardHeader>
              <CardContent className="text-sm space-y-1">
                <p>Provider: {patient.insurance_provider}</p>
                <p>ID: {patient.insurance_id}</p>
              </CardContent>
            </Card>
            <Card>
              <CardHeader><CardTitle className="text-base">Latest Vitals</CardTitle></CardHeader>
              <CardContent className="text-sm">
                <div className="grid grid-cols-2 gap-2">
                  <p>HR: <strong>{vitals[vitals.length - 1].heart_rate} bpm</strong></p>
                  <p>BP: <strong>{vitals[vitals.length - 1].blood_pressure_systolic}/{vitals[vitals.length - 1].blood_pressure_diastolic}</strong></p>
                  <p>SpO2: <strong>{vitals[vitals.length - 1].spo2}%</strong></p>
                  <p>Temp: <strong>{vitals[vitals.length - 1].temperature}°F</strong></p>
                </div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        {/* Medical History Tab */}
        <TabsContent value="history" className="mt-4">
          <Card>
            <CardHeader><CardTitle className="flex items-center gap-2"><FileText className="h-5 w-5" /> Medical Records</CardTitle></CardHeader>
            <CardContent>
              <div className="space-y-4">
                {medicalRecords.map((record) => (
                  <div key={record.id} className="border rounded-lg p-4 space-y-2">
                    <div className="flex items-center justify-between">
                      <Badge variant="outline">{record.record_type}</Badge>
                      <span className="text-sm text-muted-foreground flex items-center gap-1">
                        <Calendar className="h-3 w-3" /> {format(new Date(record.created_at), 'MMM d, yyyy')}
                      </span>
                    </div>
                    {record.diagnosis && <p><strong>Diagnosis:</strong> {record.diagnosis}</p>}
                    {record.symptoms?.length > 0 && <p><strong>Symptoms:</strong> {record.symptoms.join(', ')}</p>}
                    {record.notes && <p className="text-sm text-muted-foreground">{record.notes}</p>}
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Prescriptions Tab */}
        <TabsContent value="prescriptions" className="mt-4">
          <Card>
            <CardHeader><CardTitle className="flex items-center gap-2"><Pill className="h-5 w-5" /> Prescriptions</CardTitle></CardHeader>
            <CardContent>
              <div className="space-y-4">
                {prescriptions.map((rx) => (
                  <div key={rx.id} className="border rounded-lg p-4 space-y-2">
                    <div className="flex items-center justify-between">
                      <Badge variant={rx.status === 'active' ? 'default' : 'secondary'}>{rx.status}</Badge>
                      <span className="text-sm text-muted-foreground flex items-center gap-1">
                        <Clock className="h-3 w-3" /> {format(new Date(rx.created_at), 'MMM d, yyyy')}
                      </span>
                    </div>
                    {rx.diagnosis && <p><strong>For:</strong> {rx.diagnosis}</p>}
                    <div className="space-y-1">
                      {rx.medications.map((med, i) => (
                        <p key={i} className="text-sm bg-muted/50 rounded px-2 py-1">
                          <strong>{med.name}</strong> - {med.dosage}, {med.frequency} for {med.duration}
                        </p>
                      ))}
                    </div>
                    {rx.notes && <p className="text-sm text-muted-foreground">{rx.notes}</p>}
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        {/* Vitals Timeline Tab */}
        <TabsContent value="vitals" className="mt-4">
          <Card>
            <CardHeader><CardTitle className="flex items-center gap-2"><Activity className="h-5 w-5" /> Vitals Timeline</CardTitle></CardHeader>
            <CardContent>
              <div className="h-80">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={vitalsChartData}>
                    <CartesianGrid strokeDasharray="3 3" className="stroke-muted" />
                    <XAxis dataKey="date" className="text-xs" />
                    <YAxis className="text-xs" />
                    <Tooltip contentStyle={{ backgroundColor: 'hsl(var(--card))', border: '1px solid hsl(var(--border))' }} />
                    <Legend />
                    <Line type="monotone" dataKey="heartRate" stroke="hsl(var(--destructive))" name="Heart Rate" strokeWidth={2} dot={{ r: 3 }} />
                    <Line type="monotone" dataKey="systolic" stroke="hsl(var(--primary))" name="Systolic BP" strokeWidth={2} dot={{ r: 3 }} />
                    <Line type="monotone" dataKey="spo2" stroke="#22c55e" name="SpO2" strokeWidth={2} dot={{ r: 3 }} />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
