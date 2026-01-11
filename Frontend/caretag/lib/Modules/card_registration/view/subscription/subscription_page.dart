import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/subscription/shipping_reg_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/helpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Color selectedButtonColor = Color(0xff346EE3);
  Color selectButtonShawdowColor = Color.fromRGBO(52, 110, 227, 0.45);
  Color nonSelectdTextColor = Color(0xff14324E);
  Color greenBorderColor = Color.fromRGBO(77, 196, 42, 0.5);
  Color greenCircleColor = Color.fromRGBO(77, 196, 42, 0.25);
  Color blueBorderColor = Color.fromRGBO(52, 110, 227, 0.5);
  Color blueCircleColor = Color.fromRGBO(52, 110, 227, 0.25);

  bool isStandartedSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            help(),
            Text(
              textAlign: TextAlign.center,
              "Make Health Instantly Accessible",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Order your RFID-enabled CareTag card and carry your medical identity with just a tap",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColor.lightBlueTextColor2,
              ),
            ),
            const SizedBox(height: 5),

            Text(
              "Why Buy it?",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            subscriptionTile(
              "assets/images/subscription/key.png",
              "Instant Medical Access",
            ),
            subscriptionTile(
              "assets/images/subscription/car.png",
              "Emergency-Ready",
            ),
            subscriptionTile(
              "assets/images/subscription/protect.png",
              "Secure & Private",
            ),
            subscriptionTile(
              "assets/images/subscription/wifi.png",
              "Works Offline",
            ),
            subscriptionTile(
              "assets/images/subscription/blub.png",
              "Smarter Than a Wallet Card",
            ),
            subscriptionTile(
              "assets/images/subscription/card.png",
              "Simple & Portable",
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isStandartedSelected = true;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 150,

                    decoration: BoxDecoration(
                      boxShadow: [
                        isStandartedSelected
                            ? BoxShadow(
                                color: selectButtonShawdowColor,
                                blurRadius: 19,
                                offset: Offset(0, 4),
                              )
                            : BoxShadow(),
                      ],
                      color: isStandartedSelected
                          ? selectedButtonColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(52),
                    ),
                    child: Center(
                      child: Text(
                        "Standard PVC",
                        style: GoogleFonts.poppins(
                          color: isStandartedSelected
                              ? Colors.white
                              : nonSelectdTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isStandartedSelected = false;
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 170,

                    decoration: BoxDecoration(
                      boxShadow: [
                        !isStandartedSelected
                            ? BoxShadow(
                                color: selectButtonShawdowColor,
                                blurRadius: 19,
                                offset: Offset(0, 4),
                              )
                            : BoxShadow(),
                      ],
                      color: !isStandartedSelected
                          ? selectedButtonColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(52),
                    ),
                    child: Center(
                      child: Text(
                        "Metal Hybrid Card",
                        style: GoogleFonts.poppins(
                          color: !isStandartedSelected
                              ? Colors.white
                              : nonSelectdTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                subScriptionSelectionTile(
                  greenBorderColor,
                  greenCircleColor,
                  "Monthly",
                  "₹70/-",
                  "Billed monthly",
                ),
                subScriptionSelectionTile(
                  blueBorderColor,
                  blueCircleColor,
                  "Yearly",
                  "₹500/-",
                  "Billed annually",
                ),
              ],
            ),
            const SizedBox(height: 20),
            customElevatedButton(
              47,
              210,
              "Order My Card",
              20,
              FontWeight.w600,
              () {
                Navigator.push(
                  context,
                  customRoute(ShippingRegPage(), context.read<PatientBloc>()),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              "Ships in 4–7 days. Fully encrypted and ready to use.",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget subScriptionSelectionTile(
  Color borderColor,
  Color circleColor,
  String date,
  String price,
  String description,
) {
  return Container(
    height: 136,
    width: 177,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: borderColor),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: circleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              price,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsGeometry.only(left: 8),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget subscriptionTile(String imagePath, String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      width: 323,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
            color: Color.fromRGBO(52, 110, 227, 0.35),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Image.asset(imagePath, height: 35, width: 35),
          ),

          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}
