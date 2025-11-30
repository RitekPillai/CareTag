import 'package:caretag/Features/auth/view/Intro_page&permisson_page/introPage1.dart';
import 'package:caretag/Features/auth/view/auth_pages/oauthPage.dart';
import 'package:caretag/Features/auth/view/auth_pages/signup.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(
  DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Signup(),
    );
  }
}
