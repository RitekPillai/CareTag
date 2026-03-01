import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPrefrencePage extends StatefulWidget {
  static const routeName = '/app-preferences';
  const AppPrefrencePage({super.key});

  @override
  State<AppPrefrencePage> createState() => _AppPrefrencePageState();
}

class _AppPrefrencePageState extends State<AppPrefrencePage> {
  String _measurementUnit = 'metric';
  String _temperatureUnit = 'celsius';
  String _dateFormat = 'ddmmyyyy';
  String _defaultLandingPage = 'dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'App Preferences',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        shadowColor: AppColor.getShadowColor(0.05),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _PreferenceSection(
            icon: Icons.straighten,
            title: 'Measurement Units',
            children: [
              _RadioOption(
                label: 'Metric (cm, kg)',
                value: 'metric',
                groupValue: _measurementUnit,
                onChanged: (value) {
                  setState(() => _measurementUnit = value!);
                },
              ),
              _RadioOption(
                label: 'Imperial (ft, lbs)',
                value: 'imperial',
                groupValue: _measurementUnit,
                onChanged: (value) {
                  setState(() => _measurementUnit = value!);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _PreferenceSection(
            icon: Icons.thermostat_outlined,
            title: 'Temperature Unit',
            children: [
              _RadioOption(
                label: 'Celsius (°C)',
                value: 'celsius',
                groupValue: _temperatureUnit,
                onChanged: (value) {
                  setState(() => _temperatureUnit = value!);
                },
              ),
              _RadioOption(
                label: 'Fahrenheit (°F)',
                value: 'fahrenheit',
                groupValue: _temperatureUnit,
                onChanged: (value) {
                  setState(() => _temperatureUnit = value!);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _PreferenceSection(
            icon: Icons.calendar_month_outlined,
            title: 'Date Format',
            children: [
              _RadioOption(
                label: 'DD/MM/YYYY',
                value: 'ddmmyyyy',
                groupValue: _dateFormat,
                onChanged: (value) {
                  setState(() => _dateFormat = value!);
                },
              ),
              _RadioOption(
                label: 'MM/DD/YYYY',
                value: 'mmddyyyy',
                groupValue: _dateFormat,
                onChanged: (value) {
                  setState(() => _dateFormat = value!);
                },
              ),
              _RadioOption(
                label: 'YYYY-MM-DD',
                value: 'yyyymmdd',
                groupValue: _dateFormat,
                onChanged: (value) {
                  setState(() => _dateFormat = value!);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _PreferenceSection(
            icon: Icons.home_outlined,
            title: 'Default Landing Page',
            children: [
              _RadioOption(
                label: 'Dashboard',
                value: 'dashboard',
                groupValue: _defaultLandingPage,
                onChanged: (value) {
                  setState(() => _defaultLandingPage = value!);
                },
              ),
              _RadioOption(
                label: 'Profile',
                value: 'profile',
                groupValue: _defaultLandingPage,
                onChanged: (value) {
                  setState(() => _defaultLandingPage = value!);
                },
              ),
              _RadioOption(
                label: 'Activity Log',
                value: 'activity',
                groupValue: _defaultLandingPage,
                onChanged: (value) {
                  setState(() => _defaultLandingPage = value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreferenceSection extends StatelessWidget {
  const _PreferenceSection({
    required this.icon,
    required this.title,
    required this.children,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: const Color(0xFF4B5563)),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF111418),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        ...children,
      ],
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 52.w),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: const Color(0xFF374151),
                fontWeight: FontWeight.w400,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: 8.w),
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF137FEC)
                      : const Color(0xFFD1D5DB),

                  width: isSelected ? 6.5.w : 2.0.w,
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
