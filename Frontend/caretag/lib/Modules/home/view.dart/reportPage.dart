import 'package:caretag/Modules/card_registration/data/model/bloc_req_model.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/dialogBox.dart';
import 'package:caretag/Modules/home/widgets/report/doc_report_conatiner_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Reportpage extends StatefulWidget {
  final Permissionrequestmodel permissionrequestmodel;
  const Reportpage({super.key, required this.permissionrequestmodel});

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  String? selecteReason;

  @override
  Widget build(BuildContext context) {
    const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.25);
    const Color textFiledBorderColor = Color(0xffE2E8F0);
    const Color hintTextColor = Color(0xff94A3B8);
    const Color warningContainerColor = Color(0xffFFFBEB);
    const Color warniongContainerBorderColor = Color(0xffFEF3C7);
    const Color iconColor = Color(0xffD97706);
    const Color warningTextColor = Color(0xff92400E);
    const Color submitContainerShawdowColor = Color.fromRGBO(239, 68, 68, 0.2);
    const Color submitContainerColor = Color.fromRGBO(239, 68, 68, 250);

    TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 390.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: shadowColor,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 87.w),
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  Text(
                    "Report Request",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      color: AppColor.darkishBlueTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: DocReportConatinerTile(
                      docName: widget.permissionrequestmodel.docName,
                      hospitalName: widget.permissionrequestmodel.placeName,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.only(left: 22.w, bottom: 12.h),
                    child: Text(
                      "Why are you reporting this?",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 14.sp,
                        color: AppColor.darkishBlueTextColor,
                      ),
                    ),
                  ),
                  CustomCheckBox("I don't know this doctor"),
                  CustomCheckBox(
                    "I don't have an appointment with this\nhospital",
                  ),
                  CustomCheckBox("Too many repeated requests"),
                  CustomCheckBox("Suspicious activity"),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.only(left: 22.w, bottom: 8.h),
                    child: Text(
                      "Additional Details",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.sp,
                        color: AppColor.darkishBlueTextColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 358.w,
                    height: 128.h,

                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        left: 18.w,
                        right: 19.h,
                      ),
                      child: TextField(
                        controller: controller,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Tell us more (Optional)...",
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: hintTextColor,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.r),
                            borderSide: BorderSide(color: textFiledBorderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.r),
                            borderSide: BorderSide(color: textFiledBorderColor),
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.r),
                            borderSide: BorderSide(color: textFiledBorderColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Container(
                      width: 358.w,
                      height: 73,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),

                        color: warningContainerColor,
                        border: Border.all(
                          color: warniongContainerBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16.w),

                          SvgPicture.asset(
                            "assets/images/records/shild.svg",
                            width: 13.33.w,
                            height: 16.67.h,
                            color: iconColor,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "Reporting will block this doctor from sending\nfurther requests until verified by support.",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: warningTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 37.w),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                if (selecteReason == null || selecteReason == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please Select The options")),
                  );
                  return;
                }
                context.read<PatientBloc>().add(
                  ReportRequest(
                    blockReqModel: BlockReqModel(
                      docID: widget.permissionrequestmodel.docId,
                      reason: selecteReason!,
                      discription: controller.text,
                    ),
                  ),
                );

                showDialogBox(widget.permissionrequestmodel, true);
              },
              child: Container(
                width: 358.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                  color: submitContainerColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6,
                      spreadRadius: -4,
                      offset: Offset(0, 4),
                      color: submitContainerShawdowColor,
                    ),
                    BoxShadow(
                      blurRadius: 15,
                      spreadRadius: -3,
                      offset: Offset(0, 10),
                      color: submitContainerShawdowColor,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/home/dialog/warning.svg"),
                    Text(
                      "  Submit Report",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomCheckBox(String text) {
    const Color borderColor = Color(0xffE2E8F0);
    const Color containerShadowColor = Color.fromRGBO(0, 0, 0, 0.05);
    const Color checkBoxFillColor = Color(0xffF1F5F9);
    const Color checkBoxBoderColor = Color(0xffCBD5E1);
    const Color radioButtonTextColor = Color(0xff334155);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 18.w, top: 12.h),
      child: GestureDetector(
        onTap: () => setState(() {
          if (text == "hospital") {
            selecteReason = "I don't have an appointment with this hospital";
            return;
          }
          selecteReason = text;
        }),
        child: Container(
          width: 358.w,
          height: 54.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0,
                color: containerShadowColor,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioGroup<String>(
                groupValue: selecteReason,
                onChanged: (String? newValue) {
                  setState(() {
                    selecteReason = newValue;
                  });

                  debugPrint("Reason:$selecteReason");
                },
                child: Transform.scale(
                  scale: 1.5,
                  child: Radio(
                    value: text,

                    activeColor: AppColor.lightBlueTextColor2,
                    backgroundColor: WidgetStatePropertyAll(checkBoxFillColor),

                    side: BorderSide(color: checkBoxBoderColor, width: 1),
                  ),
                ),
              ),
              Text(
                text,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: radioButtonTextColor,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
