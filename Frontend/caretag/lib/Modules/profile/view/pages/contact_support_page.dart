import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactSupportPage extends StatelessWidget {
  static const routeName = '/contact-support';
  const ContactSupportPage({super.key});

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
          'Contact Support',
          style: GoogleFonts.inter(
            color: const Color(0xFF111827),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 358.w,
              height: 260.h,
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
                  _SupportOption(
                    icon: Icons.chat_bubble_outline,
                    iconBg: const Color(0xFFFFE4E6),
                    iconColor: const Color(0xFFEC4899),
                    title: 'Start Live Chat',
                    subtitle: 'Wait time: ~2 min',
                    onTap: () {},
                  ),

                  _SupportOption(
                    icon: Icons.email_outlined,
                    iconBg: const Color(0xFFFFE4E6),
                    iconColor: const Color(0xFFEC4899),
                    title: 'Email Support',
                    onTap: () {},
                  ),

                  _SupportOption(
                    icon: Icons.phone_outlined,
                    iconBg: const Color(0xFFFFE4E6),
                    iconColor: const Color(0xFFEC4899),
                    title: 'Call Us',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _SupportOption(
              icon: Icons.help_outline,
              iconBg: const Color(0xFFE0E7FF),
              iconColor: const Color(0xFF4F46E5),
              title: 'Browse FAQs',
              subtitle: 'Find answers quickly',
              trailing: const Icon(
                Icons.open_in_new,
                size: 18,
                color: Color(0xFFB0B7C3),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 32),
            Text(
              'Our support team is available 24/7.\nPlease have your account details ready.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportOption extends StatelessWidget {
  const _SupportOption({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: title == "Call Us"
            ? Border()
            : Border(
                bottom: BorderSide(color: const Color(0xFFE5E7EB), width: 1),
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: iconColor),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    const Icon(Icons.chevron_right, color: Color(0xFFB0B7C3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
