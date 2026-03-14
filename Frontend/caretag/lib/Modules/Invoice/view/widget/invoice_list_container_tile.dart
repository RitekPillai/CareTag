import 'package:caretag/Modules/Invoice/model/invoiceListConatinerTileModel.dart';
import 'package:caretag/Modules/Invoice/model/invoice_list_model.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceListContainerTile extends StatelessWidget {
  final Invoicelistconatinertilemodel invoicelistconatinertilemodel;
  const InvoiceListContainerTile({
    super.key,
    required this.invoicelistconatinertilemodel,
  });

  @override
  Widget build(BuildContext context) {
    const Color boderColor = Color(0xffF1F5F9);
    const Color greyTextColor = Color(0xff64748B);
    const String imagePath = "assets/images/Invoice";
    InvoiceListModel invoiceListModel =
        invoicelistconatinertilemodel.invoiceListModel;
    const Color lightGreyTextColor = Color(0xff94A3B8);
    const Color lightGreenContatinerColor = Color(0xffDCFCE7);
    const Color lightOrangeContatinerColor = Color(0xffFEF3C7);
    const Color greenTextColor = Color(0xff15803D);
    const Color orangeTextColor = Color(0xffB45309);

    const Color lightBlueContainerColor = Color(0xffDBEAFE);
    const Color blueTextColor = Color(0xff2563EB);
    const Color darkGreyTextColor = Color(0xff475569);
    const Color creamColor = Color(0xffF8FAFC);
    String getInitials(String name) {
      List<String> names = name.split(" ");
      String initials = "";
      int numWords = names.length > 2 ? 2 : names.length;

      for (var i = 0; i < numWords; i++) {
        if (names[i].isNotEmpty) {
          initials += names[i][0].toUpperCase();
        }
      }
      return initials;
    }

    return Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 16.h),
      child: Container(
        width: 358.w,
        height: 207.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(color: boderColor, width: 1.w),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
              color: AppColor.shadowColor,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 48.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: invoiceListModel.status! == 'PAID'
                                  ? AppColor.lightBlueSmallContainerColor
                                  : lightOrangeContatinerColor,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                imagePath +
                                    invoicelistconatinertilemodel
                                        .conatinerImagePath,
                                color: invoiceListModel.status! == 'PAID'
                                    ? Color(0xff137FEC)
                                    : Color(0xffD97706),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 120.84.w,
                                    child: Text(
                                      maxLines: 2,

                                      invoiceListModel.discription,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                        color: AppColor.darkishBlue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 80.w),
                                  Container(
                                    width: invoiceListModel.status! == 'PAID'
                                        ? 40.w
                                        : 50.w,
                                    height: 23.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(9999.r),
                                      color: invoiceListModel.status! == 'PAID'
                                          ? lightGreenContatinerColor
                                          : lightOrangeContatinerColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        invoiceListModel.status!,
                                        style:
                                            invoiceListModel.status! == 'PAID'
                                            ? GoogleFonts.inter(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w700,
                                                color: greenTextColor,
                                              )
                                            : GoogleFonts.inter(
                                                fontWeight: FontWeight.w700,
                                                color: orangeTextColor,
                                                fontSize: 10.sp,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    invoiceListModel.docName,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: greyTextColor,
                                    ),
                                  ),
                                  SizedBox(width: 50.w),
                                  Text(
                                    "date",
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text.rich(
                                TextSpan(
                                  text: invoiceListModel.totalAmount.toString(),
                                  style: GoogleFonts.inter(
                                    color: lightGreyTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.sp,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' • ',
                                      children: [
                                        TextSpan(
                                          text:
                                              "Transcation ID: ${invoiceListModel.transcationId}",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 250.w,
                  child: Opacity(
                    opacity: 0.17,
                    child: SvgPicture.asset(
                      imagePath +
                          invoicelistconatinertilemodel.backgroundImagePath,
                      color: invoiceListModel.status == 'PAID'
                          ? Color(0xff137FEC)
                          : Color(0xffF59E08),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: lightGreyTextColor),
                ),
              ),
            ),

            SizedBox(height: 15.h),
            Row(
              children: [
                SizedBox(width: 15.w),
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: lightBlueContainerColor,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Center(
                    child: Text(
                      getInitials(invoiceListModel.docName),
                      style: GoogleFonts.inter(
                        color: blueTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 100.w,
                  child: Text(
                    maxLines: 3,

                    invoiceListModel.hospitalName,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: darkGreyTextColor,
                    ),
                  ),
                ),

                SizedBox(width: 30.w),
                Container(
                  width: 150.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    color: creamColor,
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 5),

                        Icon(Icons.download_outlined),
                        SizedBox(width: 5),
                        Text(
                          "Download PDF",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: Color(0xff334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
