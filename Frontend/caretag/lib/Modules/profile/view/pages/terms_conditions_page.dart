import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TermsConditionsPage extends StatelessWidget {
  static const routeName = '/terms-conditions';
  const TermsConditionsPage({super.key});

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
          'Terms & Conditions',
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
            Container(
              width: 358.w,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
                borderRadius: BorderRadius.circular(48.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.history, color: Color(0xFF137FEC), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Last Updated',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1E3A8A),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Feb 24, 2026',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF137FEC),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 48.h),
            _TermSection(
              number: '1',
              title: 'Acceptance of Terms',
              content:
                  'By downloading, installing, or using the CareTag mobile application ("App"), you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the App. These terms apply to all visitors, users, and others who access or use the Service.',
            ),
            const SizedBox(height: 20),
            _TermSection(
              number: '2',
              title: 'User Responsibilities',
              content:
                  'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account or password.',
              subItems: [
                'You must be at least 18 years old to use this App.',
                'You must provide accurate and complete information.',
                'You may not use the App for any illegal or unauthorized purpose.',
              ],
            ),
            const SizedBox(height: 20),
            _TermSection(
              number: '3',
              title: 'Privacy & Data Usage',
              content:
                  'Your privacy is important to us. CareTag collects and uses personal data in accordance with our Privacy Policy. By using the App, you consent to such processing and you warrant that all data provided by you is accurate. We implement robust security measures to protect your health data.',
            ),
            const SizedBox(height: 20),
            _TermSection(
              number: '4',
              title: 'Medical Disclaimer',
              content:
                  'The CareTag App provides information for educational and tracking purposes only. It is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.',
            ),
            const SizedBox(height: 20),
            _TermSection(
              number: '5',
              title: 'Modifications to Service',
              content:
                  'CareTag reserves the right to modify or discontinue, temporarily or permanently, the Service (or any part thereof) with or without notice. You agree that CareTag shall not be liable to you or to any third party for any modification, suspension, or discontinuance of the Service.',
            ),
            const SizedBox(height: 20),
            _TermSection(
              number: '6',
              title: 'Termination',
              content:
                  'We may terminate or suspend access to our Service immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
            ),
            const SizedBox(height: 40),
            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.support_agent, size: 18),
                label: const Text('Contact Legal Support'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _TermSection extends StatelessWidget {
  final String number;
  final String title;
  final String content;
  final List<String>? subItems;

  const _TermSection({
    required this.number,
    required this.title,
    required this.content,
    this.subItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: const Color(0xFFDBEAFE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF137FEC),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF4B5563),
              height: 1.6,
            ),
          ),
          if (subItems != null) ...[
            const SizedBox(height: 12),
            ...subItems!.map(
              (item) => Padding(
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
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4B5563),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
