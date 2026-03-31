package com.example.CareTag.Repos.Hospital;

import com.example.CareTag.Models.hospital.Hospital;
import org.springframework.data.geo.Circle;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HospitalRepo extends MongoRepository<Hospital, Long> {
  Hospital findByEmail(String email);

  boolean existsByEmail(String email);

  List<Hospital> findByMainBranchLocationWithin(Circle circle);

  @Query("{ 'branches.location': { $geoWithin: { $centerSphere: [[?0, ?1], ?2] } } }")
  List<Hospital> findByBranchLocationNear(double longitude, double latitude, double radiusInRadians);
}
