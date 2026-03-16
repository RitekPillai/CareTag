package com.example.CareTag.controllers.Shared;

import com.example.CareTag.DTOs.commonDTOs.EncounterDTO;
import com.example.CareTag.Models.common.Block;
import com.example.CareTag.Services.BlockchainService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/blockchain")
@RequiredArgsConstructor
public class BlockchainController {

  private final BlockchainService blockchainService;

  @PostMapping("/seal")
  public ResponseEntity<Block> sealEncounter(@RequestBody EncounterDTO dto) {
    Block sealed = blockchainService.sealEncounter(dto);
    return ResponseEntity.ok(sealed);
  }

  @GetMapping("/validate")
  public ResponseEntity<Map<String, Object>> validateChain() {
    boolean valid = blockchainService.isChainValid();
    return ResponseEntity.ok(Map.of(
        "valid", valid,
        "blockCount", blockchainService.getChain().size()));
  }

  @GetMapping("/chain")
  public ResponseEntity<List<Block>> getChain() {
    return ResponseEntity.ok(blockchainService.getChain());
  }
}
