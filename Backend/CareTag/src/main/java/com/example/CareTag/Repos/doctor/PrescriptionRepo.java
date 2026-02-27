package com.example.CareTag.Repos.doctor;

import com.example.CareTag.Models.doctor.Prescription;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PrescriptionRepo extends MongoRepository<Prescription,String> {
    List<Prescription> findByDoctorId(Long doctorId);

    List<Prescription> findByPatientId(long patientId);
}
