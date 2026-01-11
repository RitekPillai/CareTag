import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/customController.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class NewCardPage extends StatefulWidget {
  const NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  //TODO:need to implement custom imput formatters
  TextEditingController cardHolderName = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  @override
  void dispose() {
    cardHolderName.dispose();
    cardNumber.dispose();
    expiryDate.dispose();
    cvv.dispose();
    super.dispose();
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color greyColor = Color(0xffA9ACB4);

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Add New Card",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                "Enter your card details to complete the payment",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
              const SizedBox(height: 10),
              customTextFiled(
                "Card Holder Name",
                "Enter card holder name",
                cardHolderName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Holder Name can not be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              customTextFiled(
                "Card Number",
                "4111 1111 1111 1111",
                cardNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Card Number can not be empty";
                  }
                  return null;
                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customTextFiled(
                      "Expiry Date",
                      "MM/YY",
                      expiryDate,
                      width: 101,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "empty";
                        }
                        return null;
                      },
                    ),
                    customTextFiled(
                      "CVV",
                      "123",
                      cvv,
                      width: 101,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "empty";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, top: 20, bottom: 30),
                child: Row(
                  children: [
                    FlutterSwitch(
                      width: 66,
                      height: 30,
                      borderRadius: 99,
                      inactiveColor: greyColor,

                      value: isSelected,
                      onToggle: (value) {
                        setState(() {
                          isSelected = value;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Save My Card",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Streamline your checkout process by adding a new card for future transactions. Your card information is secured with advanced encryption technology.",
                  style: GoogleFonts.poppins(
                    color: greyColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Hero(
                tag: "next",
                child: customElevatedButton(
                  47,
                  272,
                  "Next",
                  24,
                  FontWeight.w600,
                  () {
                    if (formKey.currentState!.validate()) {
                      if (isSelected) {
                        debugPrint("done saving to database");
                      } else {
                        debugPrint("dont save to database");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
