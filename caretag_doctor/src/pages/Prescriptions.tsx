import { useState, useMemo } from 'react';
import { useQueryClient } from '@tanstack/react-query';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger } from '@/components/ui/dropdown-menu';
import { Pill, Plus, User, FileText, Calendar, RefreshCw, MoreVertical, CheckCircle, XCircle, Loader2 } from 'lucide-react';
import { format, parseISO, isToday, isThisWeek, isThisMonth, subMonths, isAfter } from 'date-fns';
import { toast } from 'sonner';
import { PrescriptionPDFExport } from '@/components/prescriptions/PrescriptionPDFExport';
import { DrugInteractionChecker } from '@/components/prescriptions/DrugInteractionChecker';
import { PrescriptionTemplates } from '@/components/prescriptions/PrescriptionTemplates';
import { DosageCalculator } from '@/components/prescriptions/DosageCalculator';
import { PrescriptionFilters, PrescriptionFiltersState } from '@/components/prescriptions/PrescriptionFilters';
import { NewPrescriptionForm } from '@/components/prescriptions/NewPrescriptionForm';
import { usePrescriptions } from '@/hooks/usePrescriptions';
import axiosInstance from '@/utils/axiosInstance';

interface Medication {
  name: string;
  dosage: string;
  frequency: string;
  duration: string;
}

const STATUS_STYLES: Record<string, string> = {
  active: 'bg-success text-white',
  completed: 'bg-muted text-muted-foreground',
  cancelled: 'bg-destructive text-destructive-foreground',
};

