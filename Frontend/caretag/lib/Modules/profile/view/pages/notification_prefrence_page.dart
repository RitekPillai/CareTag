import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPrefrencePage extends StatefulWidget {
  static const routeName = '/notification-preferences';
  const NotificationPrefrencePage({super.key});

  @override
  State<NotificationPrefrencePage> createState() =>
      _NotificationPrefrencePageState();
}

class _NotificationPrefrencePageState extends State<NotificationPrefrencePage> {
  bool _medicationReminders = true;
  bool _labReports = true;
  bool _confirmation = true;
  bool _reminders = true;
  bool _promotions = false;
  bool _tips = true;

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
          'Notifications Preferences',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _CategoryHeader(
            icon: Icons.medication,
            iconBg: Color(0xFFFFF2CC),
            title: 'MEDICAL',
          ),
          const SizedBox(height: 12),
          _ToggleRow(
            title: 'Medication Reminders',
            value: _medicationReminders,
            onChanged: (value) => setState(() => _medicationReminders = value),
          ),
          _ToggleRow(
            title: 'Lab Reports',
            value: _labReports,
            onChanged: (value) => setState(() => _labReports = value),
          ),
          const SizedBox(height: 24),
          const _CategoryHeader(
            icon: Icons.calendar_month_sharp,
            iconBg: Color(0xFFFFF2CC),
            title: 'APPOINTMENTS',
          ),
          const SizedBox(height: 12),
          _ToggleRow(
            title: 'Confirmation',
            value: _confirmation,
            onChanged: (value) => setState(() => _confirmation = value),
          ),
          _ToggleRow(
            title: 'Reminders',
            value: _reminders,
            onChanged: (value) => setState(() => _reminders = value),
          ),
          const SizedBox(height: 24),
          const _CategoryHeader(
            icon: Icons.campaign,
            iconBg: Color(0xFFFFF2CC),
            title: 'OTHERS',
          ),
          const SizedBox(height: 12),
          _ToggleRow(
            title: 'Promotions',
            value: _promotions,
            onChanged: (value) => setState(() => _promotions = value),
          ),
          _ToggleRow(
            title: 'Tips',
            value: _tips,
            onChanged: (value) => setState(() => _tips = value),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    required this.icon,
    required this.iconBg,
    required this.title,
  });

  final IconData icon;
  final Color iconBg;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3C7),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: const Color(0xFFD97706)),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6B7280),
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF111418),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: const Color(0xFFF59E0B),
            inactiveThumbColor: Colors.white,

            inactiveTrackColor: const Color(0xFFE5E7EB),
          ),
        ],
      ),
    );
  }
}
