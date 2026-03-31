package com.example.CareTag.Repos.Paitent;

import com.example.CareTag.Models.Paitent.Appointment;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AppointmentRepo extends MongoRepository<Appointment, Long> {
  List<Appointment> findByDoctorIdAndAppointmentDate(Long doctorId, String appointmentDate);

  boolean existsByDoctorIdAndAppointmentDateAndAppointmentTime(Long doctorId, String date, String time);
}
