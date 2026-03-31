package com.example.CareTag.Services;

import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;
import java.util.UUID;

@Service
public class FileService {
  @Autowired
  private BlobServiceClient blobServiceClient;

  @Value("${azure.storage.container-name}")
  private String containerName;

  @Value("${azure.storage.hospital.container-name:hospitalprofile}")
  private String hospitalContainerName;

  public String uploadProfilePhoto(MultipartFile file) throws IOException {
    BlobContainerClient blobContainerClient = blobServiceClient.getBlobContainerClient(containerName);

    String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

    BlobClient blobClient = blobContainerClient.getBlobClient(fileName);

    blobClient.upload(file.getInputStream(), file.getSize(), true);

    return blobClient.getBlobUrl();

  }

  public String uploadBase64Image(String base64Data, String fileNamePrefix, String containerName) {
    if (base64Data == null || base64Data.isEmpty()) {
      return null;
    }
    try {
      String[] parts = base64Data.split(",");
      String actualBase64 = parts.length > 1 ? parts[1] : parts[0];

      byte[] decodedBytes = Base64.getDecoder().decode(actualBase64);
      InputStream dataStream = new ByteArrayInputStream(decodedBytes);

      String uniquefileName = fileNamePrefix + "_" + UUID.randomUUID().toString();

      BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);

      BlobClient blobClient = containerClient.getBlobClient(uniquefileName);

      blobClient.upload(dataStream, decodedBytes.length, true);

      return blobClient.getBlobUrl();
    } catch (Exception e) {
      System.out.println("error:" + e.toString());
      throw new RuntimeException("Failed to upload image to Azure container: " + containerName, e);

    }
  }

  public void deleteOldImage(String imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty())
      return;

    try {

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      BlobClient blobClient = blobServiceClient
          .getBlobContainerClient(containerName)
          .getBlobClient(fileName);

      blobClient.deleteIfExists();

    } catch (Exception e) {
      System.out.println("Failed to delete old image: " + e.getMessage());
    }
  }

  public String uploadToHospitalProfile(String base64Data, String fileNamePrefix) {
    return uploadBase64Image(base64Data, fileNamePrefix, hospitalContainerName);
  }

  public String uploadHospitalLogo(String base64Data) {
    return uploadToHospitalProfile(base64Data, "logo");
  }

  public String uploadHospitalRegistrationCertificate(String base64Data) {
    return uploadToHospitalProfile(base64Data, "registration_cert");
  }

  public String uploadHospitalClinicalLicense(String base64Data) {
    return uploadToHospitalProfile(base64Data, "clinical_license");
  }
}
