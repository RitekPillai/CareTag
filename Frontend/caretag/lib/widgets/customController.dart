import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextFiled(
  String text,
  String helperText,
  TextEditingController controller, {
  bool isPassword = false,
  String? HintText,
  TextInputType textInputType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      SizedBox(
        height: 45,
        width: 316,
        child: TextField(
          keyboardType: textInputType,

          controller: controller,
          obscureText: isPassword ? true : false,
          decoration: InputDecoration(
            hintText: helperText,
            hintStyle: GoogleFonts.poppins(
              color: AppColor.textHelperLightGrey,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      if (HintText != null)
        Text(
          textAlign: TextAlign.start,
          HintText,
          style: GoogleFonts.poppins(
            color: AppColor.textHintColor,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
    ],
  );
}
