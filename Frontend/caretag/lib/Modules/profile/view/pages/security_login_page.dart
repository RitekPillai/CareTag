import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SecurityLoginPage extends StatefulWidget {
  static const routeName = '/security-login';
  const SecurityLoginPage({super.key});

  @override
  State<SecurityLoginPage> createState() => _SecurityLoginPageState();
}

class _SecurityLoginPageState extends State<SecurityLoginPage> {
  bool _twoFactor = false;
  bool _biometricUnlock = true;

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
          'Security & Login',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 24.h),
          _SecurityRow(
            icon: Icons.lock_reset,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9B51E0),
            title: 'Change Password',
            trailing: const Icon(Icons.chevron_right, color: Color(0xFFB0B7C3)),
            onTap: () {},
          ),
          _SecurityRow(
            icon: Icons.phonelink_lock,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9B51E0),
            title: 'Two-Factor\nAuthentication',
            trailing: Switch(
              activeThumbColor: const Color(0xFF9333EA),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFD1D5DB),

              value: _twoFactor,
              onChanged: (value) => setState(() => _twoFactor = value),
            ),
            onTap: null,
          ),
          _SecurityRow(
            icon: Icons.fingerprint,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9B51E0),
            title: 'Biometric Unlock',
            trailing: Switch(
              activeThumbColor: const Color(0xFF9333EA),

              value: _biometricUnlock,
              onChanged: (value) => setState(() => _biometricUnlock = value),
            ),
            onTap: null,
          ),
          _SecurityRow(
            icon: Icons.devices,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9B51E0),
            title: 'Active Sessions',
            trailing: const Icon(Icons.chevron_right, color: Color(0xFFB0B7C3)),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Review your security settings regularly to keep your account safe.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityRow extends StatelessWidget {
  const _SecurityRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: iconColor),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111418),
                    height: 1.3,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
