package com.example.CareTag.Services.doctorService;

import com.example.CareTag.DTOs.DoctorDTOs.PaitentSearchDTO;
import com.example.CareTag.DTOs.DoctorDTOs.PrescriptionRequestDTO;
import com.example.CareTag.DTOs.DoctorDTOs.PrescriptionListDTO;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.doctor.Prescription;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.example.CareTag.Repos.doctor.PrescriptionRepo;
import com.example.CareTag.Services.AuthServices.CryptographicService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Service
public class DoctorService {
    @Autowired
    private DoctorRepo doctorRepo;
    @Autowired
    private LinkRepo linkRepo;
    @Autowired
    private PaitentRepo paitentRepo;

    @Autowired
    private PrescriptionRepo precriptionRepo;

    @Value("${crpytographic.aes-key}")
   private String aesKey;


    public ResponseEntity<?> getPaitents() {

        String docEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        Doctor doctor = doctorRepo.findByEmail(docEmail);


        List<Link>  links = linkRepo.findByDocId(doctor.getId());
return  ResponseEntity.ok().body(doctor);

    }

    public List<PaitentSearchDTO> paitentSearch(String query) {

        List<Patient> patients = paitentRepo.findByFullNameContainingIgnoreCase(query);

        List<PaitentSearchDTO> dtoList =  patients.stream().map(patient -> {return new  PaitentSearchDTO(patient.getFullName(),patient.getCareTagId()); }).toList();
   log.info("PaitentSearch DTOList:"+ dtoList);
   return  dtoList;

    }

    public void createPrecription(PrescriptionRequestDTO dto) throws Exception {
        log.info("in");
        String docEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        Doctor doctor = doctorRepo.findByEmail(docEmail);
        Patient patient = paitentRepo.findByCareTagId(dto.getCareTagId());

        dto.setDoctorName(doctor.getFullName());
        dto.setPaitentName(patient.getFullName());
        dto.setClinicName(doctor.getClinicName());
        dto.setSpeclization(doctor.getSpecialization());
        dto.setCreatedAt(LocalDateTime.now());



        Link link = linkRepo.findByDocIdAndPaitentId(doctor.getId(), patient.getId());
        if(link==null){
            throw new RuntimeException("Link is not yet established");
        }



        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);


        String prescriptionJson = objectMapper.writeValueAsString(dto);

     String encryptedData =    CryptographicService.encrypt(prescriptionJson,aesKey);


        Prescription prescription  = Prescription.builder()
                .doctorId(doctor.getId())
                .patientId(patient.getId())
                .encryptedData(encryptedData)
                .build();

     log.info("Encryted Data:{}",encryptedData);


     precriptionRepo.save(prescription);
log.info("Precription Created Successfully");
    }



        public List<PrescriptionListDTO> getPrecriptionList() {
            String email = SecurityContextHolder.getContext().getAuthentication().getName();
            Doctor doctor = doctorRepo.findByEmail(email);

            List<Prescription> listPrescription = precriptionRepo.findByDoctorId(doctor.getId());
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule());
            objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

            return listPrescription.stream().map(prescription -> {
                try {
                    String json = CryptographicService.decrypt(prescription.getEncryptedData(), aesKey);

                    PrescriptionRequestDTO dto = objectMapper.readValue(json, PrescriptionRequestDTO.class);

                    return PrescriptionListDTO.builder()
                            .dignosis(dto.getDiagnosis())
                            .paitentName(dto.getPaitentName())
                            .refills(dto.getMaxRefills())
                            .medications(dto.getMedications())
                            .notes(dto.getNotes())
                            .creationDate(dto.getCreatedAt())
                            .vaildTill(dto.getValidTill())
                            .status(dto.getStatus())
                            .build();
                } catch (Exception e) {
                 log.info(Arrays.toString(e.getStackTrace()));
                    log.error("Decryption failed for prescription ID: {}", prescription.getId());
                    throw new RuntimeException("Secure data access error", e);
                }
            }).toList();


    }

}
