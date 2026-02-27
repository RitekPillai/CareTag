// src/utils/cryptoUtils.ts

export const storePrivateKey = async (privateKey: CryptoKey): Promise<void> => {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open("CareTagCrypto", 1);

    request.onupgradeneeded = (e: IDBVersionChangeEvent) => {
      const target = e.target as IDBOpenDBRequest;
      const db = target.result;
      if (!db.objectStoreNames.contains("keys")) {
        db.createObjectStore("keys");
      }
    };

    request.onsuccess = (e: Event) => {
      const target = e.target as IDBOpenDBRequest; 
      const db = target.result;
      const tx = db.transaction("keys", "readwrite");
      const store = tx.objectStore("keys");
      const putRequest = store.put(privateKey, "doctor_private_key");
      
      putRequest.onsuccess = () => resolve();
      putRequest.onerror = () => reject(new Error("Failed to store key"));
    };

    request.onerror = () => reject(new Error("IndexedDB failed to open"));
  });
};
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

  return { 
    privateKey: keyPair.privateKey, 
    publicKeyString 
  };
};
export const getPrivateKey = async (): Promise<CryptoKey | null> => {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open("CareTagCrypto", 1);

    request.onsuccess = (e: Event) => {
      const target = e.target as IDBOpenDBRequest;
      const db = target.result;
      
      if (!db.objectStoreNames.contains("keys")) {
        return resolve(null);
      }

      const tx = db.transaction("keys", "readonly");
      const store = tx.objectStore("keys");
      const getReq = store.get("doctor_private_key");

      getReq.onsuccess = () => resolve(getReq.result as CryptoKey);
      getReq.onerror = () => reject(new Error("Failed to retrieve key"));
    };
    
    request.onerror = () => reject(new Error("Could not open DB"));
  });
};