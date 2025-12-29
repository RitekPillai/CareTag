package com.example.CareTag.Services;

import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.UserRepo;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender javaMailSender;

    @Autowired
    private UserRepo userRepo;

    @Value("${spring.mail.username}")
    private String fromEmail;


    public void sendOtpEmail(String toEmail,String otpCode,String subject){
        User user  = userRepo.findByEmail(toEmail);
        SimpleMailMessage simpleMailMessage = new  SimpleMailMessage();
        simpleMailMessage.setTo(toEmail);
        simpleMailMessage.setFrom(fromEmail);
        simpleMailMessage.setSubject(subject);
        simpleMailMessage.setText("Hello " + user.getUsername()+"\n"+
                "Your One Time Password (OTP) for "+subject+" is: "+otpCode+"\n\n This code is valid for Only 5 minutes\nFrom CareTag Team:)");
        javaMailSender.send(simpleMailMessage);


        }


    public void sendVerificationEmail(String email, String token) throws MessagingException {

        String emailVerificationLink = "https://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/auth/verify?token=" + token;
        User user = userRepo.findByEmail(email);
        String username =user.getUsername();
        String personalizedGreeting = "<p>Hello " + username + ", Thank you for signing up! Please click the button below to verify your email address:</p>";

        String htmlContent = "<html>"
                + "<body>"
                + "<h2>Email Verification Required</h2>"
                + personalizedGreeting
                + "<table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"btn btn-primary\">"
                + "  <tbody>"
                + "    <tr>"
                + "      <td align=\"left\">"
                + "        <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">"
                + "          <tbody>"
                + "            <tr>"
                + "              <td> <a href=\"" + emailVerificationLink + "\" target=\"_blank\" style=\"display: inline-block; padding: 10px 20px; color: white; background-color: #007bff; border-radius: 5px; text-decoration: none;\">Verify Email Address</a> </td>"
                + "            </tr>"
                + "          </tbody>"
                + "        </table>"
                + "      </td>"
                + "    </tr>"
                + "  </tbody>"
                + "</table>"

                + "<p>This link will expire in 15 minutes.</p>"+
                "<p>ThankYou From CareTag Team:)</p>"
                + "</body>"
                + "</html>";

        MimeMessage mimeMessage = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, "utf-8");

        helper.setTo(email);
        helper.setSubject("Email Verification For Authentication");
        helper.setText(htmlContent, true);


        javaMailSender.send(mimeMessage);
    }

//    public void sendLoginOtpEmail(String email, String otpcode) {
//        User user  = userRepo.findByEmail(email);
//        SimpleMailMessage simpleMailMessage = new  SimpleMailMessage();
//        simpleMailMessage.setTo(email);
//        simpleMailMessage.setFrom(fromEmail);
//        simpleMailMessage.setSubject("Email Verification For Authentication");
//        simpleMailMessage.setText("Hello " + user.getUsername()+"\n"+
//                "Your One Time Password (OTP) for Login  is: "+otpcode+"\n\n This code is valid for Only 5 minutes\nFrom CareTag Team:)");
//        javaMailSender.send(simpleMailMessage);
//
//    }
}
