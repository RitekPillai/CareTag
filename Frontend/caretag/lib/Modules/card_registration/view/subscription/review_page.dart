import 'package:caretag/Modules/card_registration/data/model/shippingRegistration.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/subscription/success_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/animatedRoute.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatelessWidget {
  final Shippingregistration shippingregistration;
  final String title;
  final String imagePath;
  const ReviewPage({
    super.key,
    required this.shippingregistration,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    String limitWords(String text) {
      List<String> words = text.split(' ');
      if (words.length <= 20) return text;
      return '${words.take(20).join(' ')}...';
    }

    int subtotal = 500;
    int shippingFee = 20;
    int adminfee = 10;
    int total = subtotal + shippingFee + adminfee;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text(
              textAlign: TextAlign.center,
              "Review Your Order",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Make sure your details are correct before confirming",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColor.lightBlueTextColor2,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: headingTile("Order Summary"),
              ),
            ),
            Container(
              height: 120,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xffE7EAED), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Standard PVC Card(Japanese Style)",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xff031222),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/card/card.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Yearly Plan",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Text(
                          "Rs. 500",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: headingTile("Delivery Address"),
              ),
            ),

            Container(
              height: 140,
              width: 343,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xffE7EAED), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          limitWords(shippingregistration.fullName),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Edit",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xff031222),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Text(
                      "(+91${shippingregistration.phoneNumber})",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "${shippingregistration.steetAddress}\n${shippingregistration.city},${shippingregistration.province}\n${shippingregistration.postalcode}.",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: headingTile("Payment method"),
              ),
            ),
            Container(
              width: 350,
              height: 48,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColor.textFieldBorderColor,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 32,
                    width: 56,

                    decoration: BoxDecoration(
                      border: Border.all(width: 0.3),

                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: SvgPicture.asset(imagePath, height: 100, width: 100),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xff031222),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            const SizedBox(width: 5),
            SizedBox(
              width: 343.1,
              child: const Divider(thickness: 1, indent: 2),
            ),
            rowTile("Subtotal *(Design Cost)", subtotal.toString()),
            rowTile("Shipping Fee", shippingFee.toString()),
            rowTile("Admin Fee", adminfee.toString()),
            const SizedBox(height: 5),
            rowTile("Total ", total.toString()),
            const SizedBox(height: 15),
            customElevatedButton(
              50,
              343,
              "Create Order",
              16,
              FontWeight.bold,
              () {
                context.read<PatientBloc>().add(
                  SubscriptionEvent(shippingRegistration: shippingregistration),
                );
                Navigator.pushReplacement(
                  context,
                  customRoute(SuccessPage(), context.read<PatientBloc>()),
                );
              },
              12,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 167,
              child: Divider(thickness: 1.5, color: Colors.black),
            ),
            TextButton(
              style: ButtonStyle(
                shadowColor: WidgetStatePropertyAll(
                  Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Cancel Order",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget rowTile(String title, String amount) {
  Color textColor = Color(0xff031222);
  return Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: textColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            "Rs. $amount",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget headingTile(String heading) {
  Color textColor = Color(0xff031222);
  Color borderColor = Color(0xff14324E);
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        heading,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: textColor,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        height: 5,
        width: 45,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ],
  );
}
