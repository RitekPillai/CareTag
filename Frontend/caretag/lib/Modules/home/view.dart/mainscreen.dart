import 'package:caretag/Modules/home/view.dart/caretag_homepage.dart';
import 'package:caretag/Modules/home/view.dart/profilepage.dart';
import 'package:caretag/Modules/news/view/newsPage.dart';
import 'package:caretag/Modules/records_module/view/pages/records.dart';
import 'package:caretag/widgets/custom_navigatoion_bar.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
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
          const CaretagHomepage(),
          const Records(),
          const Scaffold(body: Center(child: Text("Care"))),
          const Newspage(),
          const Profilepage(),
        ],
      ),
      bottomNavigationBar: CustomNavigatoionBar(
        selectedIndex: _currentIndex,
        onTap: onTap,
      ),
    );
  }
}
