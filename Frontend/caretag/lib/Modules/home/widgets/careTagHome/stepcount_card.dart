import 'package:caretag/Modules/card_registration/model_view/service/bluetoothService.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/barchart.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/currentdate.dart';
import 'package:caretag/utils/storageService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
    String? id = await storageservice.getBid();
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

    return Container(
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),

        color: bgColor,
        border: Border.all(color: boderColor, width: 0.4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                : FutureBuilder<int>(
                    future: bluetoothService.getSteps(savedId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "...",
                          style: GoogleFonts.poppins(fontSize: 32),
                        );
                      }
                      // Fallback to "0" if data is null
                      String displaySteps = NumberFormat(
                        '#,###',
                      ).format(snapshot.data ?? 0);
                      return Text(
                        displaySteps,
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
          SizedBox(height: 120, child: BarGraphTile()),

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
}
