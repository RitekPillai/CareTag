    package com.example.CareTag.Services;
    
    import com.example.CareTag.DTOs.PatientDTOs.BasicDataDTO;
    import com.example.CareTag.DTOs.commonDTOs.RecordRequestAcceptDTO;
    import com.example.CareTag.DTOs.commonDTOs.RecordResponseAcceptDTO;
    import com.example.CareTag.Models.Paitent.Patient;
    import com.example.CareTag.Models.Paitent.PatientRecords;
    import com.example.CareTag.Models.common.EncounterModel;
    import com.example.CareTag.Models.common.Link;
    import com.example.CareTag.Models.common.Session;
    import com.example.CareTag.Models.doctor.Doctor;
    import com.example.CareTag.Models.type.Ecounterstatus;
    import com.example.CareTag.Repos.Paitent.PaitentRepo;
    import com.example.CareTag.Repos.Paitent.PatientRecordsRepo;
    import com.example.CareTag.Repos.common.EncounterRepo;
    import com.example.CareTag.Repos.common.LinkRepo;
    import com.example.CareTag.Repos.doctor.DoctorRepo;
    import lombok.RequiredArgsConstructor;
    
    import lombok.extern.slf4j.Slf4j;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.security.core.context.SecurityContextHolder;
    import org.springframework.stereotype.Service;
    import org.springframework.transaction.annotation.Transactional;
    
    import java.time.LocalDateTime;
    import java.util.Base64;
    import java.util.Optional;
    @RequiredArgsConstructor
    @Service
    @Slf4j
    public class RecordService {
    
        final PaitentRepo paitentRepo;
    
        final DoctorRepo doctorRepo;
    
        final LinkRepo linkRepo;
    
        final PatientRecordsRepo patientRecordsRepo;
    
        final EncounterRepo   encounterRepo;
    
    
    
        public RecordResponseAcceptDTO recordAccept(RecordRequestAcceptDTO dto) {
            String email = SecurityContextHolder.getContext().getAuthentication().getName();
            Patient patient = paitentRepo.findByEmail(email);
            Optional<Doctor> doctorData = doctorRepo.findById(Long.valueOf(dto.getDocId()));
            if(doctorData.isEmpty()){
                throw  new RuntimeException("doctor is null");
            }
            Doctor doctor = doctorData.get();
    
    
    
            Link link = linkRepo.findByDocIdAndPaitentId(doctor.getId(), patient.getId());
            if(link==null){
                throw new RuntimeException("Link is not yet established");
            }
            if(!LinkingService.isLinkedVaild(link)){
                throw new RuntimeException("Link is Expired or it has been blocked");
            }
            /// getting the paitent encrpyted blob
    
    
            Optional<PatientRecords> patientRecordsData  =  patientRecordsRepo.findById(patient.getId());
    
            if(patientRecordsData.isEmpty()){
                throw  new RuntimeException("PaitentRecords is not present");
    
            }
            PatientRecords  patientRecords =    patientRecordsData.get();
    
    
            Optional<EncounterModel> ecounterData = encounterRepo.findById(dto.getEncounterId());
            if(ecounterData.isEmpty()){
                throw new RuntimeException("Encounter  is not present");
            }
            EncounterModel encounter = ecounterData.get();
            encounter.setEncrptedAESKey(dto.getAesCrptedkey());
    
            // Combine IV + CipherText + MAC into a single blob
            // Doctor frontend expects: Base64(IV[12] + ciphertext + MAC[16])
            byte[] ivBytes = Base64.getDecoder().decode(patientRecords.getIv());
            byte[] cipherBytes = Base64.getDecoder().decode(patientRecords.getCipherText());
            byte[] macBytes = Base64.getDecoder().decode(patientRecords.getMac());
            byte[] combined = new byte[ivBytes.length + cipherBytes.length + macBytes.length];
            System.arraycopy(ivBytes, 0, combined, 0, ivBytes.length);
            System.arraycopy(cipherBytes, 0, combined, ivBytes.length, cipherBytes.length);
            System.arraycopy(macBytes, 0, combined, ivBytes.length + cipherBytes.length, macBytes.length);
            String combinedBase64 = Base64.getEncoder().encodeToString(combined);
    
            encounter.setEnvrpytedBlob(combinedBase64);
            encounter.setEcounterstatus(Ecounterstatus.ACTIVE);
    
    
            encounterRepo.save(encounter);
            log.info("Encounter Updated Successfully");
    
            return RecordResponseAcceptDTO.builder().basicDataDTO(
                    BasicDataDTO.builder().fullName(patient.getFullName()).bloodGroup(patient.getBloodGroup()).dob(patient.getDob()).address(patient.getAddress()).careTagId(patient.getCareTagId()).gender(patient.getGender()).height(patient.getHeight()).weight(patient.getWeight()).allergies(patient.getAllergies()).image(patient.getImageUrl()).build()
            ).docEmail(doctor.getEmail()).encounterId(encounter.getId()).patientId(patient.getId()).encrptedAesKey(dto.getAesCrptedkey()).ciphyerText(encounter.getEnvrpytedBlob()).build();
    
        }
    
        public void denyRequest(String encounterId) {
            Optional<EncounterModel> encounter = encounterRepo.findById(encounterId);
            if(encounter.isEmpty()){
                throw new RuntimeException("Encounter  is not present");
            }
            encounterRepo.delete(encounter.get());
            log.info("Reqeust Has been denied");
        }
    
    }
