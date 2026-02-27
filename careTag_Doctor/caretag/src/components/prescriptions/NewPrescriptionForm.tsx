import { useState, useEffect } from 'react';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from '@/components/ui/dialog';
import { AlertDialog, AlertDialogAction, AlertDialogCancel, AlertDialogContent, AlertDialogDescription, AlertDialogFooter, AlertDialogHeader, AlertDialogTitle } from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Skeleton } from '@/components/ui/skeleton';
import { Plus, Trash2, FileText, Pill, Search, Star, AlertTriangle, ShieldX, ShieldCheck, Loader2 } from 'lucide-react';
import { toast } from 'sonner';
import { useAuth } from '@/hooks/useAuth';
import { format, addMonths } from 'date-fns';
import { DrugInputWithValidation } from './DrugInputWithValidation';
import axiosInstance from '@/utils/axiosInstance';

interface Medication {
  name: string;
  dosage: string;
  frequency: string;
  duration: string;
  timing: { morning: string; afternoon: string; night: string }; // e.g. 1-0-0
  mealTiming: string; // e.g. "After Food"
}

interface DrugInteraction {
  drug1: string;
  drug2: string;
  severity: 'low' | 'moderate' | 'high' | 'critical';
  description: string;
  recommendation: string;
}

interface Template {
  id: string;
  name: string;
  diagnosis: string | null;
  medications: Medication[];
  notes: string | null;
  is_favorite: boolean;
}

interface Patient {
  id: string;
  full_name: string;
  caretag_id: string;
}

interface NewPrescriptionFormProps {
  preselectedPatientId?: string;
  preselectedPatientName?: string;
  trigger?: React.ReactNode;
  onSuccess?: () => void;
}

const FAKE_TEMPLATES = [
  {
    id: 'tpl-001', name: 'Diabetes Standard', diagnosis: 'Type 2 Diabetes', is_favorite: true,
    notes: 'Monitor blood sugar daily.',
    medications: [
      { name: 'Metformin', dosage: '500mg', frequency: 'Twice daily', duration: '30 days', timing: { morning: '1', afternoon: '0', night: '1' }, mealTiming: 'After Food' },
      { name: 'Glipizide', dosage: '5mg', frequency: 'Once daily', duration: '30 days', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'Before Food' },
    ],
  },
  {
    id: 'tpl-002', name: 'Hypertension', diagnosis: 'Hypertension', is_favorite: false,
    notes: 'Avoid salty food.',
    medications: [
      { name: 'Amlodipine', dosage: '10mg', frequency: 'Once daily', duration: '60 days', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'After Food' },
    ],
  },
  {
    id: 'tpl-003', name: 'URI / Common Cold', diagnosis: 'Upper Respiratory Infection', is_favorite: false,
    notes: null,
    medications: [
      { name: 'Amoxicillin', dosage: '250mg', frequency: 'Three times daily', duration: '7 days', timing: { morning: '1', afternoon: '1', night: '1' }, mealTiming: 'After Food' },
      { name: 'Paracetamol', dosage: '500mg', frequency: 'As needed', duration: '5 days', timing: { morning: '1', afternoon: '0', night: '1' }, mealTiming: 'After Food' },
    ],
  },
];

