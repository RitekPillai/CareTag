package com.example.CareTag.Services.PaitentServices;

import com.example.CareTag.DTOs.PatientDTOs.BookAppointmentReq;
import com.example.CareTag.Models.Paitent.Appointment;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Repos.Paitent.AppointmentRepo;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Services.AuthServices.DatabaseSeqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class AppointmentService {

  @Autowired
  private AppointmentRepo appointmentRepo;

  @Autowired
  private PaitentRepo paitentRepo;

  @Autowired
  private DatabaseSeqService databaseSeqService;

  // Standard clinic slots as seen in your UI
  private final List<String> STANDARD_SLOTS = Arrays.asList(
      "09:00 AM", "09:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM",
      "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", "05:30 PM");

  public List<String> getAvailableSlots(Long doctorId, String date) {
    // 1. Get all appointments for this doctor on this day
    List<Appointment> bookedAppointments = appointmentRepo.findByDoctorIdAndAppointmentDate(doctorId, date);

    // 2. Extract booked times
    List<String> bookedTimes = bookedAppointments.stream()
        .map(Appointment::getAppointmentTime)
        .toList();

    // 3. Filter out booked times from standard slots
    List<String> availableSlots = new ArrayList<>();
    for (String slot : STANDARD_SLOTS) {
      if (!bookedTimes.contains(slot)) {
        availableSlots.add(slot);
      }
    }
    return availableSlots;
  }

  public String bookAppointment(BookAppointmentReq req) throws Exception {
    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);

    // Double check to prevent double booking race conditions
    if (appointmentRepo.existsByDoctorIdAndAppointmentDateAndAppointmentTime(req.getDoctorId(), req.getDate(),
        req.getTime())) {
      throw new Exception("This slot is already booked. Please choose another time.");
    }

    long appointmentId = databaseSeqService.generateSequence(Appointment.SEQUENCE_NAME);

    Appointment appointment = Appointment.builder()
        .id(appointmentId)
        .patientId(patient.getId())
        .doctorId(req.getDoctorId())
        .appointmentDate(req.getDate())
        .appointmentTime(req.getTime())
        .status("CONFIRMED")
        .createdAt(LocalDateTime.now())
        .build();

    appointmentRepo.save(appointment);
    return "Appointment booked successfully!";
  }
}
