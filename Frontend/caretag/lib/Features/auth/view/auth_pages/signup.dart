import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: TextButton(
              onPressed: () {},
              child: Align(
                alignment: AlignmentGeometry.topRight,
                child: Text(
                  "Help?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Welcome",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 32,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            textAlign: TextAlign.center,
            "Create your CareTag \n account!!!",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w800,
              fontSize: 30,
              color: AppColor.lightBlueTextColor2,
            ),
          ),
          const SizedBox(height: 15),

          customTextFiled("Email address", "Email address"),
          const SizedBox(height: 15),
          customTextFiled("Phone number", "Phone number"),
          const SizedBox(height: 15),
          customTextFiled(
            "Create your own Password",
            "Create your own Password",
          ),
          Text(
            textAlign: TextAlign.start,
            "We recommend using complex passwords \n with a minimum length of 15 characters.",
            style: GoogleFonts.poppins(
              color: Color(0xff757575),
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 80),

          Container(
            width: 253,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              gradient: LinearGradient(colors: AppColor.gradientButtonColor),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              onPressed: () {},
              child: Text(
                "Create",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text.rich(
            TextSpan(
              text: "Already have an account? ",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: AppColor.darkishBlue,
                fontSize: 15,
              ),
              children: [
                TextSpan(
                  text: "Login",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColor.lightBlueTextColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.lightBlueTextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 64,
                child: Divider(color: Colors.black, thickness: 0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "or continue with",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                width: 64,
                child: Divider(color: Colors.black, thickness: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              outhTile("assets/images/auth/google.svg"),
              outhTile("assets/images/auth/Facebook.svg"),
            ],
          ),
        ],
      ),
    );
  }
}

Widget customTextFiled(String text, String helperText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: 45,
        width: 316,
        child: TextField(
          decoration: InputDecoration(
            hintText: helperText,
            hintStyle: GoogleFonts.poppins(
              color: Color(0xff9E9E9E),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC2C2C2)),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC2C2C2)),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC2C2C2)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget outhTile(String path) {
  return Container(
    width: 87,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color(0xffC2C2C2)),
    ),
    child: SvgPicture.asset(path, width: 32, height: 32),
  );
}
