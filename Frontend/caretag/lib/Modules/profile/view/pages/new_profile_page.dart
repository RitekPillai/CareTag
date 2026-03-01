// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/profile/view/pages/about_us_page.dart';
import 'package:caretag/Modules/profile/view/pages/app_prefrence_page.dart';
import 'package:caretag/Modules/profile/view/pages/app_setting_page.dart';
import 'package:caretag/Modules/profile/view/pages/contact_support_page.dart';
import 'package:caretag/Modules/profile/view/pages/my_dashboard__page.dart';
import 'package:caretag/Modules/profile/view/pages/notification_prefrence_page.dart';
import 'package:caretag/Modules/profile/view/pages/payment_methods_page.dart';
import 'package:caretag/Modules/profile/view/pages/privacy_policy_page.dart';
import 'package:caretag/Modules/profile/view/pages/profile_edit_page.dart';
import 'package:caretag/Modules/profile/view/pages/report_problem_page.dart';
import 'package:caretag/Modules/profile/view/pages/security_login_page.dart';
import 'package:caretag/Modules/profile/view/pages/subscription_page.dart';
import 'package:caretag/Modules/profile/view/pages/terms_conditions_page.dart';
import 'package:caretag/Modules/profile/view/pages/transcation_history_page.dart';
import 'package:caretag/widgets/help_page.dart';

class ProfilePage extends StatelessWidget {
  final Profilemodel profilemodel;
  const ProfilePage({super.key, required this.profilemodel});

  @override
  Widget build(BuildContext context) {
    Profilemodel profilemodel = this.profilemodel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ProfileHeader(
                      profilemodel.fullName,
                      profilemodel.careTagId,
                      profilemodel.imageUrl,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 13.h),
                          _SectionTitle('Account Settings'),
                          SizedBox(height: 14.h),
                          _SectionCard(
                            items: [
                              _ItemData(
                                icon: Icons.edit_note,
                                iconBg: Color(0xFFE7F0FF),
                                iconColor: Color(0xFF2F80ED),
                                title: 'Edit profile',
                                pageName: ProfileEditPage(),
                              ),
                              _ItemData(
                                icon: Icons.credit_card,
                                iconBg: Color(0xFFE2F7EA),
                                iconColor: Color(0xFF27AE60),
                                title: 'Payment methods',
                                pageName: PaymentMethodsPage(),
                              ),
                              _ItemData(
                                icon: Icons.settings_outlined,
                                iconBg: Color(0xFFF3F4F6),
                                iconColor: Color(0xFF6B7280),
                                title: 'App settings',
                                pageName: AppSettingPage(),
                              ),
                              _ItemData(
                                icon: Icons.notifications_none,
                                iconBg: Color(0xFFFFF2CC),
                                iconColor: Color(0xFFF2994A),
                                title: 'Notification Preference',
                                pageName: NotificationPrefrencePage(),
                              ),
                              _ItemData(
                                icon: Icons.lock_outline,
                                iconBg: Color(0xFFF0E8FF),
                                iconColor: Color(0xFF9B51E0),
                                title: 'Security & Login',
                                pageName: SecurityLoginPage(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          _SectionTitle('Earing / Usage Section'),
                          SizedBox(height: 14),
                          _SectionCard(
                            items: [
                              _ItemData(
                                icon: Icons.grid_view,
                                iconBg: Color(0xFFE6ECFF),
                                iconColor: Color(0xFF5B6EF5),
                                title: 'My Dashboard',
                                pageName: MyDashBoard(),
                              ),
                              _ItemData(
                                icon: Icons.rotate_right,
                                iconBg: Color(0xFFFFF2CC),
                                iconColor: Color(0xFFE5A800),
                                title: 'Subscriptions',
                                pageName: SettingSubsctionPage(),
                              ),
                              _ItemData(
                                icon: Icons.receipt_long,
                                iconBg: Color(0xFFDDF8F5),
                                iconColor: Color(0xFF2AAFA0),
                                title: 'Transaction History',

                                pageName: TranscationHistorypage(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          _SectionTitle('Support & Help'),
                          SizedBox(height: 14),
                          _SectionCard(
                            items: [
                              _ItemData(
                                icon: Icons.help_outline,
                                iconBg: Color(0xFFF1F5F9),
                                iconColor: Color(0xFF64748B),
                                title: 'Help Center',
                                pageName: help(),
                              ),
                              _ItemData(
                                icon: Icons.support_agent,
                                iconBg: Color(0xFFFCE7F3),
                                iconColor: Color(0xFFEC4899),
                                title: 'Contact Support',
                                pageName: ContactSupportPage(),
                              ),
                              _ItemData(
                                icon: Icons.warning_amber_outlined,
                                iconBg: Color(0xFFFFEDD5),
                                iconColor: Color(0xFFF97316),
                                title: 'Report a Problem',
                                pageName: ReportProblemPage(),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          _SectionTitle('App & Legal'),
                          SizedBox(height: 14),
                          _SectionCard(
                            items: [
                              _ItemData(
                                icon: Icons.tune,
                                iconBg: Color(0xFFF1F5F9),
                                iconColor: Color(0xFF6B7280),
                                title: 'App Preferences',
                                pageName: AppPrefrencePage(),
                              ),
                              _ItemData(
                                icon: Icons.description_outlined,
                                iconBg: Color(0xFFE0F2FE),
                                iconColor: Color(0xFF0284C7),
                                title: 'Terms & Conditions Support',
                                pageName: TermsConditionsPage(),
                              ),
                              _ItemData(
                                icon: Icons.shield_outlined,
                                iconBg: Color(0xFFDCFCE7),
                                iconColor: Color(0xFF16A34A),
                                title: 'Privacy Policy',
                                pageName: PrivacyPolicyPage(),
                              ),
                              _ItemData(
                                icon: Icons.info_outline,
                                iconBg: Color(0xFFE0E7FF),
                                iconColor: Color(0xFF4F46E5),
                                title: 'About App',
                                pageName: AboutUsPage(),
                              ),
                            ],
                          ),
                          SizedBox(height: 28),
                          _LogoutButton(),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String careTag;
  final String imageUrl;

  const _ProfileHeader(this.name, this.careTag, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF5EACFF), Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(280, 130),
          bottomRight: Radius.elliptical(280, 130),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Profile',
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 18.w),
          Container(
            height: 122.h,
            width: 119.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            careTag,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(
                107,
                114,
                128,
                1,
              ), // Using the correct color value
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF111827),
      ),
    );
  }
}

class _ItemData {
  const _ItemData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.pageName,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final Widget pageName;
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.items});

  final List<_ItemData> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFECEFF3)),
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _SettingRow(item: items[index]),
            if (index != items.length - 1)
              const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          ],
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.item});

  final _ItemData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.pageName != null
          ? () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => item.pageName),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: item.iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(item.icon, size: 20, color: item.iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                item.title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF111418),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFB0B7C3)),
          ],
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFED1C24),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 20 / 2, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _NavItem(icon: Icons.home_outlined, label: 'Home'),
          _NavItem(icon: Icons.assignment_outlined, label: 'Records'),
          _NavItem(icon: Icons.account_balance_outlined, label: 'My Care'),
          _NavItem(icon: Icons.description_outlined, label: 'News'),
          _NavItem(icon: Icons.person, label: 'Profile', active: true),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF1E63F4) : const Color(0xFF6B7280);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (active)
          Container(
            width: 26,
            height: 3,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E63F4),
              borderRadius: BorderRadius.circular(12),
            ),
          )
        else
          const SizedBox(height: 11),
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}
