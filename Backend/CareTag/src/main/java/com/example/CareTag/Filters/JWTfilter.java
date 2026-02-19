package com.example.CareTag.Filters;

import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.UserRepo;
import com.example.CareTag.Services.AuthServices.AuthUtil;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
@Slf4j
@Component
@RequiredArgsConstructor
public class JWTfilter extends OncePerRequestFilter {
   private final AuthUtil authUtil;
  private final  UserRepo userRepo;



    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
    try {
        final String requestHeader =   request.getHeader("Authorization");
        String path = request.getServletPath();
        if (path.startsWith("/oauth2/") || path.startsWith("/login/oauth2/")) {
            filterChain.doFilter(request, response);
            return;
        }


        if(requestHeader==null || !requestHeader.startsWith("Bearer ")){
            log.info("Invalid Headder");
            log.info(requestHeader);

            filterChain.doFilter(request, response);
            return;


        }

        String token =requestHeader.split("Bearer ")[1];
        String email =authUtil.getUsernameFromToken(token);
        log.info("Acess Token:{}",token);
        log.info("Authenticated Email: {}", email);

        if(email!=null && SecurityContextHolder.getContext().getAuthentication()==null){
            User user = userRepo.findByEmail(email);
            UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(user,null,user.getAuthorities());
            
            SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
            log.info("User {} successfully authenticated via JWT.", email);


        }
        filterChain.doFilter(request,response);

    } catch (Exception e) {
       log.info(e.getMessage());
    }
    }
}
