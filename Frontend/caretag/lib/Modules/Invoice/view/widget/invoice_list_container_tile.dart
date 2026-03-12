import 'package:caretag/Modules/Invoice/model/invoice_list_model.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceListContainerTile extends StatelessWidget {
  final InvoiceListModel invoiceListModel;
  const InvoiceListContainerTile({super.key, required this.invoiceListModel});

  @override
  Widget build(BuildContext context) {
    const Color boderColor = Color(0xffF1F5F9);
    const Color greyTextColor = Color(0xff64748B);

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
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.lightBlueSmallContainerColor,
                  ),
                  child: Center(child: Icon(Icons.local_hospital)),
                ),
                Column(
                  children: [
                    Text(
                      invoiceListModel.discription,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColor.darkishBlue,
                      ),
                    ),
                    Text(
                      invoiceListModel.docName,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: greyTextColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(invoiceListModel.totalAmount.toInt().toString()),
                        Text(
                          maxLines: 2,
                          "Transcation id :${invoiceListModel.transcationId}",
                        ),
                      ],
                    ),
                  ],
                ),
                Text("date:${invoiceListModel.invoiceDate}"),
              ],
            ),
            Text(invoiceListModel.docName),
          ],
        ),
      ),
    );
  }
}
