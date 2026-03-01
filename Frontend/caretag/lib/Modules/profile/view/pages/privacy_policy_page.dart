import 'dart:ui';

import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const routeName = '/privacy-policy';
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String imagePath = "assets/images/setting";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h),
            Center(
              child: Text(
                'Last updated: October 24, 2023',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Container(
              width: 358.w,
              height: 185.h,
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Color(0xffDCFCE7), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 37.w,
                        height: 37.h,
                        child: SvgPicture.asset("$imagePath/light.svg"),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Quick Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'We collect minimal data to provide our services. Your health data is encrypted end-to-end. We never sell your personal information to third parties.',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF065F46),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: 358.w,
              height: 221.75.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: AppColor.getShadowColor(0.05),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _SectionHeader(
                    icon: "$imagePath/search.svg",
                    iconColor: const Color(0xFF10B981),
                    title: 'Introduction',
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    child: Text(
                      'At CareTag, we take your privacy seriously. This policy describes how we collect, use, and handle your personal information when you use our websites, software, and services ("Services").',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Color(0xFF4B5563),
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            Container(
              width: 358.w,
              height: 385.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: AppColor.getShadowColor(0.05),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  _SectionHeader(
                    icon: "$imagePath/data.svg",
                    iconColor: const Color(0xFF10B981),
                    title: 'Data We Collect',
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        _DataItem(
                          title: 'Account Information',
                          description:
                              'Name, email, phone number, and profile photo used to create your account.',
                        ),
                        const SizedBox(height: 12),
                        _DataItem(
                          title: 'Health Data',
                          description:
                              'Blood type, allergies, and emergency contacts you choose to input.',
                        ),
                        const SizedBox(height: 12),
                        _DataItem(
                          title: 'Usage Data',
                          description:
                              'Information about how you interact with our app to improve user experience.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            Container(
              width: 358.w,
              height: 275.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: AppColor.getShadowColor(0.05),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _SectionHeader(
                    icon: "$imagePath/lock.svg",
                    iconColor: const Color(0xFF10B981),
                    title: 'Encryption & Security',
                  ),
                  SizedBox(height: 15.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      'Your data is encrypted both in transit and at rest using industry-standard AES-256 encryption. We employ strict access controls and regular security audits to ensure your information remains safe.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4B5563),
                        height: 1.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.75.h),
                  SizedBox(
                    width: 330.w,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(48.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.verified_user_outlined,
                            color: Color(0xFF16A34A),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'SOC2 Compliant Security',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            Container(
              width: 358.w,
              height: 330.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: AppColor.getShadowColor(0.05),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  _SectionHeader(
                    icon: "$imagePath/share.svg",
                    iconColor: const Color(0xFF10B981),
                    title: 'Third-Party Sharing',
                  ),
                  SizedBox(height: 14.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Text(
                      'We do not sell your personal data. We only share information with third parties when necessary to provide our services, such as:',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4B5563),
                        height: 1.6,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.5.w),
                  _BulletPoint(
                    text: 'Payment processors for subscription handling.',
                  ),
                  _BulletPoint(
                    text:
                        'Cloud hosting providers (e.g., AWS) to store data securely.',
                  ),
                  _BulletPoint(
                    text: 'Customer support tools to help resolve your issues.',
                  ),
                ],
              ),
            ),

            SizedBox(height: 45.5.h),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6B7280),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Download PDF Version',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 45.5.h),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String icon;
  final Color iconColor;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.iconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xff111418),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final String title;
  final String description;

  const _DataItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF10B981),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff111418),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  final String text;

  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF4B5563),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
