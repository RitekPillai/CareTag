package com.example.CareTag.configs;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true, value = { "coordinates" })
public abstract class GeoJsonPointMixin {
  @JsonCreator
  public GeoJsonPointMixin(@JsonProperty("x") double x, @JsonProperty("y") double y) {
  }
}
