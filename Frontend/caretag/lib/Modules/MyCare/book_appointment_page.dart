import 'package:caretag/Modules/MyCare/appointment_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:provider/provider.dart';
// import 'appointment_repo.dart';

class BookAppointmentPage extends StatefulWidget {
  final int doctorId;
  final String doctorName;
  final String specialty;
  final String hospitalName;
  final String imageUrl;
  final String distance;
  final double rating;

  const BookAppointmentPage({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.hospitalName,
    required this.imageUrl,
    required this.distance,
    required this.rating,
  }) : super(key: key);

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  late DateTime selectedDate;
  String? selectedTime;
  List<DateTime> upcomingDates = [];
  List<String> availableSlots = [];
  bool isLoadingSlots = false;
  bool isBooking = false;

  @override
  void initState() {
    super.initState();
    // Generate the next 14 days
    selectedDate = DateTime.now();
    for (int i = 0; i < 14; i++) {
      upcomingDates.add(DateTime.now().add(Duration(days: i)));
    }
    _fetchSlots();
  }

  Future<void> _fetchSlots() async {
    setState(() {
      isLoadingSlots = true;
      selectedTime = null; // Reset time when day changes
    });

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      // Call Repo
      final repo = AppointmentRepo();
      final auth = context.read<Authenticationservice>();
      final slots = await repo.getAvailableSlots(
        auth,
        widget.doctorId,
        formattedDate,
      );

      if (mounted) {
        setState(() {
          availableSlots = slots;
          isLoadingSlots = false;
        });
      }
    } catch (e) {
      setState(() => isLoadingSlots = false);
    }
  }

  Future<void> _bookAppointment() async {
    if (selectedTime == null) return;

    setState(() => isBooking = true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    final repo = AppointmentRepo();
    final auth = context.read<Authenticationservice>();

    bool success = await repo.bookAppointment(
      auth,
      widget.doctorId,
      formattedDate,
      selectedTime!,
    );

    if (mounted) {
      setState(() => isBooking = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment Booked Successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Go back after booking
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to book. Slot might be taken.'),
            backgroundColor: Colors.red,
          ),
        );
        _fetchSlots(); // Refresh slots
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1877F2); // Match your theme

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
          'Book Appointment',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- DOCTOR CARD (Matches UI exactly) ---
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dr. ${widget.doctorName}",
                                style: GoogleFonts.inter(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${widget.specialty} • ${widget.hospitalName}",
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: const Color(0xFF6B7280),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.near_me_outlined,
                                    size: 14.sp,
                                    color: primaryBlue,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    widget.distance,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: primaryBlue,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Icon(
                                    Icons.star,
                                    size: 14.sp,
                                    color: const Color(0xFFF59E0B),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "${widget.rating}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // --- SCHEDULES HEADER ---
                  Text(
                    "Schedules",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // --- HORIZONTAL DATE SELECTOR ---
                  SizedBox(
                    height: 80.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: upcomingDates.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 12.w),
                      itemBuilder: (context, index) {
                        DateTime date = upcomingDates[index];
                        bool isSelected =
                            DateFormat('yyyy-MM-dd').format(date) ==
                            DateFormat('yyyy-MM-dd').format(selectedDate);

                        String dayLabel = index == 0
                            ? "Today"
                            : DateFormat('E').format(date); // 'Thu'
                        String dateLabel = DateFormat(
                          'd MMM',
                        ).format(date); // '24 Oct'

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedDate = date);
                            _fetchSlots();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryBlue : Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: isSelected
                                    ? primaryBlue
                                    : Colors.grey.shade200,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dayLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF6B7280),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  dateLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // --- TIME SLOT GRID ---
                  isLoadingSlots
                      ? const Center(
                          child: CircularProgressIndicator(color: primaryBlue),
                        )
                      : availableSlots.isEmpty
                      ? Center(
                          child: Text(
                            "No slots available on this date.",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        )
                      : Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: availableSlots.map((time) {
                            bool isSelected = selectedTime == time;
                            return GestureDetector(
                              onTap: () => setState(() => selectedTime = time),
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width -
                                        40.w -
                                        24.w) /
                                    3, // Fits 3 across perfectly
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryBlue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: isSelected
                                        ? primaryBlue
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  time,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF374151),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),

          // --- BOTTOM BOOK BUTTON ---
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: selectedTime == null || isBooking
                    ? null
                    : _bookAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  disabledBackgroundColor: primaryBlue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: isBooking
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Book Appointment",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
