import 'package:caretag/Modules/card_registration/model_view/service/bluetooth_service.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/currentdate.dart';
import 'package:caretag/utils/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

class Heartbeatcard extends StatefulWidget {
  const Heartbeatcard({super.key});

  @override
  State<Heartbeatcard> createState() => _HeartbeatcardState();
}

class _HeartbeatcardState extends State<Heartbeatcard>
    with SingleTickerProviderStateMixin {
  Storageservice storageservice = Storageservice();
  Bluetooothservice bluetoothService = Bluetooothservice();
  late AnimationController animatationController;
  late Animation<double> _opactiyAnimation;
  String? savedId;

  @override
  void initState() {
    super.initState();
    // _connectToBluetoothId();
    animatationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _opactiyAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: animatationController, curve: Curves.bounceInOut),
    );

    animatationController.repeat(reverse: true);
  }

  // Future<void> _connectToBluetoothId() async {
  //   debugPrint("Inside the Function");
  //   String? id = await storageservice.getBid();
  //   if (mounted) {
  //     setState(() {
  //       savedId = id;
  //       debugPrint("Watch ID:$savedId");
  //     });
  //   } else {
  //     debugPrint("No watch ID saved in storage.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Color.fromRGBO(229, 32, 48, 0.05);
    Color boderColor = Color.fromRGBO(229, 32, 48, 0.6);
    Color circleContatinerColor = Color.fromRGBO(229, 32, 48, 0.2);
    Color greyColor = Color.fromRGBO(0, 0, 0, 0.4);

    return Container(
      width: 180.w,
      height: 270.h,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: boderColor, width: 0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: circleContatinerColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/images/home/heartbeat.svg"),
                  ),
                ),
                AnimatedBuilder(
                  animation: _opactiyAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: _opactiyAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 19,
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: _buildHeartRateValue(),
              ),
              Text(
                "BPM",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: greyColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            child: Text(
              textAlign: TextAlign.start,
              "Heart Rate",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Center(
            child: LottieBuilder.asset(
              "assets/images/home/beat2.json",
              height: 100,
              width: 160,
            ),
          ),
          const SizedBox(height: 10),
          Center(
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

  Widget _buildHeartRateValue() {
    // Check if the box is open before trying to use it to avoid crashes
    if (!Hive.isBoxOpen('health_vault')) {
      return const Text("--");
    }

    return ValueListenableBuilder(
      valueListenable: Hive.box(
        'health_vault',
      ).listenable(keys: ['current_hr']),
      builder: (context, Box box, _) {
        // Use 'box' directly from the builder
        final heartRate = box.get('current_hr', defaultValue: 0);

        return Text(
          heartRate > 0 ? heartRate.toString() : "--",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 32.sp,
          ),
        );
      },
    );
  }
}
