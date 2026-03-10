import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
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
          final InvoiceListLoaded invoiceList = state;

          // Now, typing 'loadedState.' should give you 'invoiceList' immediately
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Recent Invoices",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                        color: AppColor.darkishBlue,
                      ),
                    ),
                  ),

                  Text("${state.invoiceList.length} Records"),
                ],
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
