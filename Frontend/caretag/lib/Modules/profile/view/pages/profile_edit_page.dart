import 'dart:io';

import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/profile/model/profile_edit_model.dart';
import 'package:caretag/Modules/profile/view/widgets/personal_detail_container_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:caretag/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String selectedGenderValue = "Male";
  String selectedBloodGroup = "O+";
  final List<String> bloodGroupOptions = [
    "O+",
    "O-",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
  ];
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final List<String> genderOptions = ["Male", "Female", "Other"];
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80, // Reduces size for faster Spring Boot upload
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController allergies = TextEditingController();

  // Don't forget to dispose them to save memory
  @override
  void dispose() {
    name.dispose();
    dob.dispose();
    height.dispose();
    weight.dispose();
    allergies.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color blueTextColor = Color(0xff137FEC);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        shadowColor: AppColor.getShadowColor(0.05),
        centerTitle: true,

        title: Text(
          "Edit Profile",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 128.w,
                height: 128.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.lightBlueSmallContainerColor,
                  image: _profileImage != null
                      ? DecorationImage(
                          image: FileImage(_profileImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.getShadowColor(0.1),
                      blurRadius: 4,
                      spreadRadius: -2,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -1,
                      color: AppColor.getShadowColor(0.1),
                    ),
                  ],
                ),
                child: _profileImage == null
                    ? Icon(Icons.person, size: 64.sp, color: Color(0xff137FEC))
                    : null,
              ),
            ),
            SizedBox(height: 12.h),

            Center(
              child: TextButton(
                onPressed: () {
                  _pickImage();
                },
                child: Text(
                  textAlign: TextAlign.center,
                  "Change Profile Photo",
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: blueTextColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w, bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.lightBlueSmallContainerColor,
                    ),
                    child: Center(
                      child: Icon(Icons.person_4_outlined, color: Colors.blue),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Personal Details",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: AppColor.darkishBlueTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 335.w,
              height: 230.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColor.getShadowColor(0.05),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomProfileEditTile(
                    TextInputType.text,
                    header: 'Full Name',
                    hintText: 'Ritek Pillai',
                    controller: name,
                  ),
                  SizedBox(height: 16.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 151.w,
                        child: CustomProfileEditTile(
                          TextInputType.text,
                          header: 'Date of Birth',
                          hintText: '01/01/1990',
                          controller: dob,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      customDropDownButton(
                        selectedGenderValue,
                        genderOptions,
                        48.h,
                        151.w,
                        "Gender",
                        (value) {
                          setState(() {
                            selectedGenderValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.only(left: 20.0.w, bottom: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.lightBlueSmallContainerColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.local_hospital_outlined,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    "Medical Details",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: AppColor.darkishBlueTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 335.w,
              height: 320.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColor.getShadowColor(0.05),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  customDropDownButton(
                    selectedBloodGroup,
                    bloodGroupOptions,
                    48.h,
                    300.w,
                    "Blood Group",
                    (value) {
                      setState(() {
                        selectedBloodGroup = value!;
                      });
                    },
                  ),
                  SizedBox(height: 15.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 151.w,
                        child: CustomProfileEditTile(
                          TextInputType.number,
                          header: "Height (cm)",
                          hintText: "182",
                          controller: height,
                        ),
                      ),
                      SizedBox(
                        width: 151.w,
                        child: CustomProfileEditTile(
                          TextInputType.number,
                          header: "Weight (kg)",
                          hintText: "75",
                          controller: weight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.5.h),
                  SizedBox(
                    width: 318.w,

                    child: CustomProfileEditTile(
                      TextInputType.text,
                      header: "Allergies",
                      hintText: "Peanuts, Penicillin",
                      controller: allergies,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),
            customElevatedButton(
              56.h,
              318.w,
              "Save Changes",
              18.sp,
              FontWeight.w700,
              () {
                context.read<PatientBloc>().add(
                  ProfileEditEvent(
                    profileEditModel: ProfileEditModel(
                      fullName: name.text,
                      dob: dob.text,
                      gender: selectedGenderValue,
                      bloodGroup: selectedBloodGroup,
                      height: height.text,
                      weight: weight.text,
                      allergies: allergies.text,
                      imagePath: _profileImage == null
                          ? ""
                          : _profileImage!.path,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget customDropDownButton(
    String selectedValue,
    List<String> options,
    double height,
    double width,
    String text,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 15.sp,
            color: const Color(0xFF6B7280),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48.r),
            color: const Color(0xffF9FAFB),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              dropdownColor: Colors.white,
              icon: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xff111827),
                ),
              ),
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff111827),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
