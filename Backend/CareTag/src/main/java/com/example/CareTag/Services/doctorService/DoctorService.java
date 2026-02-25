package com.example.CareTag.Services.doctorService;

import com.example.CareTag.DTOs.DoctorDTOs.PaitentSearchDTO;
import com.example.CareTag.DTOs.DoctorDTOs.PrecriptionRequestDTO;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.doctor.Precription;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.example.CareTag.Repos.doctor.PrecriptionRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

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
    private PrecriptionRepo  precriptionRepo;
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

    public void createPrecription(PrecriptionRequestDTO dto) {
        String docEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        Doctor doctor = doctorRepo.findByEmail(docEmail);
        Patient patient = paitentRepo.findByCareTagId(dto.getCareTagId());



        Link link = linkRepo.findByDocIdAndPaitentId(doctor.getId(), patient.getId());
        if(link==null){
            throw new RuntimeException("Link is not yet established");
        }
        Precription precription = Precription.builder().
        createdAt(LocalDateTime.now())
                .doctorId(doctor.getId())
                        .notes(dto.getNotes())
                                .diagnosis(dto.getDiagnosis())
                                        .status(dto.getStatus())
                                                .patientId(patient.getId())
                                                        .maxRefills(dto.getMaxRefills())
                                                                .medications(dto.getMedications())
                                                                        .validTill(dto.getValidTill())
                                                                                .

                build();
            precriptionRepo.save(precription);

    }

}
