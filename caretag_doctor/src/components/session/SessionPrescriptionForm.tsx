import { useState } from 'react';
import { Plus, Trash2, Edit2, Check, X } from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Badge } from '@/components/ui/badge';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useSession } from '@/context/SessionContext';
import type { SessionMedication, SessionPrescription } from '@/types/session.types';

const EMPTY_MEDICATION: SessionMedication = {
  name: '',
  dosage: '',
  frequency: '',
  duration: '',
  timing: { morning: '0', afternoon: '0', night: '0' },
  mealTiming: 'After Food',
};

export default function SessionPrescriptionForm() {
  const { session, updatePrescriptions } = useSession();
  const [isAdding, setIsAdding] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);

  // Form state
  const [diagnosis, setDiagnosis] = useState('');
  const [notes, setNotes] = useState('');
  const [medications, setMedications] = useState<SessionMedication[]>([
    { ...EMPTY_MEDICATION },
  ]);

  const prescriptions = session?.prescriptions ?? [];

  const resetForm = () => {
    setDiagnosis('');
    setNotes('');
    setMedications([{ ...EMPTY_MEDICATION }]);
    setIsAdding(false);
    setEditingId(null);
  };

  const handleAddMedication = () => {
    setMedications((prev) => [...prev, { ...EMPTY_MEDICATION }]);
  };

  const handleRemoveMedication = (index: number) => {
    setMedications((prev) => prev.filter((_, i) => i !== index));
  };

  const updateMedication = (
    index: number,
    field: keyof SessionMedication,
    value: any
  ) => {
    setMedications((prev) =>
      prev.map((m, i) => (i === index ? { ...m, [field]: value } : m))
    );
  };

  const updateTiming = (
    index: number,
    period: 'morning' | 'afternoon' | 'night',
    value: string
  ) => {
    setMedications((prev) =>
      prev.map((m, i) =>
        i === index
          ? { ...m, timing: { ...m.timing, [period]: value } }
          : m
      )
    );
  };

  const handleSave = () => {
    const validMeds = medications.filter((m) => m.name.trim());
    if (!diagnosis.trim() && validMeds.length === 0) return;

    const newPrescription: SessionPrescription = {
      localId: editingId || crypto.randomUUID(),
      diagnosis: diagnosis.trim(),
      medications: validMeds,
      notes: notes.trim(),
    };

    let updated: SessionPrescription[];
    if (editingId) {
      updated = prescriptions.map((p) =>
        p.localId === editingId ? newPrescription : p
      );
    } else {
      updated = [...prescriptions, newPrescription];
    }

    updatePrescriptions(updated);
    resetForm();
  };

  const handleEdit = (prescription: SessionPrescription) => {
    setDiagnosis(prescription.diagnosis);
    setNotes(prescription.notes);
    setMedications(
      prescription.medications.length > 0
        ? prescription.medications
        : [{ ...EMPTY_MEDICATION }]
    );
    setEditingId(prescription.localId);
    setIsAdding(true);
  };

  const handleDelete = (localId: string) => {
    updatePrescriptions(prescriptions.filter((p) => p.localId !== localId));
  };

  return (
    <div className="space-y-4">
      {/* Existing prescriptions */}
      {prescriptions.map((rx) => (
        <Card key={rx.localId}>
          <CardContent className="p-4">
            <div className="flex items-start justify-between mb-2">
              <div>
                <p className="font-medium">{rx.diagnosis || 'No diagnosis'}</p>
                {rx.notes && (
                  <p className="text-sm text-muted-foreground mt-1">
                    {rx.notes}
                  </p>
                )}
              </div>
              <div className="flex gap-1">
                <Button
                  variant="ghost"
                  size="icon"
                  className="h-8 w-8"
                  onClick={() => handleEdit(rx)}
                >
                  <Edit2 className="h-4 w-4" />
                </Button>
                <Button
                  variant="ghost"
                  size="icon"
                  className="h-8 w-8 text-destructive"
                  onClick={() => handleDelete(rx.localId)}
                >
                  <Trash2 className="h-4 w-4" />
                </Button>
              </div>
            </div>
            <div className="flex flex-wrap gap-2">
              {rx.medications.map((med, i) => (
                <Badge key={i} variant="outline" className="font-normal">
                  {med.name} {med.dosage && `- ${med.dosage}`}
                  {med.frequency && ` (${med.frequency})`}
                </Badge>
              ))}
            </div>
          </CardContent>
        </Card>
      ))}

      {/* Add/Edit Form */}
      {isAdding ? (
        <Card className="border-primary/30">
          <CardHeader className="pb-3">
            <CardTitle className="text-base">
              {editingId ? 'Edit Prescription' : 'New Prescription'}
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            {/* Diagnosis */}
            <div className="space-y-2">
              <Label>Diagnosis</Label>
              <Input
                placeholder="Enter diagnosis..."
                value={diagnosis}
                onChange={(e) => setDiagnosis(e.target.value)}
              />
            </div>

            {/* Medications */}
            <div className="space-y-3">
              <div className="flex items-center justify-between">
                <Label>Medications</Label>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={handleAddMedication}
                  className="gap-1"
                >
                  <Plus className="h-3 w-3" /> Add
                </Button>
              </div>

              {medications.map((med, index) => (
                <div
                  key={index}
                  className="p-3 rounded-lg bg-muted/50 border space-y-3"
                >
                  <div className="flex items-center justify-between">
                    <span className="text-sm font-medium">
                      Medication {index + 1}
                    </span>
                    {medications.length > 1 && (
                      <Button
                        variant="ghost"
                        size="icon"
                        className="h-6 w-6 text-destructive"
                        onClick={() => handleRemoveMedication(index)}
                      >
                        <X className="h-3 w-3" />
                      </Button>
                    )}
                  </div>

                  <div className="grid grid-cols-2 gap-2">
                    <div className="space-y-1">
                      <Label className="text-xs">Name</Label>
                      <Input
                        placeholder="Drug name"
                        value={med.name}
                        onChange={(e) =>
                          updateMedication(index, 'name', e.target.value)
                        }
                      />
                    </div>
                    <div className="space-y-1">
                      <Label className="text-xs">Dosage</Label>
                      <Input
                        placeholder="e.g., 500mg"
                        value={med.dosage}
                        onChange={(e) =>
                          updateMedication(index, 'dosage', e.target.value)
                        }
                      />
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-2">
                    <div className="space-y-1">
                      <Label className="text-xs">Frequency</Label>
                      <Select
                        value={med.frequency}
                        onValueChange={(v) =>
                          updateMedication(index, 'frequency', v)
                        }
                      >
                        <SelectTrigger>
                          <SelectValue placeholder="Select" />
                        </SelectTrigger>
                        <SelectContent>
                          <SelectItem value="Once daily">Once daily</SelectItem>
                          <SelectItem value="Twice daily">
                            Twice daily
                          </SelectItem>
                          <SelectItem value="Thrice daily">
                            Thrice daily
                          </SelectItem>
                          <SelectItem value="As needed">As needed</SelectItem>
                          <SelectItem value="Every 4 hours">
                            Every 4 hours
                          </SelectItem>
                          <SelectItem value="Every 6 hours">
                            Every 6 hours
                          </SelectItem>
                          <SelectItem value="Every 8 hours">
                            Every 8 hours
                          </SelectItem>
                        </SelectContent>
                      </Select>
                    </div>
                    <div className="space-y-1">
                      <Label className="text-xs">Duration</Label>
                      <Input
                        placeholder="e.g., 7 days"
                        value={med.duration}
                        onChange={(e) =>
                          updateMedication(index, 'duration', e.target.value)
                        }
                      />
                    </div>
                  </div>

                  {/* Timing */}
                  <div className="space-y-1">
                    <Label className="text-xs">Timing</Label>
                    <div className="flex gap-4">
                      {(['morning', 'afternoon', 'night'] as const).map(
                        (period) => (
                          <label
                            key={period}
                            className="flex items-center gap-1.5 text-sm"
                          >
                            <input
                              type="checkbox"
                              checked={med.timing[period] === '1'}
                              onChange={(e) =>
                                updateTiming(
                                  index,
                                  period,
                                  e.target.checked ? '1' : '0'
                                )
                              }
                              className="rounded"
                            />
                            <span className="capitalize">{period}</span>
                          </label>
                        )
                      )}
                    </div>
                  </div>

                  {/* Meal Timing */}
                  <div className="space-y-1">
                    <Label className="text-xs">Meal Timing</Label>
                    <Select
                      value={med.mealTiming}
                      onValueChange={(v) =>
                        updateMedication(index, 'mealTiming', v)
                      }
                    >
                      <SelectTrigger>
                        <SelectValue />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="Before Food">Before Food</SelectItem>
                        <SelectItem value="After Food">After Food</SelectItem>
                        <SelectItem value="With Food">With Food</SelectItem>
                        <SelectItem value="Empty Stomach">
                          Empty Stomach
                        </SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              ))}
            </div>

            {/* Notes */}
            <div className="space-y-2">
              <Label>Notes</Label>
              <Textarea
                placeholder="Additional notes..."
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                rows={2}
              />
            </div>

            {/* Actions */}
            <div className="flex gap-2 justify-end">
              <Button variant="outline" onClick={resetForm}>
                Cancel
              </Button>
              <Button onClick={handleSave} className="gap-1">
                <Check className="h-4 w-4" />
                {editingId ? 'Update' : 'Add Prescription'}
              </Button>
            </div>
          </CardContent>
        </Card>
      ) : (
        <Button
          variant="outline"
          className="w-full gap-2 border-dashed"
          onClick={() => setIsAdding(true)}
        >
          <Plus className="h-4 w-4" />
          Add Prescription
        </Button>
      )}
    </div>
  );
}