export function NewPrescriptionForm({
  preselectedPatientId,
  preselectedPatientName,
  trigger,
  onSuccess
}: NewPrescriptionFormProps) {
  const { user } = useAuth();
  const queryClient = useQueryClient();
  const [open, setOpen] = useState(false);
  const [patientSearch, setPatientSearch] = useState('');
  const [patients, setPatients] = useState<Patient[]>([]);
  const [isLoadingPatients, setIsLoadingPatients] = useState(false);
  const [selectedPatient, setSelectedPatient] = useState<Patient | null>(
    preselectedPatientId && preselectedPatientName
      ? { id: preselectedPatientId, full_name: preselectedPatientName, caretag_id: '' }
      : null
  );
  const [form, setForm] = useState({
    diagnosis: '',
    notes: '',
    validMonths: 3,
    maxRefills: 0,
    medications: [{ name: '', dosage: '', frequency: '', duration: '', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'After Food' }] as Medication[]
  });
  const [drugValidationStatus, setDrugValidationStatus] = useState<Record<number, boolean>>({});
  const [interactions, setInteractions] = useState<DrugInteraction[]>([]);
  const [isCheckingInteractions, setIsCheckingInteractions] = useState(false);
  const [lastCheckedDrugs, setLastCheckedDrugs] = useState<string[]>([]);
  const [showWarningDialog, setShowWarningDialog] = useState(false);
  const [warningType, setWarningType] = useState<'unverified' | 'interactions' | 'both'>('unverified');

  //── Debounced patient search → Spring Boot endpoint ──
  useEffect(() => {
    if (patientSearch.length < 3) {
      setPatients([]);
      setIsLoadingPatients(false);
      return;
    }

    setIsLoadingPatients(true);

    const timer = setTimeout(async () => {
      try {
        const response = await axiosInstance.post('/doctor/search', patientSearch, {
          headers: { 'Content-Type': 'text/plain' },
        });
        console.log('Search response:', response.data);
        const data = Array.isArray(response.data) ? response.data : [];
        setPatients(data.map((p: any) => ({
          id: p.careTagId,                // use careTagId as id since no separate id field
          full_name: p.paitentName ?? '',
          caretag_id: p.careTagId ?? '',
        })));
      } catch (error: any) {
        console.error('Patient search failed', error);
        if (error?.response) {
          console.error('Status:', error.response.status);
          console.error('Server error body:', error.response.data);
        }
        setPatients([]);
      } finally {
        setIsLoadingPatients(false);
      }
    }, 500);

    return () => clearTimeout(timer);
  }, [patientSearch]);

  useEffect(() => {
    if (open) {
      if (preselectedPatientId && preselectedPatientName) {
        setSelectedPatient({ id: preselectedPatientId, full_name: preselectedPatientName, caretag_id: '' });
      }
    } else {
      setForm({ diagnosis: '', notes: '', validMonths: 3, maxRefills: 0, medications: [{ name: '', dosage: '', frequency: '', duration: '', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'After Food' }] });
      setDrugValidationStatus({});
      setInteractions([]);
      setLastCheckedDrugs([]);
      if (!preselectedPatientId) { setSelectedPatient(null); setPatientSearch(''); }
    }
  }, [open, preselectedPatientId, preselectedPatientName]);

  const createMutation = useMutation({
    mutationFn: async () => {
      if (!selectedPatient) throw new Error('Missing required data');
      const validTill = addMonths(new Date(), form.validMonths);
      const payload = {
        careTagId: selectedPatient.id,        // e.g. "CTG-8F27-2A6B"
        diagnosis: form.diagnosis || null,      // Java DTO: diagnosis
        medications: form.medications.filter(m => m.name).map(m => ({
          name: m.name,                        // matches: private String name
          dosage: m.dosage,                    // matches: private String dosage
          frequency: m.frequency,              // matches: private String frequency
          duration: m.duration,                // matches: private String duration
          morning: m.timing.morning === '1' ? 1 : 0,     // matches: private int morning
          afternoon: m.timing.afternoon === '1' ? 1 : 0, // matches: private int afternoon
          night: m.timing.night === '1' ? 1 : 0,         // matches: private int night
          mealTiming: m.mealTiming,            // matches: private String mealTiming
        })),
        notes: form.notes || null,             // matches: private String notes
        validTill: format(validTill, "yyyy-MM-dd'T'HH:mm:ss"), // matches: private LocalDateTime vaildTill
        maxRefills: form.maxRefills,              // Java DTO: maxRefills
        status: 'active',                      // matches: private String status
      };
      console.log('Sending payload:', payload);
      await axiosInstance.post('/doctor/prescription', payload);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['prescriptions'] });
      toast.success('Prescription created successfully');
      setOpen(false);
      onSuccess?.();
    },
    onError: (error: any) => {
      console.error('Error creating prescription:', error);
      if (error?.response) {
        console.error('Server responded with status:', error.response.status);
        console.error('Server error body:', error.response.data);
      }
      toast.error('Failed to create prescription');
    }
  });

  const applyTemplate = (template: Template) => {
    setForm({ ...form, diagnosis: template.diagnosis || '', notes: template.notes || '', medications: template.medications.length > 0 ? template.medications : [{ name: '', dosage: '', frequency: '', duration: '', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'After Food' }] });
    toast.success(`Applied template: ${template.name}`);
  };

  const addMedication = () => setForm({ ...form, medications: [...form.medications, { name: '', dosage: '', frequency: '', duration: '', timing: { morning: '1', afternoon: '0', night: '0' }, mealTiming: 'After Food' }] });

  const updateMedication = (index: number, field: keyof Omit<Medication, 'timing'>, value: string) => {
    const meds = [...form.medications];
    meds[index] = { ...meds[index], [field]: value };
    setForm({ ...form, medications: meds });
  };

  const updateMedicationTiming = (index: number, slot: 'morning' | 'afternoon' | 'night', value: string) => {
    const meds = [...form.medications];
    meds[index] = { ...meds[index], timing: { ...meds[index].timing, [slot]: value } };
    setForm({ ...form, medications: meds });
  };

  const removeMedication = (index: number) => {
    if (form.medications.length > 1) setForm({ ...form, medications: form.medications.filter((_, i) => i !== index) });
  };
  const updateDrugValidation = (index: number, isValid: boolean) => setDrugValidationStatus(prev => ({ ...prev, [index]: isValid }));
  const getUnverifiedDrugs = () => form.medications.filter((med, index) => med.name.trim().length >= 2 && !drugValidationStatus[index]).map(med => med.name);
  const getDangerousInteractions = () => interactions.filter(i => i.severity === 'high' || i.severity === 'critical');

  const handleSubmitClick = () => {
    const unverifiedDrugs = getUnverifiedDrugs();
    const dangerousInteractions = getDangerousInteractions();
    if (unverifiedDrugs.length > 0 && dangerousInteractions.length > 0) { setWarningType('both'); setShowWarningDialog(true); }
    else if (unverifiedDrugs.length > 0) { setWarningType('unverified'); setShowWarningDialog(true); }
    else if (dangerousInteractions.length > 0) { setWarningType('interactions'); setShowWarningDialog(true); }
    else { createMutation.mutate(); }
  };

  const confirmSubmit = () => { setShowWarningDialog(false); createMutation.mutate(); };
  const canSubmit = selectedPatient && form.medications.some(m => m.name);
  const getSeverityColor = (severity: string) => {
    switch (severity) {
      case 'critical': return 'bg-destructive text-destructive-foreground';
      case 'high': return 'bg-orange-500 text-white';
      case 'moderate': return 'bg-yellow-500 text-white';
      default: return 'bg-blue-500 text-white';
    }
  };

  const templatesLoading = false;
  const templates = FAKE_TEMPLATES;

  return (
    <>
      <AlertDialog open={showWarningDialog} onOpenChange={setShowWarningDialog}>
        <AlertDialogContent className="max-w-lg">
          <AlertDialogHeader>
            <AlertDialogTitle className="flex items-center gap-2 text-destructive">
              <AlertTriangle className="h-5 w-5" />
              {warningType === 'both' ? 'Multiple Warnings' :
                warningType === 'unverified' ? 'Unverified Medications' : 'Drug Interactions Detected'}
            </AlertDialogTitle>
            <AlertDialogDescription asChild>
              <div className="space-y-4">
                {(warningType === 'unverified' || warningType === 'both') && (
                  <div className="space-y-2">
                    <p className="font-medium text-foreground">The following medications could not be verified in the FDA database:</p>
                    <div className="flex flex-wrap gap-1">
                      {getUnverifiedDrugs().map((drug, i) => (
                        <Badge key={i} variant="outline" className="border-destructive text-destructive">{drug}</Badge>
                      ))}
                    </div>
                  </div>
                )}
                {(warningType === 'interactions' || warningType === 'both') && (
                  <div className="space-y-2">
                    <p className="font-medium text-foreground">Dangerous drug interactions detected:</p>
                    <div className="space-y-2 max-h-40 overflow-y-auto">
                      {getDangerousInteractions().map((interaction, i) => (
                        <div key={i} className="p-2 rounded bg-destructive/10 border border-destructive/20">
                          <div className="flex items-center gap-2">
                            <ShieldX className="h-4 w-4 text-destructive" />
                            <span className="font-medium text-sm">{interaction.drug1} + {interaction.drug2}</span>
                            <Badge className={getSeverityColor(interaction.severity)}>{interaction.severity.toUpperCase()}</Badge>
                          </div>
                          <p className="text-xs text-muted-foreground mt-1">{interaction.description}</p>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
                <p className="text-sm text-muted-foreground">Are you sure you want to proceed with this prescription?</p>
              </div>
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancel & Review</AlertDialogCancel>
            <AlertDialogAction onClick={confirmSubmit} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
              Proceed Anyway
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogTrigger asChild>
          {trigger || (<Button className="gap-2 shadow-lg shadow-primary/25"><Plus className="h-4 w-4" />New Prescription</Button>)}
        </DialogTrigger>
        <DialogContent className="max-w-4xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2"><Pill className="h-5 w-5" />Create New Prescription</DialogTitle>
            <DialogDescription>Fill in the prescription details or use a template to get started quickly</DialogDescription>
          </DialogHeader>

          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-2 space-y-4">

              {/* Patient Selection */}
              <div>
                <Label className="text-base font-semibold">Patient *</Label>
                {selectedPatient ? (
                  <div className="flex items-center justify-between p-3 bg-muted rounded-lg mt-2">
                    <div className="flex items-center gap-3">
                      <div className="h-10 w-10 rounded-full bg-primary/10 flex items-center justify-center">
                        <span className="text-sm font-medium">{selectedPatient.full_name.charAt(0)}</span>
                      </div>
                      <div>
                        <p className="font-medium">{selectedPatient.full_name}</p>
                        {selectedPatient.caretag_id && <p className="text-sm text-muted-foreground">{selectedPatient.caretag_id}</p>}
                      </div>
                    </div>
                    {!preselectedPatientId && (<Button type="button" variant="ghost" size="sm" onClick={() => setSelectedPatient(null)}>Change</Button>)}
                  </div>
                ) : (
                  <div className="space-y-2 mt-2">
                    <div className="relative">
                      <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
                      <Input
                        placeholder="Search patients (min. 3 characters)..."
                        value={patientSearch}
                        onChange={(e) => setPatientSearch(e.target.value)}
                        className="pl-10"
                      />
                    </div>
                    {patientSearch.length >= 3 && (
                      <div className="border rounded-lg max-h-40 overflow-y-auto">
                        {isLoadingPatients ? (
                          <div className="p-3 text-sm text-muted-foreground flex items-center gap-2">
                            <Loader2 className="h-4 w-4 animate-spin" /> Searching...
                          </div>
                        ) : patients.length > 0 ? (
                          patients.map(p => (
                            <button
                              type="button"
                              key={p.caretag_id}
                              className="w-full text-left p-3 hover:bg-muted transition-colors flex items-center gap-3"
                              onClick={() => { setSelectedPatient(p); setPatientSearch(''); setPatients([]); }}
                            >
                              <div className="h-8 w-8 rounded-full bg-primary/10 flex items-center justify-center">
                                <span className="text-xs font-medium">
                                  {p.full_name ? p.full_name.charAt(0).toUpperCase() : '?'}
                                </span>
                              </div>
                              <div>
                                <p className="font-medium text-sm">{p.full_name}</p>
                                <p className="text-xs text-muted-foreground">{p.caretag_id}</p>
                              </div>
                            </button>
                          ))
                        ) : (
                          <div className="p-3 text-sm text-muted-foreground">No patients found.</div>
                        )}
                      </div>
                    )}
                  </div>
                )}
              </div>

              {/* Diagnosis */}
              <div>
                <Label>Diagnosis</Label>
                <Input
                  value={form.diagnosis}
                  onChange={(e) => setForm({ ...form, diagnosis: e.target.value })}
                  placeholder="e.g., Upper respiratory infection"
                  className="mt-1"
                />
              </div>

              {/* Medications */}
              <div>
                <Label className="text-base font-semibold">Medications *</Label>
                <div className="space-y-4 mt-2">
                  {form.medications.map((med, i) => (
                    <div key={i} className="p-3 border rounded-lg space-y-2 bg-muted/20">
                      {/* Row 1: Drug Name, Dosage, Duration, Remove */}
                      <div className="grid grid-cols-7 gap-2 items-end">
                        <div className="col-span-3">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Drug Name</Label>}
                          <DrugInputWithValidation
                            value={med.name}
                            onChange={(value) => updateMedication(i, 'name', value)}
                            onValidationChange={(isValid) => updateDrugValidation(i, isValid)}
                            placeholder="Medication"
                          />
                        </div>
                        <div className="col-span-2">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Dosage</Label>}
                          <Input placeholder="500mg" value={med.dosage} onChange={(e) => updateMedication(i, 'dosage', e.target.value)} />
                        </div>
                        <div className="col-span-1">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Duration</Label>}
                          <Input placeholder="7 days" value={med.duration} onChange={(e) => updateMedication(i, 'duration', e.target.value)} />
                        </div>
                        <Button type="button" variant="ghost" size="icon" onClick={() => removeMedication(i)} disabled={form.medications.length === 1}>
                          <Trash2 className="h-4 w-4" />
                        </Button>
                      </div>

                      {/* Row 2: Timing (M-A-N) + Meal Timing + Frequency */}
                      <div className="grid grid-cols-7 gap-2 items-end">
                        {/* Timing M-A-N */}
                        <div className="col-span-3">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Timing (Morning - Afternoon - Night)</Label>}
                          <div className="flex items-center gap-1">
                            <Input
                              className="text-center px-1"
                              placeholder="1"
                              value={med.timing.morning}
                              onChange={(e) => updateMedicationTiming(i, 'morning', e.target.value)}
                              maxLength={1}
                            />
                            <span className="text-muted-foreground font-bold">-</span>
                            <Input
                              className="text-center px-1"
                              placeholder="0"
                              value={med.timing.afternoon}
                              onChange={(e) => updateMedicationTiming(i, 'afternoon', e.target.value)}
                              maxLength={1}
                            />
                            <span className="text-muted-foreground font-bold">-</span>
                            <Input
                              className="text-center px-1"
                              placeholder="0"
                              value={med.timing.night}
                              onChange={(e) => updateMedicationTiming(i, 'night', e.target.value)}
                              maxLength={1}
                            />
                          </div>
                        </div>

                        {/* Meal Timing */}
                        <div className="col-span-2">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Meal Timing</Label>}
                          <Select value={med.mealTiming} onValueChange={(v) => updateMedication(i, 'mealTiming', v)}>
                            <SelectTrigger><SelectValue /></SelectTrigger>
                            <SelectContent>
                              <SelectItem value="Before Food">Before Food</SelectItem>
                              <SelectItem value="After Food">After Food</SelectItem>
                              <SelectItem value="With Food">With Food</SelectItem>
                              <SelectItem value="Before Sleep">Before Sleep</SelectItem>
                              <SelectItem value="After Sleep">After Sleep</SelectItem>
                              <SelectItem value="Empty Stomach">Empty Stomach</SelectItem>
                              <SelectItem value="As Needed">As Needed</SelectItem>
                            </SelectContent>
                          </Select>
                        </div>

                        {/* Frequency */}
                        <div className="col-span-2">
                          {i === 0 && <Label className="text-xs text-muted-foreground">Frequency</Label>}
                          <Input placeholder="Twice daily" value={med.frequency} onChange={(e) => updateMedication(i, 'frequency', e.target.value)} />
                        </div>
                      </div>
                    </div>
                  ))}
                  <Button type="button" variant="outline" size="sm" onClick={addMedication} className="gap-1">
                    <Plus className="h-3 w-3" /> Add Medication
                  </Button>
                </div>
              </div>

              {/* Drug Interactions Warning */}
              {(interactions.length > 0 || isCheckingInteractions) && (
                <Card className={interactions.some(i => i.severity === 'critical' || i.severity === 'high')
                  ? 'border-destructive/50 bg-destructive/5'
                  : 'border-yellow-500/50 bg-yellow-500/5'}>
                  <CardContent className="p-4">
                    <div className="flex items-center gap-2 mb-3">
                      {isCheckingInteractions ? (
                        <><Loader2 className="h-4 w-4 animate-spin text-muted-foreground" /><span className="text-sm font-medium">Checking drug interactions...</span></>
                      ) : interactions.length === 0 ? (
                        <><ShieldCheck className="h-4 w-4 text-green-600" /><span className="text-sm font-medium text-green-700">No interactions detected</span></>
                      ) : (
                        <><AlertTriangle className="h-4 w-4 text-destructive" /><span className="text-sm font-medium">{interactions.length} Drug Interaction{interactions.length > 1 ? 's' : ''} Detected</span></>
                      )}
                    </div>
                    {interactions.length > 0 && (
                      <div className="space-y-2">
                        {interactions.map((interaction, i) => (
                          <div key={i} className="flex items-start gap-2 p-2 rounded bg-background/80 border">
                            <Badge className={getSeverityColor(interaction.severity)}>{interaction.severity}</Badge>
                            <div className="flex-1 min-w-0">
                              <p className="text-sm font-medium">{interaction.drug1} + {interaction.drug2}</p>
                              <p className="text-xs text-muted-foreground">{interaction.description}</p>
                            </div>
                          </div>
                        ))}
                      </div>
                    )}
                  </CardContent>
                </Card>
              )}

              {/* Validity & Refills */}
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label>Valid For</Label>
                  <Select value={String(form.validMonths)} onValueChange={(v) => setForm({ ...form, validMonths: parseInt(v) })}>
                    <SelectTrigger className="mt-1"><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="1">1 month</SelectItem>
                      <SelectItem value="3">3 months</SelectItem>
                      <SelectItem value="6">6 months</SelectItem>
                      <SelectItem value="12">12 months</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div>
                  <Label>Max Refills</Label>
                  <Select value={String(form.maxRefills)} onValueChange={(v) => setForm({ ...form, maxRefills: parseInt(v) })}>
                    <SelectTrigger className="mt-1"><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="0">No refills</SelectItem>
                      <SelectItem value="1">1 refill</SelectItem>
                      <SelectItem value="2">2 refills</SelectItem>
                      <SelectItem value="3">3 refills</SelectItem>
                      <SelectItem value="5">5 refills</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>

              {/* Notes */}
              <div>
                <Label>Notes / Instructions</Label>
                <Textarea
                  value={form.notes}
                  onChange={(e) => setForm({ ...form, notes: e.target.value })}
                  placeholder="Additional instructions for the patient..."
                  rows={3}
                  className="mt-1"
                />
              </div>

              {/* Submit */}
              <div className="flex justify-end gap-2 pt-4 border-t">
                <Button type="button" variant="outline" onClick={() => setOpen(false)}>Cancel</Button>
                <Button type="button" onClick={handleSubmitClick} disabled={!canSubmit || createMutation.isPending} className="gap-2">
                  <Pill className="h-4 w-4" />
                  {createMutation.isPending ? 'Creating...' : 'Create Prescription'}
                </Button>
              </div>
            </div>

            {/* Templates Sidebar */}
            <div className="space-y-3">
              <Label className="text-base font-semibold flex items-center gap-2"><FileText className="h-4 w-4" />Quick Templates</Label>
              <p className="text-sm text-muted-foreground">Click a template to auto-fill the prescription</p>
              {templatesLoading ? (
                <div className="space-y-2">{[1, 2, 3].map(i => <Skeleton key={i} className="h-20" />)}</div>
              ) : templates.length > 0 ? (
                <div className="space-y-2 max-h-[400px] overflow-y-auto">
                  {templates.map(template => (
                    <Card key={template.id} className="cursor-pointer hover:bg-muted/50 transition-colors" onClick={() => applyTemplate(template)}>
                      <CardContent className="p-3">
                        <div className="flex items-center gap-2 mb-1">
                          <h4 className="font-medium text-sm">{template.name}</h4>
                          {template.is_favorite && <Star className="h-3 w-3 text-yellow-500 fill-yellow-500" />}
                        </div>
                        {template.diagnosis && <p className="text-xs text-muted-foreground mb-2">{template.diagnosis}</p>}
                        <div className="flex flex-wrap gap-1">
                          {template.medications.slice(0, 2).map((med, i) => (
                            <Badge key={i} variant="secondary" className="text-xs">{med.name}</Badge>
                          ))}
                          {template.medications.length > 2 && (
                            <Badge variant="secondary" className="text-xs">+{template.medications.length - 2}</Badge>
                          )}
                        </div>
                      </CardContent>
                    </Card>
                  ))}
                </div>
              ) : (
                <Card>
                  <CardContent className="p-4 text-center text-sm text-muted-foreground">
                    <FileText className="h-8 w-8 mx-auto mb-2 opacity-30" />
                    <p>No templates yet</p>
                  </CardContent>
                </Card>
              )}
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
