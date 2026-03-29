import 'package:caretag/Modules/auth/data/intro/ImageModel.dart';
import 'package:caretag/utils/storage_service.dart';
import 'package:caretag/widgets/animated_route.dart';
import 'package:caretag/Modules/Intro_page&permisson_page/permission_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../auth/model_view/bloc/auth_bloc.dart' show AuthBloc;

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
    final authBloc = context.read<AuthBloc>();
    List<Imagemodel> images = [
      Imagemodel(
        path: "assets/images/intro/image1.svg",
        width: 363.w,
        height: 320.h,
      ), //0
      Imagemodel(
        path: "assets/images/intro/Image2.png",
        width: 317.w,
        height: 317.h,
      ), //1
      Imagemodel(
        path: "assets/images/intro/Image3.png",
        width: 317.w,
        height: 317.h,
      ),

      ///2
      Imagemodel(
        path: "assets/images/intro/image4.svg",
        width: 317.w,
        height: 317.h,
      ), //3
      Imagemodel(
        path: "assets/images/intro/Image5.png",
        width: 317.w,
        height: 317.h,
      ), //4
      Imagemodel(
        path: "assets/images/intro/Image6.png",
        width: 317.w,
        height: 317.h,
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

    void onPressed() async {
      if (index == 5) {
        final storageservice = Storageservice();

        await storageservice.setTrueNewUser();
        debugPrint("Storage updated: User is no longer 'New'");

        if (!mounted) return;

        Navigator.push(context, customRoute(const PermissionPage(), authBloc));
        return;
      }

      setState(() {
        index++;
        headingindex++;

        if (index > 0) {
          _currentTopPadding = 5.0;
          height = 700;
        }
      });

      debugPrint("Current Slide Index: $index");
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 10.h),
          SafeArea(
            child: AnimatedSize(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Welcome to\nCare Tag",

                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      color: AppColor.darkishBlue,
                      fontSize: index == 0 ? 50.sp : 35.sp,
                      height: 1.h,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: SvgPicture.asset(
                images[index].path,
                height: images[index].height,
                width: images[index].width,
                key: ValueKey<int>(index),
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        images[index].path,
                        width: images[index].width,
                        height: images[index].height,
                        key: ValueKey<int>(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
            tween: Tween<double>(begin: 10.0, end: _currentTopPadding),
            curve: Curves.easeIn,
            builder: (context, value, child) => Padding(
              padding: EdgeInsets.only(top: value),
              child: Container(
                width: 393.w,

                decoration: BoxDecoration(
                  color: AppColor.lightblueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.r),
                    topRight: Radius.circular(100.r),
                  ),
                ),

                child: SafeArea(
                  top: false,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: index == 0 ? 25.w : 15.w),
                        Padding(
                          padding: EdgeInsets.only(left: 15.w, right: 15.w),
                          child: index == 0
                              ? Text(
                                  textAlign: TextAlign.center,
                                  "CareTag bridges patients and doctors\nwith secure, RFID-powered access to\nvital health records—anytime, anywhere.",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColor.textColor,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 30.h),
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
                                        fontSize: 22.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(height: index == 0 ? 20.h : 5),
                        index == 0
                            ? Column(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text: "By continuing, you accept ",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13.sp,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "T&C ",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.sp,
                                            color: Color(0xff1D4ED8),
                                          ),
                                        ),
                                        TextSpan(
                                          text: "and",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13.sp,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: " Privacy Policy",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15.sp,
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
                        SizedBox(height: index == 0 ? 10.h : 36.h),
                        index != 0
                            ? AnimatedSmoothIndicator(
                                activeIndex: headingindex - 1,
                                curve: Curves.easeInOut,
                                count: 5,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: Color(0xff0063F7),
                                  dotColor: Color.fromRGBO(0, 99, 247, 0.65),
                                  dotWidth: 7.w,
                                  dotHeight: 7.h,
                                  radius: 20.r,
                                  spacing: 10,
                                ),
                              )
                            : Container(),
                        SizedBox(height: index == 0 ? 10.h : 21.h),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(89.r),
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
                                  borderRadius: BorderRadius.circular(89.r),
                                ),
                              ),
                              fixedSize: WidgetStatePropertyAll(
                                Size(322.w, 74.h),
                              ),

                              backgroundColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                            ),

                            child: Text(
                              index == 0 ? "Get Started" : "Next",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                fontSize: 36.sp,

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
          ),
        ],
      ),
    );
  }
}
