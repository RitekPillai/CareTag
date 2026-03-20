import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
import 'package:caretag/Modules/Invoice/view/widget/invoice_detail_billing_tile.dart';
import 'package:caretag/Modules/Invoice/view/widget/invoice_detail_title_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<InvoiceBloc, InvoiceBlocState>(
        builder: (context, state) {
          if (state is InvoiceDetailLoaded) {
            final invoiceDetail = state.invoiceData;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 358.w,
                  height: 562.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),

                    color: Colors.white,
                    border: BoxBorder.all(
                      width: 1.w,
                      color: AppColor.whiteCreamColor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        spreadRadius: -2,
                        color: AppColor.getShadowColor(0.05),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      InvoiceDetailTitleTile(
                        hosptialName: invoiceDetail.hospitalName,
                        address: invoiceDetail.doctorName,
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: 358.w,
                        child: Divider(color: Colors.grey.shade100),
                      ),
                      SizedBox(height: 24.h),
                      InvoiceDetailBillingTile(
                        paitentName: invoiceDetail.patientName,
                        time: invoiceDetail.invoiceDate,
                        tax: invoiceDetail.taxRate,
                        fee: invoiceDetail.discount,
                        totalAmt: invoiceDetail.totalAmount.toDouble(),
                      ),
                      SizedBox(height: 24.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Transaction ID",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.sp,
                                  color: Color(0xff94A3B8),
                                ),
                              ),
                              Text(
                                invoiceDetail.transcationNumber,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff334155),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///padiing
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Need help with this invoice?",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Color(0xff94A3B8),
                      ),
                      children: [
                        TextSpan(
                          text: "Contact Support",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: AppColor.lightBlueTextColor2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 43.h),

                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 358.h,
                    height: 56.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      color: AppColor.darkishBlue,
                      boxShadow: [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.download_rounded, color: Colors.white),
                        SizedBox(width: 11.w),
                        Text(
                          "Download PDF Receipt",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is Failed) {
            return Center(child: Text("OOPS Something Wrong has happend "));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
