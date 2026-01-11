import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/subscription/new_card_page.dart';
import 'package:caretag/Modules/card_registration/view/subscription/review_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSelectionPage extends StatefulWidget {
  final Shippingregistration shippingregistration;
  const PaymentSelectionPage({super.key, required this.shippingregistration});

  @override
  State<PaymentSelectionPage> createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String paymentMode = "";
  String imagePath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, actions: []),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "Complete Your Purchase",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Text(
                textAlign: TextAlign.center,
                "Secure delivery & payment for your CareTag card",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColor.lightBlueTextColor2,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "Select mode of payment",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 40),
            paymentTile(
              "Recommended:",
              "assets/images/subscription/gpayy.svg",
              "Google Pay UPI",
              Icons.arrow_forward_ios_rounded,
              6,
              () {
                setState(() {
                  paymentMode = "Google Pay UPI";
                  imagePath = "assets/images/subscription/gpayy.svg";
                });
              },
            ),
            const SizedBox(height: 20),
            paymentTile(
              "Cards:",
              "assets/images/subscription/credit_card.svg",
              "Add debit or credit card",
              Icons.arrow_forward_ios_rounded,
              0,
              () {
                Navigator.push(
                  context,
                  customRoute(NewCardPage(), context.read<PatientBloc>()),
                );
              },
            ),
            const SizedBox(height: 20),
            paymentTile(
              "Pay by any UPI app:",
              "assets/images/subscription/upi.svg",
              "Add new UPI ID",
              Icons.add,
              2,
              () {
                setState(() {
                  paymentMode = "upi";
                  imagePath = "assets/images/subscription/upi.svg";
                });
              },
            ),
            const SizedBox(height: 20),
            paymentTile(
              "Wallets:",
              "assets/images/subscription/amazon.svg",
              "Amazon Pay Balance",
              Icons.add,
              0,
              () {
                setState(() {
                  paymentMode = "amazonPay";
                  imagePath = "assets/images/subscription/amazon.svg";
                });
              },
            ),
            const SizedBox(height: 40),
            Hero(
              tag: "next",
              child: customElevatedButton(
                47,
                182,
                "Next",
                20,
                FontWeight.w600,
                () {
                  widget.shippingregistration.paymentType = paymentMode;
                  Navigator.pushReplacement(
                    context,
                    customRoute(
                      ReviewPage(
                        shippingregistration: widget.shippingregistration,
                        title: paymentMode,
                        imagePath: imagePath,
                      ),
                      context.read<PatientBloc>(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget paymentTile(
  String header,
  String image,
  String title,
  IconData icon,
  double padding,
  VoidCallback onPressed,
) {
  Color greyColor = Color(0xff999692);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 7),
        child: Text(
          header,
          style: GoogleFonts.poppins(
            color: greyColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      Container(
        width: 350,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.textFieldBorderColor),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 10),
            Container(
              padding: EdgeInsets.all(padding),
              height: 32,
              width: 56,

              decoration: BoxDecoration(
                border: Border.all(width: 0.3),

                borderRadius: BorderRadius.circular(5),
              ),
              child: title == "Recommended:"
                  ? Hero(
                      tag: "hero",

                      child: SvgPicture.asset(image, height: 100, width: 100),
                    )
                  : SvgPicture.asset(image, height: 100, width: 100),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 15),
            IconButton(icon: Icon(icon), onPressed: onPressed),
            const SizedBox(width: 5),
          ],
        ),
      ),
    ],
  );
}
