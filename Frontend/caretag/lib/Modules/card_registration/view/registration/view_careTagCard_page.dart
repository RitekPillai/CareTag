import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:caretag/widgets/custombutton.dart';
import 'package:caretag/widgets/helpPage.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gal/gal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class ViewCaretagcardPage extends StatefulWidget {
  const ViewCaretagcardPage({super.key});

  @override
  State<ViewCaretagcardPage> createState() => _ViewCaretagcardPageState();
}

bool isFront = true;

class _ViewCaretagcardPageState extends State<ViewCaretagcardPage> {
  final String careTagId = "CTG-8359-2047-1638";
  final GlobalKey _globalKey = GlobalKey();

  Future<void> _captureAndSave(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
      }

      await Gal.putImageBytes(pngBytes, name: "CareTag_ID");

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            content: Text(
              "“Saved to Gallery successfully!”",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xff4DC42A),
              ),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> _shareAsPdf() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final pdf = pw.Document();
      final imageWidget = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "CareTag Medical ID",
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Image(imageWidget, width: 400),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    "Generated on ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                  ),
                ],
              ),
            );
          },
        ),
      );

      final output = await getTemporaryDirectory();
      final filePath = "${output.path}/CareTag_ID.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      final params = ShareParams(
        files: [XFile(filePath)],
        text: 'Here is my secure CareTag Medical ID.',
      );
      await SharePlus.instance.share(params);
    } catch (e) {
      debugPrint("PDF Share Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(52),
        bottomRight: Radius.circular(52),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back_rounded, weight: 23),
        actions: [help()],
      ),
      body: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            "This digital ID links to your secure medical profile.",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 60,
            width: 200,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(51),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("button pressed");
                    setState(() {
                      isFront = true;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn,
                    width: !isFront ? 50 : 87,
                    height: 50,
                    decoration: isFront
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 19,
                                color: Color.fromRGBO(28, 94, 166, 0.49),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xff254799), Color(0xff1F2937)],
                            ),
                          )
                        : defaultDecoration,
                    child: Center(
                      child: Text(
                        "Front",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isFront ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFront = false;
                    });
                  },
                  child: AnimatedContainer(
                    curve: Curves.bounceIn,
                    duration: Duration(milliseconds: 200),
                    width: isFront ? 50 : 87,
                    height: 50,
                    decoration: !isFront
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(52),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 19,
                                color: Color.fromRGBO(28, 94, 166, 0.49),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xff254799), Color(0xff1F2937)],
                            ),
                          )
                        : defaultDecoration,

                    child: Center(
                      child: Text(
                        "Back",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: !isFront ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          RepaintBoundary(
            key: _globalKey,
            child: Container(
              height: 175,
              width: 333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),

                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/card/card.png"),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: SvgPicture.asset(
                          "assets/images/card/LOGO.svg",
                          height: 40,
                          width: 40,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text.rich(
                          TextSpan(
                            text: "CareTag\n",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            children: [
                              TextSpan(
                                text: "Your Health, Simplified",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: AlignmentGeometry.centerRight,
                      child: SvgPicture.asset(
                        "assets/images/card/tap.svg",
                        height: 15,
                        width: 15,
                      ),
                    ),
                  ),

                  Text(
                    careTagId,
                    style: GoogleFonts.poppins(
                      color: Color(0xffF85300),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "RITEK ABHISHEK PILLAI ",
                          style: TextStyle(
                            fontFamily: 'Vogun',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Valid\nThru",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10),

                            Text(
                              "07/35",
                              style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          Container(
            height: 431 - 96,
            width: 393,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 9,
                  color: Color.fromRGBO(31, 41, 55, 0.1),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Your CareTag ID is encrypted and only accessible by you.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                RowTile(
                  "Copy your 12-digit CareTag ID",
                  "copy.svg",
                  "Copy",
                  () async {
                    try {
                      await FlutterClipboard.copy(careTagId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadiusGeometry.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          content: Text(
                            textAlign: TextAlign.center,
                            "“Your CareTag ID has been successfully copied”",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xff4DC42A),
                            ),
                          ),
                        ),
                      );
                    } on ClipboardException catch (e) {
                      print('Copy failed: ${e.message}');
                    }
                  },
                ),
                const SizedBox(height: 25),
                RowTile(
                  "Save your CareTag card as an\nimage",
                  "download.svg",
                  "Save",
                  () async {
                    await _captureAndSave(context);
                  },
                ),
                const SizedBox(height: 25),
                RowTile(
                  "Share your CareTag card          \nsecurely as pdf",
                  "share.svg",
                  "Share",
                  () async {
                    await _shareAsPdf();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget RowTile(
  String title,
  String icon,
  String button,
  VoidCallback onPressed,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset("assets/images/card/$icon", height: 25, width: 25),
      const SizedBox(width: 10),
      Text(
        title,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black,
        ),
      ),
      const SizedBox(width: 10),

      customElevatedButton(36, 110, button, 20, FontWeight.w600, onPressed),
    ],
  );
}
