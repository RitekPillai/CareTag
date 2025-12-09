import 'package:caretag/Features/auth/view/Intro_page&permisson_page/introPage1.dart';
import 'package:caretag/Features/auth/view/auth_pages/Auth.dart';
import 'package:caretag/Features/auth/view/auth_pages/oauthPage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Intropage1(),
    );
  }
}
