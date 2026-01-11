package com.example.CareTag.Services.PaitentServices;

import com.example.CareTag.DTOs.PatientDTOs.RegistrationRequestDTO;
import com.example.CareTag.DTOs.PatientDTOs.SubscriberRequestDTO;
import com.example.CareTag.Models.Patient;
import com.example.CareTag.Models.ShippingDetails;
import com.example.CareTag.Models.Subscription;
import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.PatientRepo;
import com.example.CareTag.Repos.ShippingDetailsRepo;
import com.example.CareTag.Repos.SubscriptionRepo;
import com.example.CareTag.Repos.UserRepo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.time.LocalDateTime;


@Slf4j
@Service
public class PatientService {

    @Autowired
    private UserRepo userRepo;
    private  static final String ID_ALPHABET = "0123456789ABCDEF";
    private final SecureRandom random = new SecureRandom();
    @Autowired
    private PatientRepo paitentRepo;
    @Autowired
    private SubscriptionRepo subscriptionRepo;
    @Autowired
  private   ShippingDetailsRepo shippingDetailsRepo;
@Autowired
private MongoTemplate  mongoTemplate;

@Autowired
private PaitentCacheService paitentCacheService;
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
        paitentCacheService.saveCareTagId(String.valueOf(patient.getId()),careTagId);
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


    public LocalDateTime getExpriationDate(String subscriptionType){
        if(subscriptionType.equals("YEARLY")){
            return LocalDateTime.now().plusYears(1);
        }
        else{
            return LocalDateTime.now().plusMonths(1);
        }
    }

    public void setSubscriber(SubscriberRequestDTO req) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User) authentication.getPrincipal();


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
        mongoTemplate.updateFirst(query,update,Patient.class);


        String careTagId = paitentCacheService.getCareTagId(String.valueOf(user.getId()));


        ShippingDetails details = ShippingDetails.builder()
                .city(req.getCity())
                .careTagID(careTagId)
                .fullname(req.getFullname())
                .phoneNumber(req.getPhoneNumber())
                .postalCode(req.getPostalcode())
                .streetaddress(req.getSteetAddress())
                .id(user.getId())
                .build();
        shippingDetailsRepo.save(details);
        log.info("Subscriber info and shipping info has been saved");















    }
}
