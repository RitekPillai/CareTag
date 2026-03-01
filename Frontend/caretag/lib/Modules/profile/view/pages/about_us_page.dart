import 'package:caretag/Modules/profile/view/widgets/menu_item_tile.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class AboutUsPage extends StatelessWidget {
  static const routeName = '/about-caretag';
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'About CareTag',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SvgPicture.asset("assets/images/profilePage/LOGO.svg"),
              SizedBox(height: 24.h),
              Text(
                'CareTag',
                style: GoogleFonts.inter(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your Health Companion',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: 7.h),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Version 2.4.0',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.update, color: Color(0xFF4F46E5), size: 25),
                    SizedBox(width: 8),
                    Text(
                      'Check for Updates',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: 342.w,
                height: 218.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
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
                    MenuItem(
                      icon: Icons.description_outlined,
                      iconBg: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xff2563EB),
                      title: "Terms of Service",
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.shield_outlined,
                      iconBg: const Color(0xFFF0FDF4),
                      iconColor: const Color(0xFF16A34A),
                      title: "Privacy Policy",
                      onTap: () {},
                    ),
                    MenuItem(
                      icon: Icons.shield_outlined,
                      iconBg: const Color(0xFFFEFCE8),
                      iconColor: const Color(0xFFCA8A04),
                      title: "Rate Us",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10.h),
              Text(
                'FOLLOW US',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SocialIcon(Icons.camera_alt_outlined),
                  const SizedBox(width: 24),
                  _SocialIcon(Icons.facebook_outlined),
                  const SizedBox(width: 24),
                  _SocialIcon(Icons.business_center_outlined),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                '© 2026 CareTag Inc. All rights reserved.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,

                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 1),
            color: AppColor.shadowColor,
          ),
        ],
      ),
      child: Icon(icon, size: 24, color: const Color(0xFF4B5563)),
    );
  }
}
