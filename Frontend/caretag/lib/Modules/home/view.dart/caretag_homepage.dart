import 'package:caretag/Modules/home/modelview/homePageService.dart';
import 'package:caretag/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CaretagHomepage extends StatefulWidget {
  const CaretagHomepage({super.key});

  @override
  State<CaretagHomepage> createState() => _CaretagHomepageState();
}

String selectedTab = "Home";

class _CaretagHomepageState extends State<CaretagHomepage> {
  @override
  Widget build(BuildContext context) {
    List<Color> gradientColor = [Color(0xff5EACFF), Colors.white];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
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
                    padding: EdgeInsets.only(left: 10.0, top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjduXBTnBVs-4N-tCmYSl1Z8O95GAlK_ZnUg&s",
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
                                  Text(
                                    "Steve harrington",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            SvgPicture.asset("assets/images/home/bell.svg"),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/images/home/heart.svg",
                              ),
                            ),
                          ],
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
                          pageSelectorTile("Home", Colors.blue),
                          pageSelectorTile("Meds", Colors.green),
                          pageSelectorTile("Journey", Colors.orange),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pageSelectorTile(String title, Color color) {
    bool isSelected = title == selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
        });
      },
      child: Container(
        width: 89,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          gradient: LinearGradient(
            colors: isSelected
                ? AppColor.gradientButtonColor
                : [Colors.white, Colors.white],
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
