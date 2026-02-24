import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UppersectionDenypage extends StatelessWidget {
  const UppersectionDenypage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color borderColor = Color.fromRGBO(239, 68, 68, 0.5);
    const Color shawdowColor = Color(0xffEF4444);
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 152.w,
            height: 152.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 1.5),
            ),
          ),

          Stack(
            children: [
              Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: shawdowColor,
                      blurRadius: 40,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/home/dialog/Icon.svg",
                    width: 40.w,
                    height: 50.h,
                  ),
                ),
              ),

              Positioned(
                top: 80,
                left: 80,
                child: SvgPicture.asset(
                  'assets/images/home/dialog/deny.svg',
                  width: 40.w,
                  height: 40.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
