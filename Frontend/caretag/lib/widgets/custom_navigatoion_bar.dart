import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomNavigatoionBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  const CustomNavigatoionBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<CustomNavigatoionBar> createState() => _CustomNavigatoionBarState();
}

class _CustomNavigatoionBarState extends State<CustomNavigatoionBar> {
  @override
  Widget build(BuildContext context) {
    const String imagePath = "assets/images/navigation";
    return Container(
      height: 77.h,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          naviItem("$imagePath/home.svg", "Home", 0, "$imagePath/s_home.svg"),
          naviItem(
            "$imagePath/records.svg",
            "Records",
            1,
            "$imagePath/s_records.svg",
          ),
          naviItem(
            "$imagePath/mycare.svg",
            "My Care",
            2,
            "$imagePath/s_mycare.svg",
          ),
          naviItem("$imagePath/news.svg", "News", 3, "$imagePath/s_news.svg"),
          naviItem(
            "$imagePath/profile.svg",
            "Profile",
            4,
            "$imagePath/s_profile.svg",
          ),
        ],
      ),
    );
  }

  Widget naviItem(
    String imagePath,
    String name,
    int index,
    String selectedImagePath,
  ) {
    bool isSelected = widget.selectedIndex == index;
    Color textColor = Color(0xff415762);
    Color activeColor = const Color(0xff0063F7);

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 4.h,
            width: isSelected ? 30.w : 0,
            decoration: BoxDecoration(
              color: activeColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(3.98.r),
                bottomRight: Radius.circular(3.98.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          SvgPicture.asset(
            isSelected ? selectedImagePath : imagePath,

            width: 24.w,
          ),
          SizedBox(height: 4.h),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
              fontSize: 12,
              color: isSelected ? activeColor : textColor,
            ),
          ),
        ],
      ),
    );
  }
}
