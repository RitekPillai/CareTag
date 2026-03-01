import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingSubsctionPage extends StatelessWidget {
  const SettingSubsctionPage({super.key});
  @override
  Widget build(BuildContext context) {
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
          'Subscriptions',
          style: GoogleFonts.inter(
            color: Color(0xff111827),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 220.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff1C1C1E), Color(0xff2C2C2E)],
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned(
                    top: -30.h,
                    right: -30.w,
                    child: Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffEAB308).withAlpha(100),
                            blurRadius: 24,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.workspace_premium,
                              color: Color(0xFFEAB308),
                              size: 30,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'CURRENT PLAN',
                              style: GoogleFonts.inter(
                                color: Color(0xFFEAB308),
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.75.h),
                        Text(
                          'CareTag Plus - Yearly',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Renews on Oct 24, 2025',
                          style: GoogleFonts.inter(
                            color: Color(0xff9CA3AF),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '₹500',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' /year',
                                style: GoogleFonts.inter(
                                  color: Color(0xff9CA3AF),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24.h),
          Text(
            'Active Benefits',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111418),
            ),
          ),
          SizedBox(height: 16.h),
          const _BenefitRow(
            icon: Icons.cloud_upload_outlined,
            iconBg: Color(0xFFFFF9E6),
            iconColor: Color(0xFFFBBF24),
            title: 'Cloud Backup',
            subtitle: 'Unlimited secure storage for your data',
          ),
          const _BenefitRow(
            icon: Icons.support_agent,
            iconBg: Color(0xFFFFF9E6),
            iconColor: Color(0xFFFBBF24),
            title: 'Priority Support',
            subtitle: '24/7 dedicated assistance line',
          ),
          const _BenefitRow(
            icon: Icons.analytics_outlined,
            iconBg: Color(0xFFFFF9E6),
            iconColor: Color(0xFFFBBF24),
            title: 'Advanced Analytics',
            subtitle: 'Deep insights into your health trends',
          ),
          const _BenefitRow(
            icon: Icons.group_outlined,
            iconBg: Color(0xFFFFF9E6),
            iconColor: Color(0xFFFBBF24),
            title: 'Family Sharing',
            subtitle: 'Share benefits with up to 5 members',
          ),
          const _BenefitRow(
            icon: Icons.block,
            iconBg: Color(0xFFFFF9E6),
            iconColor: Color(0xFFFBBF24),
            title: 'Ad-Free Experience',
            subtitle: 'Enjoy the app without interruptions',
          ),
          const SizedBox(height: 28),
          Text(
            'Available Add-ons',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111418),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEAFE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety_outlined,
                    size: 22,
                    color: Color(0xFF1E63F4),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Telehealth Pack',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111418),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '₹100/mo',
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 59.45.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Add',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E63F4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {},
            child: Text(
              'Cancel Subscription',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFFE02020),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'By continuing, you agree to the Terms of Service and Privacy Policy. Subscriptions auto-renew unless canceled at least 24 hours before the end of the current period.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border(
            bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,

                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111418),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF22C55E),
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
