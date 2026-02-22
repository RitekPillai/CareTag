import 'package:caretag/Modules/card_registration/data/model/medicarecordmodel.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_intro_page.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_loading_screen.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/customController.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/helpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:google_fonts/google_fonts.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  List<TextEditingController> _controllers = [];
  List<String> title = [
    "Full Name",
    "Date of Birth",
    "Permanent Home Address",
    "Blood Group",
    "Allegries",
    "Chronic Conditions",
    "Emergency Contact Name",
    "Emrgency Contact Number",
    "Past Surgeries",
    "Insurance Provider",
    "Insurance Policy Number",
    "Vaccination History",
    "Preferred HealthCare Facility or Doctor",
    "Drug Reactions or Intolerances",
    "Known Diagnoses or Simple Conditions",
    "Hereditary (Genetic) Health Conditions",
    "Do you Smoke?",
    "Do you Consume Alcohol",
    "Do you Exercise Regularly",
  ];

  List<String> hintText = [
    "Enter your full name",
    "DD/MM/YYYY",
    "Enter your address",
    "Enter your blood group",
    "Enter if you have any allergies",
    "Enter if you have any chronic co...",
    "Enter your emergency contact n...",
    "Enter emergency contact...",
    "Enter if any surgeries",
    "Enter your insurance provider name",
    "Enter your insurance policy no..",
    "Enter if taken any vaccination",
    "Enter your preferred doc or hospi.",
    "Enter if any allergies to medication",
    "Enter if any pre-existing med condit..",
    "Enter if any genetic conditions",
    "Answer in (yes/no/previously)",
    "Answer in (yes/no/previously)",
    "Answer in (yes/no/previously)",
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controllers = List.generate(19, (index) => TextEditingController());
    debugPrint(hintText.length.toString());
    debugPrint(title.length.toString());

    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PatientBloc>();
    TextEditingController addressController = TextEditingController();
    debugPrint(title.length.toString());
    debugPrint("hint Text length:${hintText.length.toString()}");
    debugPrint(_controllers.length.toString());
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            help(),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Create Your CareTag RFID",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColor.darkishBlue,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We’ll generate a unique RFID ID for you. This will act as\nyour secure digital key for accessing medical records.",
              style: GoogleFonts.poppins(
                color: AppColor.lightBlueTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              textAlign: TextAlign.center,
              "We will need few of your medical details to confirm",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 445,
              width: 481,
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,

                  itemBuilder: (context, index) {
                    if (title[index] == "Permanent Home Address") {
                      return Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Center(
                          child: customTextFiled(
                            title[index],
                            hintText[index],

                            hintText:
                                "You can enter your temporary  address if you don't have a permanent address.",
                            _controllers[index],
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Not Filled";
                              }
                              return null;
                            },
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: customTextFiled(
                          title[index],
                          hintText[index],
                          _controllers[index],

                          validator: (value) {
                            if (value == null || value == "") {
                              return "Not Filled";
                            }
                            return null;
                          },
                        ),
                      ),
                    );
                  },
                  itemCount: 19,
                ),
              ),
            ),
            Text(
              "*All the questions above are compulsory",
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                customElevatedButton(
                  37,
                  100,
                  "Back",
                  20,
                  FontWeight.bold,
                  () {
                    Navigator.pushReplacement(
                      context,
                      customRoute(RegistrationIntroPage(), bloc),
                    );
                  },
                  33,
                  [Color(0xff254799), Color(0xff1F2937)],
                ),
                customElevatedButton(37, 96, "Next", 20, FontWeight.w700, () {
                  debugPrint("buttonPressed");

                  final basicMedicalRecord = BasicPersonalDetails(
                    fullname: _controllers[0].text,
                    dob: _controllers[1].text,
                    address: _controllers[2].text,
                    bloodGroup: _controllers[3].text,
                  );
                  final medicalDetails = MedicalDetails(
                    allegries: _controllers[4].text,
                    chronicConditions: _controllers[5].text,
                    pastSurgeries: _controllers[6].text,
                    vaccinationHistory: _controllers[7].text,
                    prefferedDoctor: _controllers[8].text,
                    drugReactions: _controllers[9].text,
                    diagonoses: _controllers[10].text,
                    hereditaryGenetic: _controllers[11].text,
                  );
                  final emergencyDetails = EmergencyDetails(
                    contact: _controllers[12].text,
                    name: _controllers[13].text,
                  );
                  final insuranceDetails = InsuranceDetails(
                    policyNumber: _controllers[14].text,
                    provider: _controllers[15].text,
                  );
                  final lifeStyleDetails = LifeStyleDetails(
                    smoke: _controllers[16].text,
                    alcohal: _controllers[17].text,
                    excercise: _controllers[18].text,
                  );

                  final medicalRecord = Medicarecordmodel(
                    basicPersonalDetails: basicMedicalRecord,
                    medicalDetails: medicalDetails,
                    emergencyDetails: emergencyDetails,
                    insuranceDetails: insuranceDetails,
                    lifeStyleDetails: lifeStyleDetails,
                  );

                  Navigator.pushReplacement(
                    context,
                    customRoute(
                      RegistrationLoadingScreen(medicalDetails: medicalRecord),
                      context.read<PatientBloc>(),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
