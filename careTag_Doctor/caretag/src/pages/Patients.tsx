import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Search, ScanLine, Users, ArrowRight, Phone } from 'lucide-react';

const INITIAL_PATIENTS = [
  { id: 'patient-001', full_name: 'Ali Hassan', caretag_id: 'CT-1001', emergency_contact_name: 'Sara Hassan', emergency_contact_phone: '+60-12-3456789' },
  { id: 'patient-002', full_name: 'Nurul Aina', caretag_id: 'CT-1002', emergency_contact_name: 'Ahmad Aina', emergency_contact_phone: '+60-11-9876543' },
  { id: 'patient-003', full_name: 'Ravi Kumar', caretag_id: 'CT-1003', emergency_contact_name: 'Priya Kumar', emergency_contact_phone: '+60-16-1112233' },
  { id: 'patient-004', full_name: 'Mei Ling Tan', caretag_id: 'CT-1004', emergency_contact_name: null, emergency_contact_phone: null },
  { id: 'patient-005', full_name: 'John Doe', caretag_id: 'CT-1005', emergency_contact_name: 'Jane Doe', emergency_contact_phone: '+60-17-5554444' },
];

export default function Patients() {
  const navigate = useNavigate();
  const [search, setSearch] = useState('');
  const patients = INITIAL_PATIENTS;

  const filteredPatients = patients.filter(p =>
    p.full_name.toLowerCase().includes(search.toLowerCase()) ||
    p.caretag_id.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-semibold">Patients</h1>
          <p className="text-muted-foreground text-sm mt-1">
            {patients.length} patients registered
          </p>
        </div>
        <Button className="gap-2" onClick={() => navigate('/scan')}>
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
        />
      </div>

      {/* Patient Grid */}
      {filteredPatients.length > 0 ? (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredPatients.map((patient) => (
            <Card
              key={patient.id}
              className="transition-all cursor-pointer hover:border-primary/50 hover:shadow-md"
              onClick={() => navigate(`/patients/${patient.id}`)}
            >
              <CardContent className="p-4">
                <div className="flex items-start gap-3">
                  <div className="h-10 w-10 rounded-lg bg-muted flex items-center justify-center flex-shrink-0">
                    <span className="font-medium text-sm text-muted-foreground">
                      {patient.full_name.split(' ').map(n => n[0]).join('')}
                    </span>
                  </div>
                  <div className="flex-1 min-w-0">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <p className="font-medium truncate">{patient.full_name}</p>
                        <p className="text-xs text-muted-foreground font-mono">{patient.caretag_id}</p>
                      </div>
                      <Badge variant="outline" className="flex-shrink-0 text-xs">View</Badge>
                    </div>
                    {patient.emergency_contact_name && (
                      <div className="mt-2 flex items-center gap-1 text-xs text-muted-foreground">
                        <Phone className="h-3 w-3" />
                        <span className="truncate">
                          {patient.emergency_contact_name}
                          {patient.emergency_contact_phone && ` (${patient.emergency_contact_phone})`}
                        </span>
                      </div>
                    )}
                  </div>
                </div>
                <div className="mt-2 flex justify-end">
                  <span className="text-xs text-muted-foreground flex items-center gap-1">
                    View Records <ArrowRight className="h-3 w-3" />
                  </span>
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      ) : (
        <Card>
          <CardContent className="py-16 text-center">
            <Users className="h-10 w-10 text-muted-foreground/50 mx-auto mb-4" />
            <h3 className="text-lg font-medium">No patients found</h3>
            <p className="text-muted-foreground mt-1 max-w-md mx-auto text-sm">
              {search ? 'Try adjusting your search.' : 'Scan a CareTag to add a new patient.'}
            </p>
            <Button className="gap-2 mt-4" onClick={() => navigate('/scan')}>
              <ScanLine className="h-4 w-4" /> Scan CareTag
            </Button>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
