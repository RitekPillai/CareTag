package com.example.CareTag.Services.PaitentServices;

import com.example.CareTag.DTOs.DoctorDTOs.PrescriptionRequestDTO;
import com.example.CareTag.DTOs.PatientDTOs.*;
import com.example.CareTag.Models.doctor.Doctor;
import com.example.CareTag.Models.Paitent.Patient;
import com.example.CareTag.Models.Paitent.PatientRecords;
import com.example.CareTag.Models.Paitent.ShippingDetails;
import com.example.CareTag.Models.Paitent.Subscription;
import com.example.CareTag.Models.common.Link;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.doctor.Prescription;
import com.example.CareTag.Repos.Paitent.PaitentRepo;
import com.example.CareTag.Repos.Paitent.PatientRecordsRepo;
import com.example.CareTag.Repos.Paitent.ShippingDetailsRepo;
import com.example.CareTag.Repos.Paitent.SubscriptionRepo;
import com.example.CareTag.Repos.common.LinkRepo;
import com.example.CareTag.Repos.common.UserRepo;
import com.example.CareTag.Repos.doctor.DoctorRepo;
import com.example.CareTag.Repos.doctor.PrescriptionRepo;
import com.example.CareTag.Services.AuthServices.CryptographicService;
import com.example.CareTag.Services.FileService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class PatientService {

  @Autowired
  private UserRepo userRepo;
  private static final String ID_ALPHABET = "0123456789ABCDEF";
  private final SecureRandom random = new SecureRandom();
  @Autowired
  private PatientRecordsRepo paitentRecordsRepo;
  @Autowired
  private PaitentRepo paitentRepo;
  @Autowired
  private SubscriptionRepo subscriptionRepo;
  @Autowired
  private ShippingDetailsRepo shippingDetailsRepo;

  @Autowired
  private DoctorRepo doctorRepo;

  @Autowired
  private LinkRepo linkRepo;
  @Autowired
  private MongoTemplate mongoTemplate;
  @Autowired
  private PrescriptionRepo prescriptionRepo;

  @Autowired
  private FileService fileService;
  @Value("${crpytographic.aes-key}")
  private String aesKey;
  @Autowired
  private PaitentCacheService paitentCacheService;

  public String careTagIdGenerator() {

    String newId;
    do {
      StringBuilder sb = new StringBuilder("CTG-");
      for (int i = 0; i < 8; i++) {
        if (i == 4) {
          sb.append("-");
        }
        sb.append(ID_ALPHABET.charAt(random.nextInt(ID_ALPHABET.length())));
      }
      newId = sb.toString();

    } while (paitentRepo.existsByCareTagId(newId));
    return newId;
  }

  public String registerMedicalRecord(RegistrationRequestDTO req) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    User user = (User) authentication.getPrincipal();
    // if (!authentication.isAuthenticated()) {
    // throw new RuntimeException("User not authenticated");
    // }

    User currentuser = userRepo.findByEmail(user.getEmail());
    if (paitentRepo.existsById(currentuser.getId())) {
      throw new RuntimeException("Medical record already exists for this user.");
    }

    String careTagId = careTagIdGenerator();
    BasicDataDTO basicDataDTO = req.getBasicDataDTO();
    log.info("--------------------------------------addresss:{}", basicDataDTO.getAddress());

    Patient paitent = Patient.builder()
        .id(currentuser.getId())
        .fullName(basicDataDTO.getFullName())
        .dob(basicDataDTO.getDob())
        .email(user.getEmail())
        .address(basicDataDTO.getAddress())
        .careTagId(careTagId)
        .bloodGroup(basicDataDTO.getBloodGroup())
        .fcmToken(req.getFcmToken())
        .build();

    paitentRepo.save(paitent);
    log.info("Paitent has beenn Created Successfully");

    PatientRecords patientRecords = PatientRecords.builder()
        .id(paitent.getId())
        .mac(req.getMac())
        .iv(req.getIv())
        .careTagId(careTagId)
        .cipherText(req.getCiphertext())
        .wrappedKey(req.getEncryptedAesKey())
        .rsaPublickey(req.getRsaPublicKey())
        .build();
    paitentRecordsRepo.save(patientRecords);
    log.info("Paitent Records has been Saved Successfully");

    /// paitentCacheService.saveCareTagId(String.valueOf(paitent.getId()),careTagId);
    return careTagId;

  }

  public ResponseEntity<MedicalRecordResponseDTO> getMedicalRecord() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    User user = (User) authentication.getPrincipal();
    Optional<PatientRecords> req = paitentRecordsRepo.findById(user.getId());
    if (req.isEmpty()) {
      throw new RuntimeException("Patient Record Not Found");
    }
    final PatientRecords record = req.get();
    MedicalRecordResponseDTO requestDTO = MedicalRecordResponseDTO.builder()
        .iv(record.getIv())
        .rsaPublicKey(record.getRsaPublickey())
        .encryptedAesKey(record.getWrappedKey())
        .mac(record.getMac())
        .ciphertext(record.getCipherText())

        .build();
    return ResponseEntity.ok(requestDTO);
  }

  public LocalDateTime getExpriationDate(String subscriptionType) {
    if (subscriptionType.equals("YEARLY")) {
      return LocalDateTime.now().plusYears(1);
    } else {
      return LocalDateTime.now().plusMonths(1);
    }
  }

  public void setSubscriber(SubscriberRequestDTO req) {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    User user = (User) authentication.getPrincipal();
    Optional<Patient> patient = paitentRepo.findById(user.getId());

    if (patient.isEmpty()) {
      throw new RuntimeException("Patient Not Found");
    }

    Subscription subscriber = Subscription.builder()

        .subscriberId(user.getId())
        .subscriberName(req.getFullname())
        .paymentType(req.getPaymentType())
        .whenPurchased(LocalDateTime.now())

        .subscriptionType(req.getSubscriptionType())
        .expirationDate(getExpriationDate(req.getSubscriptionType()))
        .build();
    subscriptionRepo.save(subscriber);
    Query query = new Query(Criteria.where("id").is(user.getId()));
    Update update = new Update().set("isSubscribed", true);
    mongoTemplate.updateFirst(query, update, PatientRecords.class);

    /// String careTagId =
    /// paitentCacheService.getCareTagId(String.valueOf(user.getId()));

    ShippingDetails details = ShippingDetails.builder()
        .city(req.getCity())
        .careTagID(patient.get().getCareTagId())
        .fullname(req.getFullname())
        .phoneNumber(req.getPhoneNumber())
        .postalCode(req.getPostalcode())
        .streetaddress(req.getSteetAddress())
        .id(user.getId())
        .build();
    shippingDetailsRepo.save(details);
    log.info("Subscriber info and shipping info has been saved");
  }

  public ResponseEntity<ProfileDataResponseDTO> getProfileData() {
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    User user = (User) authentication.getPrincipal();
    log.info(user.toString());

    Patient patientRedis = paitentCacheService.getPatientProfile(user.getId());

    if (patientRedis == null) {
      log.info("Paitent Profile data is not in the Redis");
    }

    Optional<Patient> patient = paitentRepo.findById(user.getId());
    if (patient.isEmpty()) {
      throw new RuntimeException("Paitent Record not Found");
    }
    Patient profileData = patient.get();
    paitentCacheService.savePatientProfile(profileData);

    return ResponseEntity.ok(
        ProfileDataResponseDTO.builder()
            .fullName(profileData.getFullName()).bloodGroup(profileData.getBloodGroup())
            .careTagId(profileData.getCareTagId()).imageUrl(profileData.getImageUrl()).build()

    );

  }

  public ResponseEntity<?> getDoctors() {
    String paitentEmail = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient paitent = paitentRepo.findByEmail(paitentEmail);
    List<Link> link = linkRepo.findByPaitentId(paitent.getId());
    if (link == null) {
      return ResponseEntity.ok("You have not Linked with No Doctors Yet");
    }
    List<Long> docIds = link.stream().map(Link::getDocId).toList();

    List<Doctor> doctors = doctorRepo.findAllById(docIds);

    List<DoctorDetailDTO> getDoctors = doctors.stream().map(doctor -> {
      return DoctorDetailDTO.builder().doctorName(doctor.getFullName()).id(doctor.getId())
          .hospitalName(doctor.getCity()).hospitalName(doctor.getClinicName())
          .specialization(doctor.getSpecialization()).build();
    }).toList();

    log.info("List of Doctors Link to" + paitent.getFullName() + "are " + getDoctors);
    return ResponseEntity.ok(getDoctors);
  }

  public List<PaitentPrescriptionListDTO> getAllPrescription() {

    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);

    List<Prescription> prescriptionList = prescriptionRepo.findByPatientId(patient.getId());
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.registerModule(new JavaTimeModule());
    objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    return prescriptionList.stream().map(prescription -> {

      try {

        String json = CryptographicService.decrypt(prescription.getEncryptedData(), aesKey);

        PrescriptionRequestDTO dto = objectMapper.readValue(json, PrescriptionRequestDTO.class);

        return PaitentPrescriptionListDTO.builder().prescriptionId(prescription.getId()).doctorName(dto.getDoctorName())
            .specialization(dto.getSpeclization()).hospitalName(dto.getClinicName())
            .prescriptionDate(dto.getCreatedAt()).diagnosis(dto.getDiagnosis()).status(dto.getStatus()).build();
      } catch (Exception e) {
        log.info(Arrays.toString(e.getStackTrace()));
        log.error("Decryption failed for prescription ID: {}", prescription.getId());
        throw new RuntimeException("Secure data access error", e);
      }
    }).toList();

  }

  public PrescriptionDetailDTO getPrescriptionDetails(String prescriptionId) throws Exception {
    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    log.info(email);

    Patient patient = paitentRepo.findByEmail(email);

    Optional<Prescription> prescriptionData = prescriptionRepo.findById(prescriptionId);
    if (prescriptionData.isEmpty()) {
      throw new RuntimeException("Prescription Not Found");
    }
    Prescription prescription = prescriptionData.get();
    log.info(String.valueOf(patient.getId()));
    log.info(String.valueOf(prescription.getPatientId()));
    if (patient.getId() != prescription.getPatientId()) {
      throw new RuntimeException("YOu can't access this prescription");
    }

    String dycrptedString = CryptographicService.decrypt(prescription.getEncryptedData(), aesKey);
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.registerModule(new JavaTimeModule());
    objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

    PrescriptionRequestDTO dto = objectMapper.readValue(dycrptedString, PrescriptionRequestDTO.class);

    PrescriptionDetailDTO prescriptionDetail = PrescriptionDetailDTO.builder()
        .notes(dto.getNotes())
        .hospitalName(dto.getHospitalName())
        .medications(dto.getMedications())
        .diagnosis(dto.getDiagnosis())
        .doctorName(dto.getDoctorName())
        .specialization(dto.getSpeclization()).build();

    return prescriptionDetail;
  }

  public void updateProfilePage(ProfileEditPaitentDTO dto) throws IOException {
    String email = SecurityContextHolder.getContext().getAuthentication().getName();
    Patient patient = paitentRepo.findByEmail(email);

    if (patient == null) {
      throw new RuntimeException("Patient not found");
    }

    if (dto.getFullName() != null && !dto.getFullName().isEmpty()) {
      patient.setFullName(dto.getFullName());
    }
    if (dto.getDob() != null && !dto.getDob().isEmpty()) {
      patient.setDob(dto.getDob());
    }
    if (dto.getGender() != null && !dto.getGender().isEmpty()) {
      patient.setGender(dto.getGender());
    }
    if (dto.getBloodGroup() != null && !dto.getBloodGroup().isEmpty()) {
      patient.setBloodGroup(dto.getBloodGroup());
    }
    if (dto.getHeight() != null && !dto.getHeight().isEmpty()) {
      patient.setHeight(dto.getHeight());
    }
    if (dto.getWeight() != null && !dto.getWeight().isEmpty()) {
      patient.setWeight(dto.getWeight());
    }
    if (dto.getAllergies() != null && !dto.getAllergies().isEmpty()) {
      patient.setAllergies(dto.getAllergies());
    }

    if (dto.getImage() != null && !dto.getImage().isEmpty()) {
      if (patient.getImageUrl() != null) {
        fileService.deleteOldImage(patient.getImageUrl());

      }
      String imageUrl = fileService.uploadProfilePhoto(dto.getImage());
      patient.setImageUrl(imageUrl);
    }
    paitentCacheService.deleteProfileCache(patient.getId());
    paitentRepo.save(patient);

  }
}
