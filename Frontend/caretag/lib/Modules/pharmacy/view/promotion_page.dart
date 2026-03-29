import 'package:caretag/constants/app_color.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({Key? key}) : super(key: key);

  final Color primaryGreen = const Color(0xFF16A34A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Offer Details',
          style: GoogleFonts.publicSans(
            color: AppColor.darkishBlue,
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF111827)),
            onPressed: () {
              // TODO: Implement share logic
            },
          ),
        ],
      ),

      bottomNavigationBar: _buildBottomButton(),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(),
            SizedBox(height: 32.h),
            _buildTitleAndDescription(),
            SizedBox(height: 32.h),
            _buildPromoCodeCard(context),
            SizedBox(height: 16.h),
            _buildTrustBadge(),
            SizedBox(height: 57.h),
            Text(
              'TERMS & CONDITIONS',
              style: GoogleFonts.publicSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFF475569),
              ),
            ),
            SizedBox(height: 16.h),
            _buildTermsList(),
            const SizedBox(height: 20), // Extra bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 256.h,
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),

        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=800&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(34.r),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.green.shade900.withOpacity(0.8),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'NEW USER SPECIAL',
                style: GoogleFonts.publicSans(
                  color: primaryGreen,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Flat 20% OFF',
              style: GoogleFonts.publicSans(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to CareTag\nPharmacy',
          style: GoogleFonts.publicSans(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: AppColor.darkishBlue,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Start your wellness journey with us. Get a flat 20% discount on your first order of authentic medicines. We ensure quality health care at your doorstep.',
          style: GoogleFonts.publicSans(
            fontSize: 14,
            color: Color(0xff475569),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCodeCard(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(24.r),
        dashPattern: [10, 5],
        strokeWidth: 2,
        color: primaryGreen.withValues(alpha: 0.5),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Text(
              'USE PROMO CODE',
              style: GoogleFonts.publicSans(
                color: AppColor.greyTextColor1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.4,
              ),
            ),
            SizedBox(height: 12.h),
            InkWell(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: 'CARE20'));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Promo code copied to clipboard!',
                      style: GoogleFonts.publicSans(color: primaryGreen),
                    ),
                    backgroundColor: Colors.white,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CARE20',
                      style: GoogleFonts.publicSans(
                        color: primaryGreen,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.copy_outlined, color: primaryGreen, size: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadge() {
    return Container(
      width: 360.w,
      height: 270.h,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28.h),
          Container(
            width: 56.w,
            height: 56.h,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Color(0xFFECFDF5),
            ),
            child: Icon(
              Icons.verified_user_outlined,
              color: primaryGreen,
              size: 30,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            'Safe & Authentic Medicines',
            style: GoogleFonts.publicSans(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.darkishBlue,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '100% genuine products sourced directly from licensed manufacturers.',
            style: GoogleFonts.publicSans(
              fontSize: 14.sp,
              color: Color(0xff64748B),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildTermsList() {
    return Column(
      children: [
        _buildTermRow(
          'Valid for new registered users on their first order only.',
        ),
        _buildTermRow(
          'Minimum order value of \$50 required to avail the discount.',
        ),
        _buildTermRow('Maximum discount applicable is up to \100.'),
        _buildTermRow(
          'Cannot be combined with any other ongoing offers or coupons.',
        ),
      ],
    );
  }

  Widget _buildTermRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_outline, color: primaryGreen, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.publicSans(
                color: Color(0xff475569),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      height: 89.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        boxShadow: [
          BoxShadow(
            color: AppColor.whiteCreamColor,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 358.w,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Navigate to shopping screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.r),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Shop Now',
                  style: GoogleFonts.publicSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
