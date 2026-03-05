package com.example.CareTag.Services;

import com.example.CareTag.Models.common.Block;
import com.example.CareTag.Models.common.EncounterModel;
import com.example.CareTag.Models.doctor.Prescription;
import com.example.CareTag.Models.type.Ecounterstatus;
import com.example.CareTag.Repos.common.BlockRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
public class BlockchainService {

  private static final int DIFFICULTY = 2;
  private static final String GENESIS_PREVIOUS_HASH = "0";

  @Autowired
  private BlockRepository blockRepository;

  private final ObjectMapper objectMapper = new ObjectMapper();

  @PostConstruct
  public void init() {
    if (blockRepository.count() == 0) {
      Block genesis = Block.builder()
          .index(0)
          .timestamp(System.currentTimeMillis())
          .previousHash(GENESIS_PREVIOUS_HASH)
          .encounterData("GENESIS_BLOCK")
          .nonce(0)
          .build();
      genesis.mineBlock(DIFFICULTY);
      blockRepository.save(genesis);
      log.info("Genesis block created: {}", genesis.getHash());
    }
  }

  public Block sealEncounter(EncounterModel dto) {
    try {
      String encounterJson = objectMapper.writeValueAsString(new EncounterFingerprint(
          dto.getId(),
          dto.getPatientId(),
          dto.getDocId(),
          dto.getEcounterstatus(),
          dto.getEncrptedAESKey(),
          dto.getEnvrpytedBlob(),
          dto.getXrayUrls() != null
              ? dto.getXrayUrls().stream().map(this::sha256).toList()
              : List.of(),
          dto.getPrescription(),
          dto.getInvoice(),
          dto.getCreatedAt(),
          dto.getSealAt()

      ));

      Block lastBlock = blockRepository.findTopByOrderByIndexDesc()
          .orElseThrow(() -> new RuntimeException("Ledger is empty — Genesis block missing"));

      Block newBlock = Block.builder()
          .index(lastBlock.getIndex() + 1)
          .timestamp(System.currentTimeMillis())
          .previousHash(lastBlock.getHash())
          .encounterData(encounterJson)
          .nonce(0)
          .build();

      newBlock.mineBlock(DIFFICULTY);
      blockRepository.save(newBlock);

      log.info("Block #{} mined and sealed. Hash: {}", newBlock.getIndex(), newBlock.getHash());
      return newBlock;

    } catch (Exception e) {
      throw new RuntimeException("Failed to seal encounter", e);
    }
  }

  public boolean isChainValid() {
    List<Block> chain = blockRepository.findAll();
    chain.sort((a, b) -> Integer.compare(a.getIndex(), b.getIndex()));

    for (int i = 1; i < chain.size(); i++) {
      Block current = chain.get(i);
      Block previous = chain.get(i - 1);

      if (!current.getHash().equals(current.calculateHash())) {
        log.warn("Chain broken at block #{}: stored hash does not match recalculated hash", current.getIndex());
        return false;
      }

      if (!current.getPreviousHash().equals(previous.getHash())) {
        log.warn("Chain broken at block #{}: previousHash does not match block #{}'s hash",
            current.getIndex(), previous.getIndex());
        return false;
      }
    }

    if (!chain.isEmpty()) {
      Block genesis = chain.get(0);
      if (!genesis.getHash().equals(genesis.calculateHash())) {
        log.warn("Genesis block hash is invalid");
        return false;
      }
    }

    return true;
  }

  public List<Block> getChain() {
    List<Block> chain = blockRepository.findAll();
    chain.sort((a, b) -> Integer.compare(a.getIndex(), b.getIndex()));
    return chain;
  }

  private String sha256(String input) {
    try {
      MessageDigest digest = MessageDigest.getInstance("SHA-256");
      byte[] hashBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));
      StringBuilder hex = new StringBuilder();
      for (byte b : hashBytes) {
        String h = Integer.toHexString(0xff & b);
        if (h.length() == 1)
          hex.append('0');
        hex.append(h);
      }
      return hex.toString();
    } catch (NoSuchAlgorithmException e) {
      throw new RuntimeException("SHA-256 not available", e);
    }
  }

  private record EncounterFingerprint(
      String id,
      Long patientId,
      Long docId,
      Ecounterstatus ecounterstatus,

      String encrptedAESKey,

      String envrpytedBlob,
      List<String> fileUrls,
      Prescription prescription,
      String invoice,

      LocalDateTime createdAt,
      LocalDateTime sealAt) {
  }
}
