import 'package:caretag/Modules/auth/data/auth/login_request.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/auth/view/auth_pages/emailVerification.dart';
import 'package:caretag/Modules/auth/view/auth_pages/otpp_age.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/card_registration/view/registration/registration_intro_page.dart';
import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/constants/appConstants.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/widgets/custom_controller.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custom_divider.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/help_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ///

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              help(),
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

              customTextFiled(
                "Email address",
                "Email address",
                emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    debugPrint("email empty");
                    return "email can not empty";
                  }
                  return null;
                },
              ),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                debugPrint("phone empty");
                                return "phone number can not empty";
                              }

                              return null;
                            },
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
                            hintText:
                                "We recommend using complex passwords \n with a minimum length of 15 characters.",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                debugPrint("password empty");
                                return "Password can not empty";
                              }
                              return null;
                            },
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

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                debugPrint("password empty");
                                return "Password can not empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
              ),

              SizedBox(height: isLogin ? 7 : 0),
              isLogin
                  ? Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OtpPage(email: emailController.text),
                              ),
                            );
                          },
                          child: Text("Forgot Password?"),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 50),

              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  final authBloc = context.read<AuthBloc>();
                  //for signup
                  if (state is SignUpCOmpleted) {
                    final paitentBloc = context.read<PatientBloc>();
                    Navigator.pushReplacement(
                      context,
                      customRoute(RegistrationIntroPage(), paitentBloc),
                    );
                  }

                  //// if login is sucess and everything loooks good goes to homePage
                  if (state is Authenticated) {
                    Navigator.pushReplacement(
                      context,
                      customRoute(Homepage(), authBloc),
                    );
                  }

                  /// login for the first time
                  if (state is LoginCompleted) {
                    Navigator.pushReplacement(
                      context,
                      customRoute(
                        OtpPage(email: emailController.text),
                        authBloc,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  if (state is AuthCompleted) {
                    Navigator.push(
                      context,
                      customRoute(
                        Emailverification(email: emailController.text),
                        authBloc,
                      ),
                    );
                  }

                  if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: Hero(
                  tag: 'auth',
                  child: customElevatedButton(
                    58,
                    253,
                    !isLogin ? "Create" : "Continue",
                    24,
                    FontWeight.w700,
                    () async {
                      if (_formKey.currentState!.validate()) {
                        if (!isLogin) {
                          context.read<AuthBloc>().add(
                            AuthSignUpRequest(
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                            ),
                          );
                        } else {
                          debugPrint("Button Pressedd");
                          context.read<AuthBloc>().add(
                            AuthLoginRequest(
                              loginRequest: LoginRequest(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
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
              customDivider("or continue with", 64),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  outhTile("assets/images/auth/google.svg", () {
                    debugPrint("button pressed");
                    context.read<AuthBloc>().add(AuthoauthLogin());

                    debugPrint("press");
                  }),
                  outhTile("assets/images/auth/Facebook.svg", () {
                    debugPrint("press");
                  }),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

Widget outhTile(String path, VoidCallback onTap) {
  return GestureDetector(
    onTap: () => onTap(),
    child: Container(
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
    ),
  );
}
