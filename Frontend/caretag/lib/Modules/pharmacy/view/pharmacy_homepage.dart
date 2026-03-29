import 'package:caretag/Modules/pharmacy/model/medicine/medicine_model.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/cart_bloc.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/pharmacy/parmacy_bloc.dart';
import 'package:caretag/Modules/pharmacy/view/cart_screen_page.dart';
import 'package:caretag/Modules/pharmacy/view/promotion_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MedsHomeScreen extends StatefulWidget {
  const MedsHomeScreen({Key? key}) : super(key: key);

  @override
  State<MedsHomeScreen> createState() => _MedsHomeScreenState();
}

class _MedsHomeScreenState extends State<MedsHomeScreen> {
  final Color primaryGreen = const Color(0xFF10B981);

  @override
  void initState() {
    super.initState();
    context.read<PharmacyBloc>().add(LoadPharmacyHome());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PharmacyBloc, PharmacyState>(
      builder: (context, state) {
        if (state is PharmacyLoading) {
          return Center(child: CircularProgressIndicator(color: primaryGreen));
        } else if (state is PharmacyError) {
          return Center(
            child: Text(
              'Error: ${state.message}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is PharmacyHomeLoaded) {
          return Stack(
            children: [
              // 1. The Scrollable Content
              SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 100,
                ), // Give room for the cart
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildDeliveryInfo(),
                          SizedBox(height: state.offers.isEmpty ? 0 : 20),
                          state.offers.isEmpty
                              ? Container()
                              : _buildPromoBanner(),
                          const SizedBox(height: 28),
                          _buildSectionHeader('Categories', 'View All'),
                          const SizedBox(height: 16),
                          _buildCategories(),
                          const SizedBox(height: 28),
                          const Text(
                            'Previously Ordered',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildPreviouslyOrdered(),
                          const SizedBox(height: 28),

                          _buildSectionHeader('Featured Products', 'Browse'),
                          state.featuredProducts.isEmpty
                              ? Center(
                                  child: Text("There is no product Available"),
                                )
                              : SizedBox(
                                  height: 300.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,

                                    itemCount: state.featuredProducts.length,
                                    itemBuilder: (context, index) =>
                                        _buildProductCard(
                                          state.featuredProducts[index].name,
                                          state.featuredProducts[index].price
                                              .toString(),
                                          state
                                              .featuredProducts[index]
                                              .imageUrl,
                                          Medicine(
                                            id: state
                                                .featuredProducts[index]
                                                .id,
                                            name: state
                                                .featuredProducts[index]
                                                .name,
                                            price: state
                                                .featuredProducts[index]
                                                .price,
                                            category: state
                                                .featuredProducts[index]
                                                .category,
                                            manufacturer: state
                                                .featuredProducts[index]
                                                .manufacturer,
                                            brand: state
                                                .featuredProducts[index]
                                                .brand,
                                            imageUrl: state
                                                .featuredProducts[index]
                                                .imageUrl,
                                            requiresPrescription: state
                                                .featuredProducts[index]
                                                .requiresPrescription,
                                            inStock: state
                                                .featuredProducts[index]
                                                .inStock,
                                            packageSize: state
                                                .featuredProducts[index]
                                                .packageSize,
                                            form: state
                                                .featuredProducts[index]
                                                .form,
                                          ),
                                        ),
                                  ),
                                ),

                          Text(
                            'Nearby Pharmacies',
                            style: GoogleFonts.publicSans(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColor.darkishBlue,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          state.nearbyPharmacies.isEmpty
                              ? const Center(
                                  child: Text("There is No Pharmacies Nearby"),
                                )
                              : SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                    itemCount: state.nearbyPharmacies.length,
                                    itemBuilder: (context, index) =>
                                        _buildPharmacyTile(
                                          state.nearbyPharmacies[index].name,
                                          state.nearbyPharmacies[index].distance
                                              .toString(),
                                          state.nearbyPharmacies[index].rating
                                              .toString(),
                                          state
                                              .nearbyPharmacies[index]
                                              .isOpenNow,
                                        ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 20,
                left: 100,
                child: _buildFloatingCart(context),
              ),
            ],
          );
        }
        // 4. Initial/Fallback State
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
            ],
          ),
          child: Icon(Icons.near_me, color: primaryGreen, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DELIVERY IN 15 MINS',
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  'Home - 123 Healthcare Blvd',
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OfferDetailsScreen()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF34D399), Color(0xFF064E3B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'LIMITED OFFER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Get 20% Off',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'On all essential health kits',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Use: HEALTH20',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          actionText,
          style: TextStyle(
            color: primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryItem(
          Icons.thermostat,
          'Fever',
          const Color(0xFFFEE2E2),
          const Color(0xFFEF4444),
        ),
        _buildCategoryItem(
          Icons.water_drop_outlined,
          'Diabetes',
          const Color(0xFFDBEAFE),
          const Color(0xFF3B82F6),
        ),
        _buildCategoryItem(
          Icons.face,
          'Skin',
          const Color(0xFFFFEDD5),
          const Color(0xFFF97316),
        ),
        _buildCategoryItem(
          Icons.medication_outlined,
          'Vitamins',
          const Color(0xFFD1FAE5),
          primaryGreen,
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
    IconData icon,
    String label,
    Color bgColor,
    Color iconColor,
  ) {
    return Column(
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildPreviouslyOrdered() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=250&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Paracetamol 500mg',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ordered 2 weeks ago',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFD1FAE5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Reorder',
              style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String title,
    String price,
    String imageUrl,
    Medicine medicine,
  ) {
    return Container(
      width: 170.w,
      height: 256.h,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
            color: AppColor.getShadowColor(0.05),
          ),
          BoxShadow(
            color: AppColor.whiteCreamColor,
            offset: Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              height: 136.h,
              width: 136.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.pexels.com/photos/7277984/pexels-photo-7277984.jpeg?cs=srgb&dl=pexels-mart-production-7277984.jpg&fm=jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: AppColor.darkishBlue,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Text(
            "₹$price",
            style: GoogleFonts.publicSans(
              color: AppColor.pharmacyGreenColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () {
              context.read<CartBloc>().add(AddToCart(medicine));
            },
            child: Container(
              width: 140.w,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColor.pharmacyGreenColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  SizedBox(width: 3.92.w),
                  Text(
                    "Add",
                    style: GoogleFonts.publicSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyTile(
    String name,
    String distance,
    String rating,
    bool isOpen,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.local_pharmacy_outlined, color: primaryGreen),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      distance,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('•', style: TextStyle(color: Colors.grey)),
                    const SizedBox(width: 4),
                    Text(
                      isOpen ? 'Open Now' : 'Closed',
                      style: TextStyle(
                        color: isOpen ? primaryGreen : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 16),
              const SizedBox(width: 4),
              Text(
                rating,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCart(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartScreen()),
        );
      },
      child: Container(
        width: 214.w,
        height: 56.h,

        decoration: BoxDecoration(
          color: AppColor.pharmacyGreenColor,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 6,
              spreadRadius: -4,
              color: Color(0xff14532D).withValues(alpha: 0.2),
            ),
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 15,
              spreadRadius: -3,
              color: Color(0xff14532D).withValues(alpha: 0.2),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 5),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=150&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View cart',
                  style: GoogleFonts.publicSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  '1 item',
                  style: GoogleFonts.publicSans(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColor.getShadowColor(0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 26,
              ),
            ),
            SizedBox(width: 16.w),
          ],
        ),
      ),
    );
  }
}
