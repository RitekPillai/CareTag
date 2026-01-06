package com.example.CareTag.Services.PaitentServices;

import com.example.CareTag.DTOs.PatientDTOs.RegistrationRequestDTO;
import com.example.CareTag.Models.Patient;
import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.PatientRepo;
import com.example.CareTag.Repos.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;


@Service
public class PatientService {

    @Autowired
    private UserRepo userRepo;
    private  static final String ID_ALPHABET = "0123456789ABCDEF";
    private final SecureRandom random = new SecureRandom();
    @Autowired
    private PatientRepo paitentRepo;

    public String careTagIdGenerator(){

        String newId;
        do{
            StringBuilder sb = new StringBuilder("CTG-");
            for(int i=0;i<8;i++){
                if(i==4){
                    sb.append("-");
                }
                sb.append(ID_ALPHABET.charAt(random.nextInt(ID_ALPHABET.length())));
            }
            newId = sb.toString();

        }while (paitentRepo.existsByCareTagId(newId));
        return  newId;
    }

    public String registerMedicalRecord(RegistrationRequestDTO req){
        Authentication   authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();
        if (!authentication.isAuthenticated()) {
            throw new RuntimeException("User not authenticated");
        }

        User currentuser = userRepo.findByEmail(user.getEmail());
        if (paitentRepo.existsById(currentuser.getId())) {
            throw new RuntimeException("Medical record already exists for this user.");
        }

        String careTagId = careTagIdGenerator();

        Patient patient = Patient.builder()
                .id(currentuser.getId())
                .mac(req.getMac())
                .iv(req.getIv())
                .careTagId(careTagId)
                .cipherText(req.getCiphertext())
                .wrappedKey(req.getEncryptedAesKey())
                .rsaPublickey(req.getRsaPublicKey())
                .status("ACTIVE")
                .build();
        paitentRepo.save(patient);
        return careTagId;





    }

    public ResponseEntity<RegistrationRequestDTO> getMedicalRecord(String careTagId) {

        Patient  req = paitentRepo.findByCareTagId(careTagId);
        if(req == null){
            throw new  RuntimeException("NOT FIND");
        }
        RegistrationRequestDTO dto = RegistrationRequestDTO.builder()
                .iv(req.getIv())
                .encryptedAesKey(req.getWrappedKey())
                .mac(req.getMac())
                .rsaPublicKey(req.getRsaPublickey())
                .ciphertext(req.getCipherText())
                .build();
return ResponseEntity.ok(dto);
    }
}
