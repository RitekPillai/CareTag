import 'package:caretag/Modules/MyCare/view/pages/insurance/insurance_renew.dart';
import 'package:caretag/Modules/MyCare/view/pages/insurance/insurance_track_claim.dart';
import 'package:caretag/Modules/MyCare/view/pages/insurance/insurance_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InsurancePage extends StatelessWidget {
  InsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color darkishColor = Color(0xff111418);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Policy',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: darkishColor,
            ),
          ),
          SizedBox(height: 16.h),
          _ActivePolicyCard(),

          SizedBox(height: 24),

          Text(
            'Quick Actions',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _QuickActionTile(
                  icon: Icons.autorenew_rounded,
                  iconColor: Color(0xFF3B82F6),
                  iconBg: Color(0xFFEFF6FF),
                  label: 'Renew Policy',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InsuranceRenewPolicyPage(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _QuickActionTile(
                  icon: Icons.manage_search_rounded,
                  iconColor: Color(0xFF3B82F6),
                  iconBg: Color(0xFFEFF6FF),
                  label: 'Track Claim',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InsuranceTrackClaimPage(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _QuickActionTile(
                  icon: Icons.upload_file_outlined,
                  iconColor: Color(0xFF3B82F6),
                  iconBg: Color(0xFFEFF6FF),
                  label: 'Upload Doc',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => InsuranceUploadDocPage()),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current Claim',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InsuranceTrackClaimPage()),
                ),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _CurrentClaimCard(),

          SizedBox(height: 24),

          // ── Recent Documents ──────────────────────────────────────────────
          Text(
            'Recent Documents',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF111827),
            ),
          ),
          SizedBox(height: 12),
          _DocumentTile(
            name: 'Policy_Doc_2023.pdf',
            size: '2.4 MB',
            date: 'Oct 12, 2023',
          ),
          SizedBox(height: 10),
          _DocumentTile(
            name: 'Claim_Form_CLM-89201.pdf',
            size: '1.1 MB',
            date: 'Oct 24, 2023',
          ),
          SizedBox(height: 10),
          _DocumentTile(
            name: 'Medical_Report_Oct23.pdf',
            size: '3.7 MB',
            date: 'Oct 20, 2023',
          ),
        ],
      ),
    );
  }
}

class _ActivePolicyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF137FEC), Color(0xFF2563EB)],
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF137FEC).withValues(alpha: 0.2),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0xff137FEC).withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: -3,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white.withValues(alpha: 0.2),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset(
                        "assets/images/mycare/shiled.svg",
                        width: 16.w,
                        height: 20.h,
                      ),
                    ),
                  ),

                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROVIDER',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Color(0xffDBEAFE),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6,
                        ),
                      ),
                      Text(
                        'CarePlus Health',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  'Active',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 18),

          Text(
            'Total Coverage',
            style: GoogleFonts.inter(
              fontSize: 14.sp,

              fontWeight: FontWeight.w400,
              color: Color(0xffDBEAFE),
            ),
          ),
          SizedBox(height: 4),
          Text(
            '₹5,00,000',
            style: GoogleFonts.inter(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 16),
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 1),
          SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Policy Holder',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Sarah Johnson',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Expires in',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: Color(0xFFFBBF24),
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '45 days',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFDE047),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Quick Action Tile ─────────────────────────────────────────────────────────
class _QuickActionTile extends StatelessWidget {
  _QuickActionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrentClaimCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.medical_services_outlined,
                  color: Color(0xFFF97316),
                  size: 22,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dental Surgery',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      'Claim ID: #CLM-89201',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'In Progress',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF97316),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 14),
          Divider(color: Colors.grey.shade100, height: 1),
          SizedBox(height: 12),

          // Timeline steps
          _ClaimStep(
            dot: Colors.green,
            title: 'Documents Submitted',
            subtitle: 'Oct 24, 10:30 AM',
            isDone: true,
          ),
          SizedBox(height: 10),
          _ClaimStep(
            dot: Color(0xFF3B82F6),
            title: 'Medical Review',
            subtitle: 'Currently reviewing your documents',
            isActive: true,
            isDone: false,
          ),
          SizedBox(height: 10),
          _ClaimStep(
            dot: Colors.grey.shade300,
            title: 'Approval',
            subtitle: 'Pending',
            isDone: false,
          ),
        ],
      ),
    );
  }
}

class _ClaimStep extends StatelessWidget {
  _ClaimStep({
    required this.dot,
    required this.title,
    required this.subtitle,
    required this.isDone,
    this.isActive = false,
  });

  final Color dot;
  final String title;
  final String subtitle;
  final bool isDone;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10,
          height: 10,
          margin: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? Color(0xFF3B82F6)
                      : isDone
                      ? Color(0xFF111827)
                      : Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 1),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Document Tile ─────────────────────────────────────────────────────────────
class _DocumentTile extends StatelessWidget {
  _DocumentTile({required this.name, required this.size, required this.date});

  final String name;
  final String size;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.picture_as_pdf_outlined,
              color: Color(0xFFEF4444),
              size: 22,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '$size • $date',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.download_outlined, color: Color(0xFF6B7280), size: 20),
        ],
      ),
    );
  }
}
