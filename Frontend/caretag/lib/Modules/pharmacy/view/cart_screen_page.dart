import 'package:cached_network_image/cached_network_image.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/cart_bloc.dart';
import 'package:caretag/Modules/pharmacy/view/pages/check_out_page.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Color primaryGreen = const Color(0xFF1CAB5C);
  final TextEditingController _promoController = TextEditingController();
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCart());
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: GoogleFonts.publicSans(
            color: AppColor.darkishBlue,
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(LoadCart());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CartLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 100,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add medicines to get started',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Browse Medicines'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 24.h),
                        ...state.items.map((item) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColor.whiteCreamColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(32.r),
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        top: 16,
                                      ),
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Image.network(
                                          item.medicineImage,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.medicineName,
                                            style: GoogleFonts.publicSans(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: AppColor.darkishBlue,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '₹${(item.discountedPrice ?? item.price).toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor
                                                      .pharmacyGreenColor,
                                                ),
                                              ),

                                              if (item.discountedPrice !=
                                                  null) ...[
                                                const SizedBox(width: 8),
                                                Text(
                                                  '₹${item.price.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            item.packageSize,
                                            style: GoogleFonts.publicSans(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,

                                              color: Color(0xff94A3B8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                            RemoveFromCart(item.medicineId),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/pharmacy/delete.svg",
                                            ),
                                            SizedBox(width: 4.w),
                                            Text(
                                              'Remove',
                                              style: GoogleFonts.publicSans(
                                                fontSize: 14.sp,
                                                color: Color(0xff94A3B8),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Container(
                                          width: 110.w,
                                          height: 36.h,
                                          decoration: BoxDecoration(
                                            color: Color(0xffF8FAFC),
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.remove,
                                                  size: 16,
                                                  color: Color(0xff475569),
                                                ),
                                                onPressed: () {
                                                  if (item.quantity > 1) {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(
                                                          UpdateQuantity(
                                                            item.medicineId,
                                                            item.quantity - 1,
                                                          ),
                                                        );
                                                  }
                                                },
                                                constraints:
                                                    const BoxConstraints(
                                                      minWidth: 32,
                                                      minHeight: 32,
                                                    ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              Text(
                                                '${item.quantity}',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: AppColor
                                                      .pharmacyGreenColor,
                                                ),
                                                onPressed: () {
                                                  context.read<CartBloc>().add(
                                                    UpdateQuantity(
                                                      item.medicineId,
                                                      item.quantity + 1,
                                                    ),
                                                  );
                                                },
                                                constraints:
                                                    const BoxConstraints(
                                                      minWidth: 32,
                                                      minHeight: 32,
                                                    ),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        const SizedBox(height: 16),
                        // Promo Code
                        const SizedBox(height: 16),

                        // Bill Summary
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColor.whiteCreamColor),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bill Summary',
                                style: GoogleFonts.publicSans(
                                  fontSize: 18.sp,
                                  color: AppColor.darkishBlue,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),
                              _buildSummaryRow(
                                'Subtotal (${state.summary?.itemCount ?? 0} items)',
                                '₹${state.summary?.subtotal.toStringAsFixed(2) ?? '0.00'}',
                                false,
                              ),
                              const SizedBox(height: 8),
                              _buildSummaryRow(
                                'Delivery Fee',
                                '₹${state.summary?.deliveryFee.toStringAsFixed(2) ?? '0.00'}',
                                false,
                              ),
                              const SizedBox(height: 8),
                              _buildSummaryRow(
                                'Tax',
                                '₹${state.summary?.tax.toStringAsFixed(2) ?? '0.00'}',
                                false,
                              ),
                              if ((state.summary?.discount ?? 0) > 0) ...[
                                const SizedBox(height: 8),
                                _buildSummaryRow(
                                  'Discount',
                                  '-₹${state.summary?.discount.toStringAsFixed(2) ?? 'FREE'}',
                                  true,
                                ),
                              ],
                              const Divider(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: GoogleFonts.publicSans(
                                      fontSize: 16.sp,
                                      color: AppColor.darkishBlue,

                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '₹${state.summary?.totalAmount.toStringAsFixed(2) ?? '0.00'}',
                                    style: GoogleFonts.publicSans(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColor.pharmacyGreenColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.summary != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckoutScreen(cartSummary: state.summary!),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed to Checkout',
                          style: GoogleFonts.publicSans(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // --- UI Builder Methods ---

  Widget _buildSummaryRow(String label, String value, bool isGreenValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.publicSans(
            color: Color(0xff647A8B),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isGreenValue
                ? AppColor.pharmacyGreenColor
                : Color(0xff647A8B),
            fontWeight: isGreenValue ? FontWeight.w900 : FontWeight.w400,
            fontSize: isGreenValue ? 20.sp : 14,
          ),
        ),
      ],
    );
  }
}
