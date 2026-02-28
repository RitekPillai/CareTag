package com.example.CareTag.Services;

import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;
@Service
public class FileService {
    @Autowired
    private BlobServiceClient blobServiceClient;

    @Value("${azure.storage.container-name}")
    private String containerName;


    public String uploadProfilePhoto(MultipartFile file)throws IOException {
        BlobContainerClient blobContainerClient = blobServiceClient.getBlobContainerClient(containerName);

        String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

        BlobClient blobClient = blobContainerClient.getBlobClient(fileName);

        blobClient.upload(file.getInputStream(), file.getSize(), true);

        return blobClient.getBlobUrl();

    }

    public void deleteOldImage(String imageUrl) {
        if (imageUrl == null || imageUrl.isEmpty()) return;

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
}
