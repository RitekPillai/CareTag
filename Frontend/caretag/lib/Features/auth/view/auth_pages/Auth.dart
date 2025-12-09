import 'package:caretag/constants/appConstants.dart';
import 'package:caretag/widgets/customController.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  final bool login;
  const AuthPage({super.key, required this.login});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  ///-------------page variables-----------------------------

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isLogin = widget.login;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
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
            AnimatedSwitcher(
              duration: Appconstants.duration,

              child: !isLogin
                  ? Text(
                      key: ValueKey(0),
                      "Welcome",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    )
                  : Text(
                      key: ValueKey(1),
                      "Welcome Back",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Colors.black,
                      ),
                    ),
            ),

            const SizedBox(height: 1),
            AnimatedSwitcher(
              duration: Appconstants.duration,
              child: !isLogin
                  ? Text(
                      key: ValueKey(0),
                      textAlign: TextAlign.center,
                      "Create your CareTag \n account!!!",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    )
                  : Text(
                      "Login!!",
                      key: ValueKey(1),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    ),
            ),
            const SizedBox(height: 20),

            AnimatedSwitcher(
              duration: Appconstants.duration,
              child: !isLogin
                  ? Text(
                      key: ValueKey(0),
                      textAlign: TextAlign.center,
                      "",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    )
                  : Text(
                      "Log in to stay connected to your care",
                      key: ValueKey(1),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.lightBlueTextColor2,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            customTextFiled("Email address", "Email address", emailController),
            const SizedBox(height: 17),
            AnimatedSize(
              duration: Appconstants.duration,
              curve: Curves.easeInOut,
              child: !isLogin
                  ? Column(
                      key: const ValueKey<int>(0),
                      children: [
                        customTextFiled(
                          "Phone number",
                          "Phone number",
                          phoneController,
                          textInputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 17),
                      ],
                    )
                  : const SizedBox.shrink(key: ValueKey<int>(1)),
            ),
            AnimatedSwitcher(
              duration: Appconstants.duration,
              child: !isLogin
                  ? Column(
                      key: ValueKey(0),
                      children: [
                        customTextFiled(
                          "Create your own Password",
                          "Create your own Password",
                          passwordController,
                          isPassword: true,
                          HintText:
                              "We recommend using complex passwords \n with a minimum length of 15 characters.",
                        ),
                      ],
                    )
                  : Column(
                      key: ValueKey(1),
                      children: [
                        customTextFiled(
                          "Password",
                          "Password",
                          passwordController,
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 50),

            Hero(
              tag: 'auth',
              child: customElevatedButton(
                58,
                253,
                !isLogin ? "Create" : "Continue",
                24,
                FontWeight.w700,
                () {},
              ),
            ),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  !isLogin
                      ? "Already have an account? "
                      : "Don't have an account?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColor.darkishBlue,
                    fontSize: 15,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    debugPrint("ButtonPressed");
                    debugPrint("CurrentIndex$isLogin");
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Text(
                    !isLogin ? "Login" : "Sign up",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColor.lightBlueTextColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.lightBlueTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                outhTile("assets/images/auth/google.svg"),
                outhTile("assets/images/auth/Facebook.svg"),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

Widget outhTile(String path) {
  return Container(
    width: 87,
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color(0xffC2C2C2)),
    ),
    child: Padding(
      padding: const EdgeInsets.all(11.0),
      child: SvgPicture.asset(path, width: 32, height: 32),
    ),
  );
}
