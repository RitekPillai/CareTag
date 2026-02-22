import 'package:caretag/Modules/records_module/view/pages/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DocContainerTile extends StatefulWidget {
  const DocContainerTile({super.key});

  @override
  State<DocContainerTile> createState() => _DocContainerTileState();
}

class _DocContainerTileState extends State<DocContainerTile>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 500);
    controller.reverseDuration = const Duration(milliseconds: 500);
    controller.drive(CurveTween(curve: Curves.bounceInOut));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Color> containerBgColor = [Color(0xff0D7FF2), Color(0xff2563EB)];
    const Color shawdowColor = Color.fromRGBO(13, 127, 242, 0.3);
    const Color addButtonTextColor = Color(0xff0D7FF2);

    return Container(
      width: 342.w,
      height: 224.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: containerBgColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: shawdowColor,
            offset: Offset(0, 4),
            blurRadius: 20,
            spreadRadius: -2,
          ),
        ],
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Documents",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.75.h),

                  Text(
                    textAlign: TextAlign.start,
                    "Quickly upload, scan, or\nimport your medical records\nto your secure vault.",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Color(0xffEFF6FF),
                    ),
                  ),
                ],
              ),

              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(100),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/images/records/docs.svg",
                    width: 29.95.w,
                    height: 33.05.h,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(294.w, 44.h)),

              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r),
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            onPressed: () => onClick(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/records/add.svg"),
                SizedBox(width: 8.w),
                Text(
                  "Add New Record",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: addButtonTextColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onClick(BuildContext context) {
    const Color bootomSheetShadowColor = Color.fromRGBO(0, 0, 0, 0.25);
    const Color greyColor = Color(0xffD1D5DB);
    const Color textColor = Color(0xff0D3C61);
    const Color cancelButtonTextColor = Color(0xff4B5563);
    const Color buttonBgColor = Color(0xffF3F4F6);

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      transitionAnimationController: controller,
      builder: (context) {
        return Container(
          width: 393.w,
          height: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 25),
                blurRadius: 50,
                spreadRadius: -15,
                color: bootomSheetShadowColor,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999.r),
                    color: greyColor,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  "Add Record Source",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: textColor,
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              bottomSheetItem(
                "assets/images/records/scanner.svg",
                "Camera Scanner",
                "Scan paper documents instantly",
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0, 1);
                            const end = Offset.zero;

                            var tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: Curves.ease));

                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              ),
                            );
                          },
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return CameraScreen();
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
              SizedBox(height: 46.h),

              bottomSheetItem(
                "assets/images/records/files.svg",
                "Upload Files",
                "Import PDFs or documents",
                () {},
              ),
              SizedBox(height: 46.h),
              bottomSheetItem(
                "assets/images/records/gallery.svg",
                "Photo Gallery",
                "Select from photos",
                () {},
              ),
              SizedBox(height: 44.h),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 50.h,
                    width: 346.w,

                    decoration: BoxDecoration(
                      color: buttonBgColor,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                          color: cancelButtonTextColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bottomSheetItem(
    String imagePath,
    String title,
    String discription,
    VoidCallback onTap,
  ) {
    const Color contatinerColor = Color(0xffEFF6FF);
    const Color textColor = Color(0xff111827);
    const Color discriptionColor = Color(0xff6B7280);
    const Color iconColor = Color(0xffD1D5DB);
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.only(left: 32.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: contatinerColor,
                  ),
                  child: Center(child: SvgPicture.asset(imagePath)),
                ),
                SizedBox(width: 16.w),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: textColor,
                      ),
                    ),
                    Text(
                      discription,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: discriptionColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: Icon(Icons.arrow_forward_ios_rounded, color: iconColor),
            ),
          ],
        ),
      ),
    );
  }
}
