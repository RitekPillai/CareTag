import 'package:caretag/Modules/home/widgets/profilePageHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailPrescriptionPage extends StatelessWidget {
  const DetailPrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  width: double.infinity,
                  height: 300.h,

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff3B81F6).withAlpha(100),
                        Color(0xff3B81F6),
                        Color(0xff3B81F6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Row(children: [Icon(Icons.arrow_back, color: Colors.white)]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
