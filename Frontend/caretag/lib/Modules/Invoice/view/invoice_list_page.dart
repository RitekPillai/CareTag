import 'package:caretag/Modules/Invoice/model/invoice_list_model.dart';
import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
import 'package:caretag/Modules/Invoice/view/widget/invoice_list_container_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceBlocState>(
      builder: (context, state) {
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is InvoiceListLoaded) {
          final List<InvoiceListModel> invoiceList = state.invoiceList;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 18.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Invoices",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColor.darkishBlue,
                      ),
                    ),

                    Text(
                      "${invoiceList.length} Records",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InvoiceListContainerTile(
                    invoiceListModel: invoiceList[index],
                  );
                },
                itemCount: invoiceList.length,
              ),
            ],
          );
        } else if (state is Failed) {
          return Center(child: Text("Some Error has been Occured"));
        } else {
          return Container();
        }
      },
    );
  }
}
