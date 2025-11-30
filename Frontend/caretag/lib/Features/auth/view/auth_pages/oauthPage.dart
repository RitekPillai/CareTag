import 'dart:math' as math;

import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Oauthpage extends StatefulWidget {
  const Oauthpage({super.key});

  @override
  State<Oauthpage> createState() => _OauthpageState();
}

class _OauthpageState extends State<Oauthpage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/lock.mp4");
    _controller.initialize();
    _controller.setLooping(true);
    _controller.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 82, left: 11),
            child: Text(
              textAlign: TextAlign.center,
              "Securely access your \n health, your way ",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: SizedBox(
              width: 333,
              height: 333,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          oauthRegTile("assets/images/auth/google.svg", "Continue with Google"),
          const SizedBox(height: 30),
          oauthRegTile(
            "assets/images/auth/Facebook.svg",
            "Continue with Facebook",
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: Divider(color: Colors.black, thickness: 0.5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "or",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Divider(color: Colors.black, thickness: 0.5),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Container(
            height: 50,

            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColor.gradientButtonColor),
              borderRadius: BorderRadius.circular(33),
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              child: Text(
                textAlign: TextAlign.center,
                "Log In with your password",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text.rich(
            TextSpan(
              text: "Don’t have an account? ",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: "Sign Up",
                  style: GoogleFonts.poppins(
                    color: AppColor.lightBlueTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColor.lightBlueTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget oauthRegTile(String path, String title) {
  return Container(
    width: 299,
    height: 39,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(width: 1, color: Color(0xffC2C2C2)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(path, height: 32, width: 32),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
