import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/auth/view/auth_pages/auth.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, BlocProvider;
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
    final authBloc = context.read<AuthBloc>();
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

          const SizedBox(height: 15),

          Hero(
            tag: 'auth',
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: customElevatedButton(
                50,
                double.infinity,
                "Log In with your Password",
                20,
                FontWeight.w700,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newRouteContext) =>
                          BlocProvider<AuthBloc>.value(
                            value: authBloc,
                            child: const AuthPage(login: true),
                          ),
                    ),
                  );
                },
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don’t have an account? ",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthPage(login: false),
                    ),
                  );
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.poppins(
                    color: AppColor.lightBlueTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: AppColor.lightBlueTextColor,
                  ),
                ),
              ),
            ],
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
        //   SizedBox(height: 50, width: 50, child: SvgPicture.asset(path)),
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
