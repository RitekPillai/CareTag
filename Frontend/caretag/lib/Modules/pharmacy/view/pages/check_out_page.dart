import 'package:caretag/Modules/pharmacy/model/cart/cart_summary.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/order/oder_bloc.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class CheckoutScreen extends StatefulWidget {
  final CartSummary cartSummary;
  const CheckoutScreen({Key? key, required this.cartSummary}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _useDefaultAddress = true;
  final Color primaryGreen = AppColor.pharmacyGreenColor;
  final Color darkText = AppColor.darkishBlue;
  final Color greyText = const Color(0xFF64748B);
  void _placeOrder() {
    final items = widget.cartSummary.items
        .map(
          (item) => {'medicineId': item.medicineId, 'quantity': item.quantity},
        )
        .toList();

    // context.read<OrderBloc>().add(
    //   CreateOrder(
    //     items: items,
    //     deliveryAddress: deliveryAddress.toJson(),
    //     paymentMethod: selectedPaymentMethod,
    //     prescriptionUrl: prescriptionUrl,
    //     promoCode: _promoController.text.trim().isNotEmpty
    //         ? _promoController.text.trim()
    //         : null,
    //   ),
    // );

    // Show success message and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.publicSans(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ),

      bottomNavigationBar: _buildBottomActionArea(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Address',
                  style: GoogleFonts.publicSans(
                    color: darkText,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to address edit screen
                  },
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAddressCard(),

            const SizedBox(height: 32),

            // --- ORDER SUMMARY SECTION ---
            Text(
              'Order Summary',
              style: GoogleFonts.publicSans(
                color: darkText,
                fontSize: 18.sp,

                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildOrderSummaryCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // UI BUILDER METHODS
  // ==========================================

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.home_filled, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Home',
                  style: GoogleFonts.publicSans(
                    color: darkText,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '123 Main St, Springfield',
                  style: TextStyle(color: greyText, fontSize: 13),
                ),
              ],
            ),
          ),
          CupertinoSwitch(
            value: _useDefaultAddress,
            activeColor: primaryGreen,
            onChanged: (value) {
              setState(() {
                _useDefaultAddress = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.cartSummary.items.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(color: Colors.grey.shade50, thickness: 1),
            ),
            itemBuilder: (context, index) {
              final item = widget.cartSummary.items[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Icon(
                      Icons.medication_outlined,
                      color: primaryGreen,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.medicineName,
                          style: GoogleFonts.publicSans(
                            color: darkText,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Qty: ${item.quantity}',
                          style: TextStyle(color: greyText, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    // 🚨 Rupee symbol added here
                    '₹${item.itemTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.publicSans(
                      color: darkText,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade100, thickness: 1.5),
          const SizedBox(height: 20),

          // --- DYNAMIC COST BREAKDOWN ---
          _buildSummaryRow(
            'Subtotal',
            // 🚨 Rupee symbol added here
            '₹${widget.cartSummary.subtotal.toStringAsFixed(2)}',
            false,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Delivery Fee',
            widget.cartSummary.deliveryFee == 0
                ? 'FREE'
                // 🚨 Rupee symbol added here
                : '₹${widget.cartSummary.deliveryFee.toStringAsFixed(2)}',
            widget.cartSummary.deliveryFee == 0,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Tax',
            // 🚨 Rupee symbol added here
            '₹${widget.cartSummary.tax.toStringAsFixed(2)}',
            false,
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade100, thickness: 1.5),
          const SizedBox(height: 20),

          // --- DYNAMIC TOTAL ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: GoogleFonts.publicSans(
                  color: darkText,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                // 🚨 Rupee symbol added here
                '₹${widget.cartSummary.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.publicSans(
                  color: darkText,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isFree) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: greyText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: isFree ? primaryGreen : darkText,
            fontSize: 14,
            fontWeight: isFree ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionArea() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FDFB), // Very faint green tint from the design
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryGreen,
                elevation: 4,
                shadowColor: primaryGreen.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select Payment Method',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security_outlined,
                color: Colors.grey.shade400,
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'Secure 256-bit SSL encrypted payment',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