export default function Prescriptions() {
  const queryClient = useQueryClient();
  const [filters, setFilters] = useState<PrescriptionFiltersState>({
    search: '',
    status: 'all',
    dateRange: 'all',
  });
  const [updatingId, setUpdatingId] = useState<string | null>(null);

  const { data: prescriptions = [], isLoading } = usePrescriptions();

  const updateStatus = async (prescriptionID: string, newStatus: 'completed' | 'cancelled') => {
    setUpdatingId(prescriptionID);
    try {
      await axiosInstance.put(`/doctor/prescription/${prescriptionID}/status`, { status: newStatus });
      queryClient.invalidateQueries({ queryKey: ['prescriptions'] });
      toast.success(`Prescription marked as ${newStatus}`);
    } catch (error: any) {
      console.error('Status update failed:', error?.response?.data ?? error);
      toast.error('Failed to update prescription status');
    } finally {
      setUpdatingId(null);
    }
  };

  const filteredPrescriptions = useMemo(() => {
    return prescriptions.filter(rx => {
      if (filters.search) {
        const q = filters.search.toLowerCase();
        if (
          !(rx.paitentName || '').toLowerCase().includes(q) &&
          !(rx.dignosis || '').toLowerCase().includes(q)
        ) return false;
      }
      if (filters.status !== 'all' && rx.status !== filters.status) return false;
      if (filters.dateRange !== 'all' && rx.creationDate) {
        const d = parseISO(rx.creationDate);
        if (filters.dateRange === 'today' && !isToday(d)) return false;
        if (filters.dateRange === 'week' && !isThisWeek(d)) return false;
        if (filters.dateRange === 'month' && !isThisMonth(d)) return false;
        if (filters.dateRange === 'quarter' && !isAfter(d, subMonths(new Date(), 3))) return false;
      }
      return true;
    });
  }, [prescriptions, filters]);

  const stats = {
    total: prescriptions.length,
    active: prescriptions.filter(p => p.status === 'active').length,
    completed: prescriptions.filter(p => p.status === 'completed').length,
    cancelled: prescriptions.filter(p => p.status === 'cancelled').length,
  };

  return (
    <div className="space-y-6 animate-fade-in">
      <div className="flex flex-col lg:flex-row lg:items-center lg:justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold tracking-tight">Prescriptions</h1>
          <p className="text-muted-foreground mt-1">{stats.active} active prescriptions</p>
        </div>
        <div className="flex flex-wrap gap-2">
          <DrugInteractionChecker />
          <DosageCalculator />
          <PrescriptionTemplates />
          <NewPrescriptionForm />
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <Card className="card-elevated">
          <CardContent className="p-4">
            <p className="text-sm text-muted-foreground">Total</p>
            <p className="text-2xl font-bold">{stats.total}</p>
          </CardContent>
        </Card>
        <Card className="card-elevated stat-glow-success">
          <CardContent className="p-4">
            <p className="text-sm text-muted-foreground">Active</p>
            <p className="text-2xl font-bold text-success">{stats.active}</p>
          </CardContent>
        </Card>
        <Card className="card-elevated">
          <CardContent className="p-4">
            <p className="text-sm text-muted-foreground">Completed</p>
            <p className="text-2xl font-bold text-muted-foreground">{stats.completed}</p>
          </CardContent>
        </Card>
        <Card className="card-elevated">
          <CardContent className="p-4">
            <p className="text-sm text-muted-foreground">Cancelled</p>
            <p className="text-2xl font-bold text-destructive">{stats.cancelled}</p>
          </CardContent>
        </Card>
      </div>

      <PrescriptionFilters filters={filters} onFiltersChange={setFilters} />

      <Card className="card-elevated">
        <CardHeader className="pb-4">
          <CardTitle className="flex items-center gap-2.5 text-lg font-semibold">
            <div className="h-8 w-8 rounded-lg bg-success/10 flex items-center justify-center">
              <Pill className="h-4.5 w-4.5 text-success" />
            </div>
            All Prescriptions
            {filteredPrescriptions.length !== prescriptions.length && (
              <Badge variant="secondary" className="ml-2">
                {filteredPrescriptions.length} of {prescriptions.length}
              </Badge>
            )}
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {isLoading ? (
            Array.from({ length: 5 }).map((_, i) => (
              <Skeleton key={i} className="h-28 rounded-xl" />
            ))
          ) : filteredPrescriptions.length > 0 ? (
            filteredPrescriptions.map((rx, index) => {
              const medications = (rx.medications || []) as Medication[];
              const isUpdating = updatingId === rx.prescriptionID;
              return (
                <div
                  key={rx.prescriptionID ?? index}
                  className="p-5 rounded-xl bg-muted/40 hover:bg-muted/70 transition-all duration-200 hover:shadow-sm animate-slide-up"
                  style={{ animationDelay: `${index * 30}ms` }}
                >
                  <div className="flex items-start justify-between mb-3">
                    <div className="flex items-center gap-4">
                      <div className="h-11 w-11 rounded-xl bg-success/10 flex items-center justify-center">
                        <User className="h-5 w-5 text-success" />
                      </div>
                      <div>
                        <p className="font-semibold">{rx.paitentName || 'Unknown Patient'}</p>
                        <p className="text-sm text-muted-foreground">{rx.dignosis || '—'}</p>
                      </div>
                    </div>

                    <div className="flex items-center gap-3">
                      <div className="text-right text-sm">
                        {rx.creationDate && (
                          <p className="text-muted-foreground flex items-center gap-1">
                            <Calendar className="h-3.5 w-3.5" />
                            {format(parseISO(rx.creationDate), 'MMM d, yyyy')}
                          </p>
                        )}
                        {rx.vaildTill && (
                          <p className="text-muted-foreground">
                            Valid until {format(parseISO(rx.vaildTill), 'MMM d, yyyy')}
                          </p>
                        )}
                      </div>

                      <Badge className={STATUS_STYLES[rx.status] ?? 'bg-muted'}>
                        {rx.status}
                      </Badge>

                      <PrescriptionPDFExport
                        variant="icon"
                        prescription={{
                          id: rx.prescriptionID || '',
                          patientName: rx.paitentName || 'Unknown',
                          caretagId: 'N/A',
                          diagnosis: rx.dignosis,
                          medications,
                          notes: rx.notes,
                          createdAt: rx.creationDate,
                          validUntil: rx.vaildTill,
                        }}
                      />

                      {rx.status === 'active' && (
                        <DropdownMenu>
                          <DropdownMenuTrigger asChild>
                            <Button variant="outline" size="icon" disabled={isUpdating} className="h-8 w-8">
                              {isUpdating
                                ? <Loader2 className="h-4 w-4 animate-spin" />
                                : <MoreVertical className="h-4 w-4" />
                              }
                            </Button>
                          </DropdownMenuTrigger>
                          <DropdownMenuContent align="end" className="w-52">
                            <DropdownMenuItem
                              className="gap-2 cursor-pointer py-2"
                              onClick={() => rx.prescriptionID && updateStatus(rx.prescriptionID, 'completed')}
                            >
                              <CheckCircle className="h-4 w-4 text-green-600" />
                              <span>Mark as Completed</span>
                            </DropdownMenuItem>
                            <DropdownMenuItem
                              className="gap-2 cursor-pointer py-2"
                              onClick={() => rx.prescriptionID && updateStatus(rx.prescriptionID, 'cancelled')}
                            >
                              <XCircle className="h-4 w-4 text-red-500" />
                              <span>Cancel Prescription</span>
                            </DropdownMenuItem>
                          </DropdownMenuContent>
                        </DropdownMenu>
                      )}
                    </div>
                  </div>

                  {rx.refills > 0 && (
                    <div className="flex items-center gap-2 mb-2">
                      <RefreshCw className="h-3.5 w-3.5 text-muted-foreground" />
                      <span className="text-sm text-muted-foreground">Max Refills: {rx.refills}</span>
                    </div>
                  )}

                  <div className="flex flex-wrap gap-2 mt-3">
                    {medications.map((med, i) => (
                      <Badge key={i} variant="outline" className="font-normal">
                        <Pill className="h-3 w-3 mr-1.5" />
                        {med.name} {med.dosage}
                      </Badge>
                    ))}
                  </div>

                  {rx.notes && (
                    <p className="text-sm text-muted-foreground mt-3 flex items-start gap-1.5">
                      <FileText className="h-3.5 w-3.5 mt-0.5 flex-shrink-0" />
                      {rx.notes}
                    </p>
                  )}
                </div>
              );
            })
          ) : (
            <div className="py-16 text-center">
              <Pill className="h-16 w-16 text-muted-foreground/30 mx-auto mb-4" />
              <h3 className="text-lg font-semibold">
                {prescriptions.length === 0 ? 'No prescriptions' : 'No matching prescriptions'}
              </h3>
              <p className="text-muted-foreground mt-1">
                {prescriptions.length === 0 ? 'Create your first prescription' : 'Try adjusting your filters'}
              </p>
              {prescriptions.length === 0 && (
                <NewPrescriptionForm trigger={
                  <Button className="mt-4 gap-2">
                    <Plus className="h-4 w-4" />New Prescription
                  </Button>
                } />
              )}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
