import 'package:caretag/Modules/records_module/view/widgets/doc_container_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/files_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/recommeded_tile.dart';
import 'package:caretag/Modules/records_module/view/widgets/record_option_containe_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordHomePage extends StatelessWidget {
  const RecordHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color recentFilesColor = Color(0xff111827);
    const Color blueTextColor = Color(0xff0063F7);
    const Color blueContainerColor = Color.fromRGBO(13, 127, 242, 0.1);
    const Color orangeContainerColor = Color.fromRGBO(249, 115, 22, 0.1);
    const Color purpleContainerColor = Color.fromRGBO(168, 85, 247, 0.1);
    const Color greenContainerColor = Color.fromRGBO(16, 185, 129, 0.1);
    const Color lightBlueTextColor = Color(0xff0D7FF2);
    const String imagePath = "assets/images/records";

    return Column(
      children: [
        SizedBox(height: 16.h),
        DocContainerTile(),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RecordOptionContaineTile(
              containerColor: blueContainerColor,
              imagePath: "$imagePath/med.svg",
              title: "Prescriptions",
            ),
            RecordOptionContaineTile(
              containerColor: orangeContainerColor,
              imagePath: "$imagePath/lab.svg",
              title: "Lab Reports",
            ),
            RecordOptionContaineTile(
              containerColor: purpleContainerColor,
              imagePath: "$imagePath/scan.svg",
              title: "Scans",
            ),
            RecordOptionContaineTile(
              containerColor: greenContainerColor,
              imagePath: "$imagePath/bill.svg",
              title: "Invoices",
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Files",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: recentFilesColor,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View All",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: lightBlueTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        FilesTile(),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsetsGeometry.only(left: 24.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textAlign: TextAlign.start,
              "Recommended Actions",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: recentFilesColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              RecommededTile(
                title: "Renew Insurance",
                date: "Expires in 12 days",
                buttonText: "Review Plan",
              ),
              SizedBox(width: 16.w),

              RecommededTile(
                title: "Annual Checkup",
                date: "Due next month",
                buttonText: "Schedule",
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
