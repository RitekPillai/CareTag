import 'package:caretag/Modules/card_registration/model_view/service/bluetoothService.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/barchart.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/currentdate.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class StepcountCard extends StatefulWidget {
  const StepcountCard({super.key});

  @override
  State<StepcountCard> createState() => _StepcountCardState();
}

class _StepcountCardState extends State<StepcountCard> {
  Storageservice storageservice = Storageservice();
  Bluetooothservice bluetoothService = Bluetooothservice();

  String? savedId;
  @override
  void initState() {
    super.initState();
    _connectToBluetoothId();
  }

  Future<void> _connectToBluetoothId() async {
    debugPrint("Inside the Function");

    final box = await Hive.openBox('health_vault');

    String? id = await box.get("watchId");
    if (mounted) {
      setState(() {
        savedId = id;
        debugPrint("Watch ID:$savedId");
      });
    } else {
      debugPrint("No watch ID saved in storage.");
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color.fromRGBO(250, 164, 128, 0.05);
    const Color boderColor = Color.fromRGBO(250, 164, 128, 0.6);
    const Color orangeContainerColor = Color(0xffFFEDD5);
    const Color lightGreenContainerColor = Color(0xffD7FEE3);
    const Color greenTextColor = Color(0xff009E2D);

    return Container(
      width: 180.w,
      height: 270.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        color: bgColor,
        border: Border.all(color: boderColor, width: 0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 9.0.w, top: 10.h),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: orangeContainerColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/images/home/step.svg"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 18.0.w, top: 10.h),
                child: Container(
                  width: 54.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: lightGreenContainerColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: greenTextColor,
                        size: 15,
                      ),
                      Text(
                        "12%",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: greenTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: (savedId == null || savedId!.isEmpty)
                ? Text(
                    "0",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  )
                : ValueListenableBuilder(
                    valueListenable: Hive.box(
                      'health_vault',
                    ).listenable(keys: ['current_steps']),
                    builder: (context, box, _) {
                      final steps = box.get('current_steps', defaultValue: 0);
                      return Text(
                        NumberFormat('#,###').format(steps),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Steps Taken",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 135.h, child: BarGraphTile()),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 94,
              height: 14,
              decoration: BoxDecoration(
                color: Color(0xffFEEBDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                textAlign: TextAlign.center,
                getCurrentDate(DateTime.now()),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
