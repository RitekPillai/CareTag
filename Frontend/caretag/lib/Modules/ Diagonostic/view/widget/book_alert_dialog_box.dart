// The MVP Booking Dialog
import 'package:flutter/material.dart';

void showBookingDialog(BuildContext context) {
  String selectedService = 'HOME_COLLECTION';
  TextEditingController timeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Confirm Booking',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Column(
              mainAxisSize:
                  MainAxisSize.min, // Shrinks the dialog to fit the content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Service Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),

                RadioListTile<String>(
                  title: const Text(
                    'Home Collection',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  value: 'HOME_COLLECTION',
                  groupValue: selectedService,
                  activeColor: const Color(0xFF3B82F6),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) =>
                      setState(() => selectedService = value!),
                ),

                RadioListTile<String>(
                  title: const Text(
                    'Center Visit',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  value: 'CENTER_VISIT',
                  groupValue: selectedService,
                  activeColor: const Color(0xFF3B82F6),
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) =>
                      setState(() => selectedService = value!),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Color(0xFFF3F4F6), thickness: 1.5),
                ),

                const Text(
                  'Preferred Date & Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 12),

                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    hintText: 'e.g., Tomorrow at 10 AM',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FB),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
            actionsPadding: const EdgeInsets.only(right: 16, bottom: 16),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  final String time = timeController.text.isEmpty
                      ? "As soon as possible"
                      : timeController.text;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Booking Request Sent!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: const Color(0xFF10B981), // Emerald Green
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );

                  // 4. TODO: Fire your BLoC event to send this to Spring Boot!
                  print(
                    "🚀 SENDING TO BACKEND: Service: $selectedService, Time: $time",
                  );
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
