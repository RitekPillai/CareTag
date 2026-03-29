import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationItem {
  final String? icon;
  final String? selectedIcon;
  final IconData? materialIcon;
  final String label;

  NavigationItem({
    this.icon,
    this.selectedIcon,
    this.materialIcon,
    required this.label,
  });
}

class CustomNavigatoionBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<NavigationItem>? items;
  final Color? activeColor;

  const CustomNavigatoionBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    this.items,
    this.activeColor,
  });

  @override
  State<CustomNavigatoionBar> createState() => _CustomNavigatoionBarState();
}

class _CustomNavigatoionBarState extends State<CustomNavigatoionBar> {
  List<NavigationItem> get defaultItems {
    const String imagePath = "assets/images/navigation";
    return [
      NavigationItem(
        icon: "$imagePath/home.svg",
        selectedIcon: "$imagePath/s_home.svg",
        label: "Home",
      ),
      NavigationItem(
        icon: "$imagePath/records.svg",
        selectedIcon: "$imagePath/s_records.svg",
        label: "Records",
      ),
      NavigationItem(
        icon: "$imagePath/mycare.svg",
        selectedIcon: "$imagePath/s_mycare.svg",
        label: "My Care",
      ),
      NavigationItem(
        icon: "$imagePath/news.svg",
        selectedIcon: "$imagePath/s_news.svg",
        label: "News",
      ),
      NavigationItem(
        icon: "$imagePath/profile.svg",
        selectedIcon: "$imagePath/s_profile.svg",
        label: "Profile",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items ?? defaultItems;

    return Container(
      height: 77.h,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < items.length; i++) naviItem(items[i], i),
        ],
      ),
    );
  }

  Widget naviItem(NavigationItem item, int index) {
    bool isSelected = widget.selectedIndex == index;
    Color textColor = Color(0xff415762);
    Color activeColor = widget.activeColor ?? const Color(0xff0063F7);

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
          if (item.materialIcon != null)
            Icon(
              item.materialIcon,
              size: 24.w,
              color: isSelected ? activeColor : textColor,
            )
          else
            SvgPicture.asset(
              isSelected ? (item.selectedIcon ?? item.icon!) : item.icon!,
              width: 24.w,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : textColor,
                BlendMode.srcIn,
              ),
            ),
          SizedBox(height: 4.h),
          Text(
            item.label,
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
