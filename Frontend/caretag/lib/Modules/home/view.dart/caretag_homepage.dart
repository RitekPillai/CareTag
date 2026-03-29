import 'package:caretag/Modules/pharmacy/view/pharmacy_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/home/modelview/homePageService.dart';
import 'package:caretag/Modules/home/view.dart/sectionPages/careTagPage.dart';
import 'package:caretag/constants/app_color.dart';

class CaretagHomepage extends StatefulWidget {
  final Profilemodel profilemodel;
  final Function(String)? onTabChanged;
  const CaretagHomepage({
    super.key,
    required this.profilemodel,
    this.onTabChanged,
  });

  @override
  State<CaretagHomepage> createState() => _CaretagHomepageState();
}

String selectedTab = "Home";
List<Color> gradientColor = [Color(0xff3B81F6), Colors.white];

class _CaretagHomepageState extends State<CaretagHomepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Profilemodel profilemodel = widget.profilemodel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: 393,
            height: 446,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColor,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(
                            widget.profilemodel.imageUrl,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Homepageservice().getTime()}👋",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  profilemodel.fullName,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: 100,
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: selectedTab == "Home" ? 1.0 : 0.0,
                              child: SvgPicture.asset(
                                "assets/images/home/heart.svg",
                              ),
                            ),

                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut,

                              right: selectedTab == "Home" ? 40 : 0,
                              child: SvgPicture.asset(
                                "assets/images/home/bell.svg",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 296,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      pageSelectorTile(
                        "Home",
                        Colors.blue,
                        AppColor.gradientButtonColor,
                        Color(0xff5EACFF),
                      ),
                      pageSelectorTile("Meds", Colors.green, [
                        Color(0xff00e36f),
                        Color(0xff00bb4c),
                      ], Color(0xff00c469)),
                      pageSelectorTile("Journey", Colors.orange, [
                        Color(0xffffb059),
                        Color(0xffff7100),
                      ], Color(0xffff7a00)),
                    ],
                  ),
                ),
              ),
              if (selectedTab == "Home")
                Expanded(
                  child: Caretagpage(
                    name: profilemodel.fullName,
                    bloodType: profilemodel.bloodGroup,
                  ),
                ),

              if (selectedTab == "Meds") Expanded(child: MedsHomeScreen()),
            ],
          ),
        ],
      ),
    );
  }

  Widget pageSelectorTile(
    String title,
    Color color,
    List<Color> gradientcolor,
    Color backgroundColor,
  ) {
    bool isSelected = title == selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
          gradientColor = [backgroundColor, Colors.white];
        });
        if (widget.onTabChanged != null) {
          widget.onTabChanged!(title);
        }
      },
      child: Container(
        width: 89,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          gradient: LinearGradient(
            colors: isSelected ? gradientcolor : [Colors.white, Colors.white],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}
