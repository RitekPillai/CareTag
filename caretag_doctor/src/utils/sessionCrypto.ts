import { getPrivateKey } from './crptogrphy';

/**
 * Decrypt the RSA-OAEP encrypted AES key using the doctor's private key from IndexedDB.
 * Returns the raw AES key bytes (32 bytes for AES-256).
 */
export async function decryptAesKey(encryptedBase64: string): Promise<ArrayBuffer> {
  const privateKey = await getPrivateKey();
  if (!privateKey) {
    throw new Error('Doctor private key not found in IndexedDB. Please re-register.');
  }

  const encryptedBytes = base64ToArrayBuffer(encryptedBase64);

  const aesKeyBytes = await window.crypto.subtle.decrypt(
    { name: 'RSA-OAEP', label: new TextEncoder().encode('CareTag-AES-KEY') },
    privateKey,
    encryptedBytes
  );

  return aesKeyBytes;
}

/**
 * Decrypt AES-256-GCM ciphertext.
 * Format: Base64(IV[12 bytes] + Ciphertext[variable])
 * Backend uses AES/GCM/NoPadding with 128-bit auth tag and 12-byte IV.
 */
export async function aesGcmDecrypt(
  cipherTextBase64: string,
  aesKeyBytes: ArrayBuffer
): Promise<string> {
  const combined = base64ToArrayBuffer(cipherTextBase64);
  const iv = combined.slice(0, 12);
  const ciphertext = combined.slice(12);

  const aesKey = await window.crypto.subtle.importKey(
    'raw',
    aesKeyBytes,
    { name: 'AES-GCM' },
    false,
    ['decrypt']
  );

  const decrypted = await window.crypto.subtle.decrypt(
    { name: 'AES-GCM', iv: new Uint8Array(iv), tagLength: 128 },
    aesKey,
    ciphertext
  );

  return new TextDecoder().decode(decrypted);
}

/**
 * Encrypt plaintext using AES-256-GCM.
 * Output format: Base64(IV[12 bytes] + Ciphertext[variable])
 * Matches the backend CryptographicService.encrypt format.
 */
export async function aesGcmEncrypt(
  plaintext: string,
  aesKeyBytes: ArrayBuffer
): Promise<string> {
  const iv = window.crypto.getRandomValues(new Uint8Array(12));
  const encoded = new TextEncoder().encode(plaintext);

  const aesKey = await window.crypto.subtle.importKey(
    'raw',
    aesKeyBytes,
    { name: 'AES-GCM' },
    false,
    ['encrypt']
  );

  const encrypted = await window.crypto.subtle.encrypt(
    { name: 'AES-GCM', iv, tagLength: 128 },
    aesKey,
    encoded
  );

  // Combine IV + ciphertext (same format as backend)
  const combined = new Uint8Array(iv.length + encrypted.byteLength);
  combined.set(iv, 0);
  combined.set(new Uint8Array(encrypted), iv.length);

  return arrayBufferToBase64(combined.buffer);
}

function base64ToArrayBuffer(base64: string): ArrayBuffer {
  const binary = atob(base64);
  const bytes = new Uint8Array(binary.length);
  for (let i = 0; i < binary.length; i++) {
    bytes[i] = binary.charCodeAt(i);
  }
  return bytes.buffer;
}

function arrayBufferToBase64(buffer: ArrayBuffer): string {
  const bytes = new Uint8Array(buffer);
  let binary = '';
  for (let i = 0; i < bytes.byteLength; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  return btoa(binary);
}
