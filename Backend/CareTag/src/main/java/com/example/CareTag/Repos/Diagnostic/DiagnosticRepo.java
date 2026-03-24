package com.example.CareTag.Repos.Diagnostic;

import java.util.List;

import org.springframework.data.geo.Distance;
import org.springframework.data.geo.GeoResults;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.CareTag.Models.Diagnostic.DiagnosticCenter;
import org.springframework.data.geo.Point;

@Repository
public interface DiagnosticRepo extends MongoRepository<DiagnosticCenter, Long> {
  public GeoResults<DiagnosticCenter> findByLocationNear(Point location, Distance distance);
}
