package com.example.CareTag.Models.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Document(collection = "ledger")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Block {

    @Id
    private String id;

    @Indexed(unique = true)
    private int index;

    private long timestamp;
    private String previousHash;
    private String hash;
    private String encounterData;
    private int nonce;


    public String calculateHash() {
        String input = index + timestamp + previousHash + encounterData + nonce;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashBytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-256 algorithm not available", e);
        }
    }


    public void mineBlock(int difficulty) {
        String target = "0".repeat(difficulty);
        hash = calculateHash();
        while (!hash.startsWith(target)) {
            nonce++;
            hash = calculateHash();
        }
    }
}
