import 'package:caretag/Modules/Invoice/model/invoiceListConatinerTileModel.dart';
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
        const Color doctorInvoicesContainerColor = Color(0xffEEF2FF);
        const Color labInvoiceContainerColor = Color(0xffEEF2FF);
        const Color pharmacyIvoiceContainerColor = Color(0xffFFFBEB);
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
                  if (invoiceList[index].invoiceType == "DOCTOR") {
                    return InvoiceListContainerTile(
                      invoicelistconatinertilemodel:
                          Invoicelistconatinertilemodel(
                            invoiceListModel: invoiceList[index],
                            containerColor: doctorInvoicesContainerColor,
                            conatinerImagePath: "/Icon(11).svg",
                            backgroundImagePath: "/Text.svg",
                          ),
                    );
                  }
                  if (invoiceList[index].invoiceType == "DIAGONOSIS") {
                    return InvoiceListContainerTile(
                      invoicelistconatinertilemodel:
                          Invoicelistconatinertilemodel(
                            invoiceListModel: invoiceList[index],
                            containerColor: pharmacyIvoiceContainerColor,
                            conatinerImagePath: "/Icon(12).svg",
                            backgroundImagePath: "/Text(1).svg",
                          ),
                    );
                  }
                  if (invoiceList[index].invoiceType == "PHARMACY") {
                    return InvoiceListContainerTile(
                      invoicelistconatinertilemodel:
                          Invoicelistconatinertilemodel(
                            invoiceListModel: invoiceList[index],
                            containerColor: pharmacyIvoiceContainerColor,
                            conatinerImagePath: "/Icon(12).svg",
                            backgroundImagePath: "/Text(1).svg",
                          ),
                    );
                  }
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
