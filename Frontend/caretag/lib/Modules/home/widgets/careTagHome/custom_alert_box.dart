import 'package:caretag/Modules/home/model/RecordAccessAcceptModel.dart';
import 'package:caretag/Modules/home/model/permssionAcceptModel.dart';
import 'package:caretag/Modules/home/view.dart/reportPage.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/acceptPage.dart';
import 'package:caretag/Modules/home/widgets/careTagHome/denyPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/home/model/permissionRequestModel.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';

class CustomAlertBox extends StatelessWidget {
  final Permissionrequestmodel permissionRequestModel;

  const CustomAlertBox({super.key, required this.permissionRequestModel});

  @override
  Widget build(BuildContext context) {
    const Color redColor = Color(0xffEF4444);
    return SizedBox(
      height: 403.h,
      width: 360.w,
      child: AlertDialog(
        backgroundColor: Colors.white,

        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColor.lightBlueSmallContainerColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/home/dialog/shiled.svg",
                    width: 20.w,
                    height: 25.h,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "Records Access Request",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: AppColor.darkishBlueTextColor,
                ),
              ),
              SizedBox(height: 7.32.h),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: permissionRequestModel.docName,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColor.darkishBlueTextColor,
                  ),
                  children: [
                    TextSpan(
                      text: " from ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "${permissionRequestModel.placeName}\n",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColor.darkishBlueTextColor,
                          ),
                          children: [
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              text: "is requesting temporary access to your ",
                            ),
                            TextSpan(
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              text:
                                  "medical records for your upcoming consultation",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              customElevatedButton(
                52.h,
                310.w,
                "Approve Access",
                16,
                FontWeight.w700,
                () {
                  Navigator.pop(context);
                  if (permissionRequestModel.isRecord == "true") {
                    context.read<PatientBloc>().add(
                      RecordAccessAccept(
                        permissionAcceptModel: PermissionAcceptModel(
                          docId: permissionRequestModel.docId,
                          encounterId: permissionRequestModel.encounterId,
                          publicKey: permissionRequestModel.publicKey,
                        ),
                      ),
                    );
                  } else {
                    context.read<PatientBloc>().add(
                      RequestAccept(
                        permissionRequestModel: permissionRequestModel,
                      ),
                    );
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Acceptpage(
                        docName: permissionRequestModel.docName,
                        hospitalName: permissionRequestModel.placeName,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      if (permissionRequestModel.isRecord == "true") {
                        context.read<PatientBloc>().add(
                          RecordAcessDeny(
                            docId: permissionRequestModel.docId,
                            encounterId: permissionRequestModel.encounterId,
                          ),
                        );
                      } else {
                        context.read<PatientBloc>().add(
                          DenyPermission(docId: permissionRequestModel.docId),
                        );
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Denypage(
                            docName: permissionRequestModel.docName,
                            hospitalName: permissionRequestModel.placeName,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Deny",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColor.greyTextColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.flag_outlined, color: redColor),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reportpage(
                                permissionrequestmodel: permissionRequestModel,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Report",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: redColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
