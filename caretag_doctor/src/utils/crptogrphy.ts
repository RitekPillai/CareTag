// 1. Storage: IndexedDB for Doctor's Private Key

const DB_NAME = "CareTagCrypto";
const DB_VERSION = 2; // Ensure this is the same everywhere
export const storePrivateKey = async (privateKey: CryptoKey): Promise<void> => {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open("CareTagCrypto", 2);
    request.onupgradeneeded = (e: any) => {
      const db = e.target.result;
      if (!db.objectStoreNames.contains("keys")) db.createObjectStore("keys");
    };
    request.onsuccess = (e: any) => {
      const db = e.target.result;
      const tx = db.transaction("keys", "readwrite");
      const store = tx.objectStore("keys");
      const putRequest = store.put(privateKey, "doctor_private_key");
      putRequest.onsuccess = () => resolve();
      putRequest.onerror = () => reject(new Error("Failed to store key"));
    };
    request.onerror = () => reject(new Error("IndexedDB failed to open"));
  });
};



export const getPrivateKey = async (): Promise<CryptoKey | null> => {
  return new Promise((resolve, reject) => {
    // FIX: Change 1 to DB_VERSION (2)
    const request = indexedDB.open(DB_NAME, DB_VERSION); 
    
    request.onsuccess = (e: any) => {
      const db = e.target.result;
      // If the store doesn't exist yet, we can't get anything
      if (!db.objectStoreNames.contains("keys")) return resolve(null);
      
      const tx = db.transaction("keys", "readonly");
      const store = tx.objectStore("keys");
      const getReq = store.get("doctor_private_key");
      
      getReq.onsuccess = () => resolve(getReq.result as CryptoKey || null);
      getReq.onerror = () => reject(new Error("Failed to retrieve key"));
    };

    request.onerror = () => reject(new Error("Could not open DB"));
  });
};
// 2. Generation: RSA Key Pair
export const generateDoctorKeys = async () => {
  const keyPair = await window.crypto.subtle.generateKey(
    {
      name: "RSA-OAEP",
      modulusLength: 2048,
      publicExponent: new Uint8Array([1, 0, 1]),
      hash: "SHA-256",
    },
    true,
    ["encrypt", "decrypt"]
  );

  const exportedPublic = await window.crypto.subtle.exportKey("spki", keyPair.publicKey);
  const publicKeyString = btoa(String.fromCharCode(...new Uint8Array(exportedPublic)));

  return { privateKey: keyPair.privateKey, publicKeyString };
};

// 3. Helpers: Formatting
const base64ToArrayBuffer = (base64: string): ArrayBuffer => {
  const binaryString = window.atob(base64);
  const bytes = new Uint8Array(binaryString.length);
  for (let i = 0; i < binaryString.length; i++) {
    bytes[i] = binaryString.charCodeAt(i);
  }
  return bytes.buffer;
};

// 4. Core Decryption Logic (Matching Java/Flutter)
export const decryptPatientRecord = async (
  combinedBase64: string, 
  wrappedAesKeyBase64: string, 
  doctorPrivateKey: CryptoKey
) => {
  try {
    // 1. RSA DECRYPT (The AES Key)
    const encryptedKeyBuffer = base64ToArrayBuffer(wrappedAesKeyBase64);
    
    const aesKeyBuffer = await window.crypto.subtle.decrypt(
      {
        name: "RSA-OAEP",
        // If you change Flutter to "", use empty Uint8Array here:
        label: new Uint8Array(0) 
      },
      doctorPrivateKey,
      encryptedKeyBuffer
    );

    // 2. IMPORT AES KEY
    const aesKey = await window.crypto.subtle.importKey(
      "raw",
      aesKeyBuffer,
      "AES-GCM",
      false,
      ["decrypt"]
    );

    // 3. UNPACK JAVA BLOB
    const combinedBuffer = new Uint8Array(base64ToArrayBuffer(combinedBase64));
    
    // Slicing matching your Java: [IV(12)] + [Cipher] + [MAC(16)]
    const iv = combinedBuffer.slice(0, 12);
    const dataWithTag = combinedBuffer.slice(12);

    // 4. AES-GCM DECRYPT
    const decryptedBuffer = await window.crypto.subtle.decrypt(
      {
        name: "AES-GCM",
        iv: iv,
        tagLength: 128 // 16 bytes MAC = 128 bits
      },
      aesKey,
      dataWithTag
    );

    return new TextDecoder().decode(decryptedBuffer);

  } catch (error) {
    console.error("Crypto Error Details:", error);
    throw new Error("Handshake Failed: OperationError usually means the RSA label or AES Tag is wrong.");
  }
};