import { useParams, useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { ArrowLeft, Phone, User, Droplets, Pill, AlertTriangle, Stethoscope, FileText, Heart } from 'lucide-react';

// ── MOCK FULL PATIENT RECORDS ──────────────────────────────────────────────
// Backend TODO: SELECT * FROM patients
//               JOIN medical_records ON patients.id = medical_records.patient_id
//               WHERE patients.id = :id
const MOCK_PATIENT_RECORDS: Record<string, any> = {
  'patient-001': {
    full_name: 'Ali Hassan', caretag_id: 'CT-1001',
    date_of_birth: '1985-03-12', gender: 'Male', blood_type: 'O+', phone: '+60-12-1234567',
    emergency_contact_name: 'Sara Hassan', emergency_contact_phone: '+60-12-3456789',
    allergies: ['Penicillin', 'Shellfish'],
    chronic_conditions: ['Type 2 Diabetes', 'Hypertension'],
    current_medications: [
      { name: 'Metformin', dose: '500mg', frequency: 'Twice daily' },
      { name: 'Amlodipine', dose: '5mg', frequency: 'Once daily' },
    ],
    past_surgeries: ['Appendectomy (2010)', 'Knee arthroscopy (2018)'],
    recent_visits: [
      { date: '2024-11-20', reason: 'Routine checkup', doctor: 'Dr. Lim' },
      { date: '2024-09-05', reason: 'Blood sugar review', doctor: 'Dr. Lim' },
    ],
    notes: 'Patient is compliant with medication. Monitor HbA1c every 3 months.',
  },
  'patient-002': {
    full_name: 'Nurul Aina', caretag_id: 'CT-1002',
    date_of_birth: '1992-07-25', gender: 'Female', blood_type: 'A+', phone: '+60-11-9876543',
    emergency_contact_name: 'Ahmad Aina', emergency_contact_phone: '+60-11-9876543',
    allergies: ['Latex'],
    chronic_conditions: ['Asthma'],
    current_medications: [{ name: 'Salbutamol inhaler', dose: '100mcg', frequency: 'As needed' }],
    past_surgeries: [],
    recent_visits: [{ date: '2024-12-01', reason: 'Asthma review', doctor: 'Dr. Tan' }],
    notes: 'Carry inhaler at all times. Avoid cold air triggers.',
  },
  'patient-003': {
    full_name: 'Ravi Kumar', caretag_id: 'CT-1003',
    date_of_birth: '1978-01-30', gender: 'Male', blood_type: 'B+', phone: '+60-16-1112233',
    emergency_contact_name: 'Priya Kumar', emergency_contact_phone: '+60-16-1112233',
    allergies: [],
    chronic_conditions: ['Chronic back pain'],
    current_medications: [{ name: 'Ibuprofen', dose: '400mg', frequency: 'As needed' }],
    past_surgeries: ['Lumbar discectomy (2020)'],
    recent_visits: [{ date: '2024-10-15', reason: 'Pain management consult', doctor: 'Dr. Singh' }],
    notes: 'Referred to physiotherapy. Avoid heavy lifting.',
  },
  'patient-004': {
    full_name: 'Mei Ling Tan', caretag_id: 'CT-1004',
    date_of_birth: '2001-05-18', gender: 'Female', blood_type: 'AB-', phone: '+60-14-5556677',
    emergency_contact_name: null, emergency_contact_phone: null,
    allergies: ['Pollen', 'Dust mites'],
    chronic_conditions: ['Allergic rhinitis'],
    current_medications: [{ name: 'Cetirizine', dose: '10mg', frequency: 'Once daily' }],
    past_surgeries: [],
    recent_visits: [{ date: '2024-11-10', reason: 'Allergy review', doctor: 'Dr. Wong' }],
    notes: 'Consider allergy immunotherapy.',
  },
  'patient-005': {
    full_name: 'John Doe', caretag_id: 'CT-1005',
    date_of_birth: '1965-11-02', gender: 'Male', blood_type: 'O-', phone: '+60-17-5554444',
    emergency_contact_name: 'Jane Doe', emergency_contact_phone: '+60-17-5554444',
    allergies: ['Aspirin', 'Codeine'],
    chronic_conditions: ['Coronary artery disease', 'Hyperlipidaemia'],
    current_medications: [
      { name: 'Atorvastatin', dose: '40mg', frequency: 'Once daily at night' },
      { name: 'Clopidogrel', dose: '75mg', frequency: 'Once daily' },
    ],
    past_surgeries: ['Coronary angioplasty (2019)'],
    recent_visits: [
      { date: '2024-12-10', reason: 'Cardiology follow-up', doctor: 'Dr. Rajan' },
      { date: '2024-08-22', reason: 'Lipid panel review', doctor: 'Dr. Rajan' },
    ],
    notes: 'High cardiac risk. Strict low-fat diet advised.',
  },
};
// ──────────────────────────────────────────────────────────────────────────

export default function PatientDetail() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const patient = id ? MOCK_PATIENT_RECORDS[id] : null;

  if (!patient) {
    return (
      <div className="flex flex-col items-center justify-center py-24 gap-4">
        <p className="text-muted-foreground">Patient record not found.</p>
        <Button variant="outline" onClick={() => navigate('/patients')}>
          <ArrowLeft className="h-4 w-4 mr-2" /> Back to Patients
        </Button>
      </div>
    );
  }

  return (
    <div className="space-y-6 max-w-4xl mx-auto">
      <Button variant="ghost" className="gap-2 -ml-2" onClick={() => navigate('/patients')}>
        <ArrowLeft className="h-4 w-4" /> Back to Patients
      </Button>

      {/* Patient Header */}
      <Card>
        <CardContent className="p-6">
          <div className="flex items-start gap-4">
            <div className="h-16 w-16 rounded-2xl bg-primary/10 flex items-center justify-center flex-shrink-0">
              <span className="text-primary font-bold text-xl">
                {patient.full_name.split(' ').map((n: string) => n[0]).join('')}
              </span>
            </div>
            <div className="flex-1">
              <div className="flex items-start justify-between flex-wrap gap-2">
                <div>
                  <h1 className="text-2xl font-bold">{patient.full_name}</h1>
                  <p className="text-muted-foreground font-mono text-sm">{patient.caretag_id}</p>
                </div>
                <Badge variant="outline">{patient.gender}</Badge>
              </div>
              <div className="mt-3 flex flex-wrap gap-4 text-sm text-muted-foreground">
                <span><strong>DOB:</strong> {patient.date_of_birth}</span>
                <span className="flex items-center gap-1">
                  <Droplets className="h-3.5 w-3.5 text-red-500" />
                  <strong>Blood:</strong> {patient.blood_type}
                </span>
                {patient.phone && (
                  <span className="flex items-center gap-1">
                    <Phone className="h-3.5 w-3.5" /> {patient.phone}
                  </span>
                )}
              </div>
            </div>
          </div>
        </CardContent>
      </Card>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {/* Allergies */}
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <AlertTriangle className="h-4 w-4 text-destructive" /> Allergies
            </CardTitle>
          </CardHeader>
          <CardContent>
            {patient.allergies.length > 0 ? (
              <div className="flex flex-wrap gap-2">
                {patient.allergies.map((a: string) => (
                  <Badge key={a} variant="destructive">{a}</Badge>
                ))}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">No known allergies</p>
            )}
          </CardContent>
        </Card>

        {/* Chronic Conditions */}
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Heart className="h-4 w-4 text-orange-500" /> Chronic Conditions
            </CardTitle>
          </CardHeader>
          <CardContent>
            {patient.chronic_conditions.length > 0 ? (
              <div className="flex flex-wrap gap-2">
                {patient.chronic_conditions.map((c: string) => (
                  <Badge key={c} variant="secondary">{c}</Badge>
                ))}
              </div>
            ) : (
              <p className="text-sm text-muted-foreground">None</p>
            )}
          </CardContent>
        </Card>

        {/* Current Medications */}
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Pill className="h-4 w-4 text-blue-500" /> Current Medications
            </CardTitle>
          </CardHeader>
          <CardContent>
            {patient.current_medications.length > 0 ? (
              <ul className="space-y-2">
                {patient.current_medications.map((m: any, i: number) => (
                  <li key={i} className="flex items-center justify-between text-sm">
                    <span className="font-medium">{m.name}</span>
                    <span className="text-muted-foreground text-xs">{m.dose} · {m.frequency}</span>
                  </li>
                ))}
              </ul>
            ) : (
              <p className="text-sm text-muted-foreground">None</p>
            )}
          </CardContent>
        </Card>

        {/* Past Surgeries */}
        <Card>
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Stethoscope className="h-4 w-4 text-purple-500" /> Past Surgeries
            </CardTitle>
          </CardHeader>
          <CardContent>
            {patient.past_surgeries.length > 0 ? (
              <ul className="space-y-1">
                {patient.past_surgeries.map((s: string, i: number) => (
                  <li key={i} className="text-sm">{s}</li>
                ))}
              </ul>
            ) : (
              <p className="text-sm text-muted-foreground">None</p>
            )}
          </CardContent>
        </Card>
      </div>

      {/* Recent Visits */}
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm flex items-center gap-2">
            <FileText className="h-4 w-4 text-green-500" /> Recent Visits
          </CardTitle>
        </CardHeader>
        <CardContent>
          {patient.recent_visits.length > 0 ? (
            <ul className="divide-y">
              {patient.recent_visits.map((v: any, i: number) => (
                <li key={i} className="py-2 flex items-center justify-between text-sm">
                  <div>
                    <p className="font-medium">{v.reason}</p>
                    <p className="text-xs text-muted-foreground">{v.doctor}</p>
                  </div>
                  <span className="text-xs text-muted-foreground">{v.date}</span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-sm text-muted-foreground">No visits recorded</p>
          )}
        </CardContent>
      </Card>

      {/* Emergency Contact */}
      {patient.emergency_contact_name && (
        <Card className="border-orange-300">
          <CardHeader className="pb-2">
            <CardTitle className="text-sm flex items-center gap-2">
              <Phone className="h-4 w-4 text-orange-500" /> Emergency Contact
            </CardTitle>
          </CardHeader>
          <CardContent className="text-sm">
            <p className="font-medium">{patient.emergency_contact_name}</p>
            <p className="text-muted-foreground">{patient.emergency_contact_phone}</p>
          </CardContent>
        </Card>
      )}

      {/* Doctor Notes */}
      <Card>
        <CardHeader className="pb-2">
          <CardTitle className="text-sm flex items-center gap-2">
            <User className="h-4 w-4" /> Doctor Notes
          </CardTitle>
        </CardHeader>
        <CardContent>
          <p className="text-sm text-muted-foreground">{patient.notes}</p>
        </CardContent>
      </Card>
    </div>
  );
}
