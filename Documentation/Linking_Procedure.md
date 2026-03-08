# Doctor-Patient Linking Process

This Document Explains How The linking of Doctor-Patient.

## Steps of Linking Process

```TypeScript
    try {
      setScanState('loading');

      const response = await axiosInstance.post('/link/request', caretagId, {
        headers: { 'Content-Type': 'text/plain' }
      });

```

Doctor Sends The Request either by Typing the CareTag Id.

which is the indentical Id for each patient either by manual typing or scanning
with their nfc card.

```TypeScript


const client = new Client({
        brokerURL: 'wss://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/ws',
        connectHeaders: { Authorization: `Bearer ${token}` },
        onConnect: () => {
          client.subscribe('/user/queue/approval', (message) => {
            console.log(message)

```

After sending request doctor react side will listen to the websocket for response.Websocket is used instead of http is because instead of hitting the server for server which is also know as brute request we open the pipe between the server and the react application and listens to that pipes for any responses.

```java

  @PostMapping("/request")
  public void requestPaitentPermission(@RequestBody String careTagId) throws InterruptedException {
    log.info("called");
    linkingService.PermissionRequest(careTagId);
  }

```

This code accepts only string that is patient caretag id and calls the PermissionRequest function for further processing.

```java

Link isLinked = linkRepo.findByDocIdAndPaitentId(doctor.getId(),patient.getId());
log.info(" isLinked:{}",isLinked);
if(isLinked!=null){
log.info("It is already linked there is no  need to link it");
simpMessagingTemplate.convertAndSendToUser(email,"/queue/approval", Map.of("status", "ALREADY SCANNED"));
return;
        }
boolean isBlocked =  reportRepo.existsByDocIdAndPatientId(doctor.getId(),patient.getId());
if(isBlocked){
    log.info("You have been blocked can not send request");
    return;
}
 
 ```

Link class is created when doctor and patient has been established the linked contains patient id, doctor id , a expired date and the  status of the link Approved,Expired or Blocked.

This code checks if the Already Linked has been Established by both if it is then sends a ALREADY SCANNED message to the doctor.Suppose if the patient has been blocked the doctor it does not process any further and returns it. No message been sent to doctor.

After all the condition checks we use FCM(FireBase Cloud Messaging) to sent the notification to the patient for approval.

```java

public class Link {

    @Id
    @MongoId
    private String linkId;
    @Indexed
    private Long docId;
    @Indexed
    private Long paitentId;
    private LocalDateTime expiryDate;
   private Status status;
}
```

This class acts as a entry point for any further processes like creating a session or writing a prescription and so on.  this class makes easy to work with blockchain , and getting the related information of 2 sides both doctor and patient easily without any need for doing any additional steps.
