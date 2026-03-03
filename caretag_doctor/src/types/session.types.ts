export interface BasicDataDTO {
  fullName: string;
  bloodGroup: string;
  dob: string;
  address: string;
  careTagId: string;
  gender: string;
  height: string;
  weight: string;
  allergies: string;
  image: string;
}

export interface RecordResponseAcceptDTO {
  encounterId: string;
  patientId: number;
  encrptedAesKey: string;
  ciphyerText: string;
  docEmail: string;
  basicDataDTO: BasicDataDTO;
}

export interface RecordDenialMessage {
  status: 'DENIED';
}

export type RecordApprovalMessage = RecordResponseAcceptDTO | RecordDenialMessage;

export function isRecordAccepted(msg: RecordApprovalMessage): msg is RecordResponseAcceptDTO {
  return 'encounterId' in msg;
}

export interface SessionMedication {
  name: string;
  dosage: string;
  frequency: string;
  duration: string;
  timing: { morning: string; afternoon: string; night: string };
  mealTiming: string;
}

export interface SessionPrescription {
  localId: string;
  diagnosis: string;
  medications: SessionMedication[];
  notes: string;
}

export interface PrescriptionPayload {
  id: string | null;
  patientId: number;
  doctorId: number;
  encryptedData: string;
}

export interface EncounterModelPayload {
  id: string;
  patientId: number;
  docId: number;
  ecounterstatus: 'PENDING' | 'ACTIVE' | 'SEALED' | 'PURGED';
  encrptedAESKey: string;
  envrpytedBlob: string;
  xrayUrls: string[];
  basicDataDTO: BasicDataDTO;
  prescription: PrescriptionPayload;
  invoice: string;
  discription: string;
  nestSessionDate: string | null;
  createdAt: string;
  sealAt: string;
}

export interface InvoiceItem {
  description: string;
  quantity: number;
  unitPrice: number;
  total: number;
}

export interface InvoiceData {
  items: InvoiceItem[];
  subtotal: number;
  taxRate: number;
  discount: number;
  total: number;
}

export interface ActiveSessionState {
  encounterId: string;
  patientId: number;
  docId: number;
  docEmail: string;
  basicDataDTO: BasicDataDTO;
  decryptedMedicalData: any;
  aesKeyBytes: ArrayBuffer;
  encrptedAESKey: string;
  originalCipherText: string;
  xrayUrls: string[];
  prescriptions: SessionPrescription[];
  invoice: string;
  description: string;
  nextSessionDate: string | null;
  startedAt: number;
}
