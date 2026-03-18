import 'package:caretag/Modules/MyCare/view/pages/mycare_homepage.dart';
import 'package:caretag/Modules/card_registration/data/model/profileModel.dart';
import 'package:caretag/Modules/home/view.dart/caretag_homepage.dart';
import 'package:caretag/Modules/news/view/newsPage.dart';
import 'package:caretag/Modules/profile/view/pages/new_profile_page.dart';
import 'package:caretag/Modules/records_module/view/pages/records.dart';
import 'package:caretag/widgets/custom_navigatoion_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final Profilemodel profilemodel;
  const MainScreen({super.key, required this.profilemodel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CaretagHomepage(profilemodel: widget.profilemodel),
          const Records(),
          const MycarePage(),
          const NewsPage(),
          ProfilePage(profilemodel: widget.profilemodel),
        ],
      ),
      bottomNavigationBar: CustomNavigatoionBar(
        selectedIndex: _currentIndex,
        onTap: onTap,
      ),
    );
  }
}
