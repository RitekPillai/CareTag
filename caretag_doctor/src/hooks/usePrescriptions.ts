import { useQuery } from '@tanstack/react-query';
import axiosInstance from '@/utils/axiosInstance';

export interface PrescriptionMedication {
  name: string;
  dosage: string;
  frequency: string;
  duration: string;
}

export interface PrescriptionListItem {
  prescriptionID: string | null;
  dignosis: string | null;       // backend typo kept as-is
  paitentName: string | null;    // backend typo kept as-is
  refills: number;
  medications: PrescriptionMedication[];
  notes: string | null;
  creationDate: string | null;
  vaildTill: string | null;      // backend typo kept as-is
  status: string;
}

async function fetchPrescriptions(): Promise<PrescriptionListItem[]> {
  const response = await axiosInstance.get('/doctor/prescription/list');
  console.log('Raw prescription list response:', response.data);
  return Array.isArray(response.data) ? response.data : [];
}

export function usePrescriptions() {
  return useQuery<PrescriptionListItem[]>({
    queryKey: ['prescriptions'],
    queryFn: fetchPrescriptions,
  });
}
