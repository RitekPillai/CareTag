import 'package:caretag/Features/auth/model/intro/ImageModel.dart';
import 'package:caretag/Features/auth/model_view/utils/animatedRoute.dart';
import 'package:caretag/Features/auth/view/Intro_page&permisson_page/permission_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intropage1 extends StatefulWidget {
  const Intropage1({super.key});

  @override
  State<Intropage1> createState() => _Intropage1State();
}

class _Intropage1State extends State<Intropage1> {
  int index = 0;
  double height = 300;
  int headingindex = 0;

  double _currentTopPadding = 50.0;

  @override
  Widget build(BuildContext context) {
    List<Imagemodel> images = [
      Imagemodel(
        path: "assets/images/intro/Image1.png",
        width: 363,
        height: 320,
      ), //0
      Imagemodel(
        path: "assets/images/intro/Image2.png",
        width: 317,
        height: 317,
      ), //1
      Imagemodel(
        path: "assets/images/intro/Image3.png",
        width: 317,
        height: 317,
      ),

      ///2
      Imagemodel(
        path: "assets/images/intro/Image4.png",
        width: 317,
        height: 317,
      ), //3
      Imagemodel(
        path: "assets/images/intro/Image5.png",
        width: 317,
        height: 317,
      ), //4
      Imagemodel(
        path: "assets/images/intro/Image6.png",
        width: 317,
        height: 317,
      ), //5
    ];

    List<String> headingTexts = [
      "Your Complete Health, In Your Hands.",
      "Unbreakable Security, Unquestionable Privacy",
      "From Records to Prescriptions, All in One Place",
      "Beyond Records: Medic",
      "Beyond Records: Medic & Journey",
    ];
    List<String> leadingText = [
      "CareTag empowers you with secure, instant access to your medical records and puts you in control of your health data, always.",
      "We use advanced blockchain technology and NFC to ensure your medical data is tamper-proof, private, and accessible only with your explicit consent.",

      "Manage your medical history, receive verifiable digital prescriptions, and ensure critical emergency info is always at hand. Streamlining your healthcare journey.",

      "Explore CareTag Medic for convenient medicine delivery right to your doorstep. Enjoy fast, secure, and reliable access to the prescriptions you need, whenever you need them.",
      "Explore CareTag Journey for personalized fitness tracking and actionable health insights tailored just for you. Stay motivated with real-time progress tracking, goal-setting",
    ];

    /// -----------------------------------on pressed Button
    void onPressed() {
      setState(() {
        index++;
        if (index > 0) {
          headingindex++;
          _currentTopPadding = _currentTopPadding = 5.0;
        }
        if (index != 0) {
          height = 700;
        }
        if (index == 6) {
          index = index - 1;
          Navigator.push(context, customRoute(PermissionPage()));
        }
        debugPrint(index.toString());
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),

          ////----------------------------Welcome To careTag
          AnimatedSize(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: Column(
              children: [
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Welcome to",

                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      color: AppColor.darkishBlue,
                      fontSize: index == 0 ? 50 : 35,
                    ),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  "CareTag",

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    color: AppColor.darkishBlue,
                    fontSize: index == 0 ? 50 : 35,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Image.asset(
                images[index].path,
                width: images[index].width,
                height: images[index].height,
                fit: BoxFit.cover,
                key: ValueKey<int>(index),
              ),
            ),
          ),
          Expanded(
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 500),
              tween: Tween<double>(begin: 10.0, end: _currentTopPadding),
              curve: Curves.easeIn,
              builder: (context, value, child) => Padding(
                padding: EdgeInsets.only(top: value),
                child: Container(
                  width: 393,
                  height: 423,

                  decoration: BoxDecoration(
                    color: AppColor.lightblueColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: index == 0 ? 50 : 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: index == 0
                            ? Text(
                                textAlign: TextAlign.center,
                                "CareTag bridges patients and doctors with secure, RFID-powered access to vital health records—anytime, anywhere.",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColor.textColor,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 500),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },

                                  child: Text(
                                    key: ValueKey<int>(headingindex - 1),
                                    textAlign: TextAlign.center,
                                    headingTexts[headingindex - 1],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: index == 0 ? 10 : 5),
                      index == 0
                          ? Column(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "By continuing, you accept ",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "T&C ",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: Color(0xff1D4ED8),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "and",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 13,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: " Privacy Policy",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color: Color(0xff1D4ED8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 500),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },

                                child: Text(
                                  key: ValueKey<int>(headingindex),
                                  textAlign: TextAlign.center,
                                  leadingText[headingindex - 1],
                                  style: GoogleFonts.poppins(
                                    color: AppColor.lightBlueTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 10),
                      index != 0
                          ? AnimatedSmoothIndicator(
                              activeIndex: headingindex - 1,
                              curve: Curves.easeInOut,
                              count: 5,
                              effect: ExpandingDotsEffect(
                                activeDotColor: Color(0xff0063F7),
                                dotColor: Color.fromRGBO(0, 99, 247, 0.65),
                                dotWidth: 7,
                                dotHeight: 7,
                                radius: 20,
                                spacing: 10,
                              ),
                            )
                          : Container(),
                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(89),
                          gradient: LinearGradient(
                            colors: [Color(0xff5B8DEF), Color(0xff0063F7)],
                          ),
                        ),

                        child: ElevatedButton(
                          onPressed: onPressed,
                          style: ButtonStyle(
                            shadowColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),

                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(89),
                              ),
                            ),
                            fixedSize: WidgetStatePropertyAll(Size(322, 74)),

                            backgroundColor: WidgetStatePropertyAll(
                              Colors.transparent,
                            ),
                          ),

                          child: Text(
                            index == 0 ? "Get Started" : "Next",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 36,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
