import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import {
  ArrowLeft,
  Send,
  Edit2,
  Pill,
  CalendarIcon,
  FileText,
  Receipt,
  Loader2,
  Plus,
  Trash2,
  Timer,
} from 'lucide-react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { Calendar } from '@/components/ui/calendar';
import { toast } from 'sonner';
import { useSession } from '@/context/SessionContext';
import { useSessionTimer } from '@/hooks/useSessionTimer';
import { aesGcmEncrypt } from '@/utils/sessionCrypto';
import axiosInstance from '@/utils/axiosInstance';
import PatientInfoCard from '@/components/session/PatientInfoCard';
import type {
  EncounterModelPayload,
  PrescriptionPayload,
  InvoiceItem,
} from '@/types/session.types';

export default function SessionEnd() {
  const navigate = useNavigate();
  const { session, updateSessionField, endSession } = useSession();
  const elapsed = useSessionTimer(session?.startedAt ?? null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [nextDate, setNextDate] = useState<Date | undefined>(undefined);

  // Local form state
  const [description, setDescription] = useState(session?.description ?? '');
  const [invoiceItems, setInvoiceItems] = useState<InvoiceItem[]>([
    { description: '', quantity: 1, unitPrice: 0, total: 0 },
  ]);
  const [taxRate, setTaxRate] = useState(0);
  const [discount, setDiscount] = useState(0);

  // Guard: redirect if no active session
  useEffect(() => {
    if (!session) {
      navigate('/patients', { replace: true });
    }
  }, [session, navigate]);

  if (!session) return null;

  const { basicDataDTO, prescriptions } = session;

  // Invoice calculations
  const updateInvoiceItem = (
    index: number,
    field: keyof InvoiceItem,
    value: string | number
  ) => {
    setInvoiceItems((prev) =>
      prev.map((item, i) => {
        if (i !== index) return item;
        const updated = { ...item, [field]: value };
        updated.total = updated.quantity * updated.unitPrice;
        return updated;
      })
    );
  };

  const subtotal = invoiceItems.reduce((sum, item) => sum + item.total, 0);
  const taxAmount = subtotal * (taxRate / 100);
  const total = subtotal + taxAmount - discount;

  const handleSubmit = async () => {
  setIsSubmitting(true);

  try {
    // 1. Build prescription payload as PLAIN TEXT
    // We send the object/JSON; Spring will handle the encryption logic later
    const prescription: PrescriptionPayload = {
      id: null,
      patientId: session.patientId,
      doctorId: session.docId,
      // We send the prescriptions as a JSON string so Spring can parse/encrypt it
      encryptedData: JSON.stringify(session.prescriptions), 
    };

    // 2. Build invoice string
    const invoiceData = JSON.stringify({
      items: invoiceItems.filter((item) => item.description.trim()),
      subtotal,
      taxRate,
      discount,
      total,
    });

    // 3. Build EncounterModel payload
    const encounterModel: EncounterModelPayload = {
      id: session.encounterId,
      patientId: session.patientId,
      docId: session.docId,
      ecounterstatus: 'SEALED',
      encrptedAESKey: session.encrptedAESKey,     // Keep this for the 'Handshake'
      envrpytedBlob: session.originalCipherText, // Keep this for the record
      xrayUrls: session.xrayUrls,
      basicDataDTO: session.basicDataDTO,
      prescription,
      invoice: invoiceData,
      discription: description.trim(),            // Plain text
      nestSessionDate: nextDate ? nextDate.toISOString() : null, // Fixed typo: 'next' vs 'nest'
      createdAt: new Date(session.startedAt).toISOString(),
      sealAt: new Date().toISOString(),
    };

    // 4. POST to backend
    // Since it's plain text, Spring's @RequestBody will map this easily
    await axiosInstance.post('/doctor/session-end', encounterModel);

    // 5. Success Flow
    endSession();
    toast.success('Session sealed. Encryption will be handled by the server.');
    navigate('/patients', { replace: true });

  } catch (err: any) {
    console.error('Failed to end session:', err);
    toast.error(err.response?.data?.message || 'Failed to end session.');
  } finally {
    setIsSubmitting(false);
  }
};
  return (
    <div className="space-y-6 max-w-4xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <Button
            variant="ghost"
            className="gap-2 -ml-2 mb-2"
            onClick={() => navigate('/session')}
          >
            <ArrowLeft className="h-4 w-4" /> Back to Session
          </Button>
          <h1 className="text-2xl font-bold">End Session</h1>
          <div className="flex items-center gap-2 text-sm text-muted-foreground mt-0.5">
            <Timer className="h-3.5 w-3.5" />
            <span className="font-mono">{elapsed}</span>
          </div>
        </div>
        <Button
          variant="ghost"
          className="gap-2"
          onClick={() => navigate('/session')}
        >
          <Edit2 className="h-4 w-4" />
          Edit Session
        </Button>
      </div>

      {/* Patient Info Preview */}
      <PatientInfoCard data={basicDataDTO} compact />

      {/* Prescriptions Preview */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Pill className="h-4 w-4 text-blue-500" />
            Prescriptions ({prescriptions.length})
          </CardTitle>
        </CardHeader>
        <CardContent>
          {prescriptions.length > 0 ? (
            <div className="space-y-3">
              {prescriptions.map((rx) => (
                <div
                  key={rx.localId}
                  className="p-3 rounded-lg bg-muted/50 border"
                >
                  <p className="font-medium">
                    {rx.diagnosis || 'No diagnosis'}
                  </p>
                  {rx.notes && (
                    <p className="text-sm text-muted-foreground mt-1">
                      {rx.notes}
                    </p>
                  )}
                  <div className="flex flex-wrap gap-2 mt-2">
                    {rx.medications.map((med, i) => (
                      <Badge key={i} variant="outline" className="font-normal">
                        {med.name} {med.dosage && `- ${med.dosage}`}
                        {' '}
                        ({med.timing.morning === '1' ? 'M' : ''}
                        {med.timing.afternoon === '1' ? 'A' : ''}
                        {med.timing.night === '1' ? 'N' : ''})
                        {' '}{med.mealTiming}
                      </Badge>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-sm text-muted-foreground text-center py-4">
              No prescriptions created during this session.
            </p>
          )}
        </CardContent>
      </Card>

      {/* Session Description */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <FileText className="h-4 w-4 text-green-500" />
            Session Description
          </CardTitle>
        </CardHeader>
        <CardContent>
          <Textarea
            placeholder="Describe what was discussed during this session, findings, recommendations..."
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            rows={4}
          />
        </CardContent>
      </Card>

      {/* Next Session Date */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <CalendarIcon className="h-4 w-4 text-purple-500" />
            Next Session Date
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex flex-col sm:flex-row gap-4">
            <Calendar
              mode="single"
              selected={nextDate}
              onSelect={setNextDate}
              disabled={(date) => date < new Date()}
              className="rounded-md border"
            />
            <div className="flex-1">
              {nextDate ? (
                <div className="p-4 rounded-lg bg-muted/50 border">
                  <p className="text-sm font-medium">Next appointment</p>
                  <p className="text-lg font-semibold mt-1">
                    {nextDate.toLocaleDateString('en-US', {
                      weekday: 'long',
                      year: 'numeric',
                      month: 'long',
                      day: 'numeric',
                    })}
                  </p>
                  <Button
                    variant="ghost"
                    size="sm"
                    className="mt-2 text-destructive"
                    onClick={() => setNextDate(undefined)}
                  >
                    Clear date
                  </Button>
                </div>
              ) : (
                <div className="p-4 rounded-lg bg-muted/50 border text-center">
                  <p className="text-sm text-muted-foreground">
                    Select a date for the next follow-up session (optional)
                  </p>
                </div>
              )}
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Invoice */}
      <Card>
        <CardHeader className="pb-3">
          <CardTitle className="text-base flex items-center gap-2">
            <Receipt className="h-4 w-4 text-orange-500" />
            Invoice
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {/* Invoice Items */}
          <div className="space-y-2">
            <div className="grid grid-cols-12 gap-2 text-xs font-medium text-muted-foreground px-1">
              <span className="col-span-5">Description</span>
              <span className="col-span-2">Qty</span>
              <span className="col-span-2">Unit Price</span>
              <span className="col-span-2">Total</span>
              <span className="col-span-1"></span>
            </div>

            {invoiceItems.map((item, index) => (
              <div key={index} className="grid grid-cols-12 gap-2 items-center">
                <Input
                  className="col-span-5"
                  placeholder="Service description"
                  value={item.description}
                  onChange={(e) =>
                    updateInvoiceItem(index, 'description', e.target.value)
                  }
                />
                <Input
                  className="col-span-2"
                  type="number"
                  min={1}
                  value={item.quantity}
                  onChange={(e) =>
                    updateInvoiceItem(
                      index,
                      'quantity',
                      parseInt(e.target.value) || 1
                    )
                  }
                />
                <Input
                  className="col-span-2"
                  type="number"
                  min={0}
                  step={0.01}
                  value={item.unitPrice || ''}
                  onChange={(e) =>
                    updateInvoiceItem(
                      index,
                      'unitPrice',
                      parseFloat(e.target.value) || 0
                    )
                  }
                />
                <span className="col-span-2 text-sm font-medium px-1">
                  {item.total.toFixed(2)}
                </span>
                <Button
                  variant="ghost"
                  size="icon"
                  className="col-span-1 h-8 w-8 text-destructive"
                  onClick={() =>
                    setInvoiceItems((prev) =>
                      prev.length > 1
                        ? prev.filter((_, i) => i !== index)
                        : prev
                    )
                  }
                  disabled={invoiceItems.length <= 1}
                >
                  <Trash2 className="h-3 w-3" />
                </Button>
              </div>
            ))}

            <Button
              variant="outline"
              size="sm"
              className="gap-1"
              onClick={() =>
                setInvoiceItems((prev) => [
                  ...prev,
                  { description: '', quantity: 1, unitPrice: 0, total: 0 },
                ])
              }
            >
              <Plus className="h-3 w-3" /> Add Item
            </Button>
          </div>

          {/* Totals */}
          <div className="border-t pt-4 space-y-2">
            <div className="flex justify-between text-sm">
              <span className="text-muted-foreground">Subtotal</span>
              <span>{subtotal.toFixed(2)}</span>
            </div>
            <div className="flex items-center justify-between text-sm gap-2">
              <span className="text-muted-foreground">Tax (%)</span>
              <Input
                className="w-20 h-8 text-right"
                type="number"
                min={0}
                max={100}
                value={taxRate || ''}
                onChange={(e) => setTaxRate(parseFloat(e.target.value) || 0)}
              />
            </div>
            <div className="flex items-center justify-between text-sm gap-2">
              <span className="text-muted-foreground">Discount</span>
              <Input
                className="w-20 h-8 text-right"
                type="number"
                min={0}
                value={discount || ''}
                onChange={(e) => setDiscount(parseFloat(e.target.value) || 0)}
              />
            </div>
            <div className="flex justify-between text-base font-semibold border-t pt-2">
              <span>Total</span>
              <span>{total.toFixed(2)}</span>
            </div>
          </div>
        </CardContent>
      </Card>

      {/* Submit */}
      <div className="flex gap-3 justify-end pb-8">
        <Button
          variant="outline"
          onClick={() => navigate('/session')}
          disabled={isSubmitting}
        >
          <Edit2 className="h-4 w-4 mr-2" />
          Back to Edit
        </Button>
        <Button
          onClick={handleSubmit}
          disabled={isSubmitting}
          className="gap-2 min-w-[160px]"
        >
          {isSubmitting ? (
            <>
              <Loader2 className="h-4 w-4 animate-spin" />
              Submitting...
            </>
          ) : (
            <>
              <Send className="h-4 w-4" />
              Submit & Seal Session
            </>
          )}
        </Button>
      </div>
    </div>
  );
}
