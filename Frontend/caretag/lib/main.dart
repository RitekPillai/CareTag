import 'dart:developer';

import 'package:caretag/Modules/home/view.dart/homePage.dart';
import 'package:caretag/Modules/home/view.dart/mainscreen.dart';
import 'package:caretag/constants/messagingService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:caretag/AuthGate.dart';
import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';
import 'package:caretag/Modules/records_module/view/pages/records.dart';
import 'package:caretag/constants/appsize.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:caretag/utils/storageService.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hive = Hiveservice();
  await hive.setupHive();

  final healthBox = Hive.box('health_vault');
  String? watchId = healthBox.get("watchId");
  log("WatchId: $watchId");
  if (watchId != null) {
    await hive.initializeService();
  }

  // ...

  await Firebase.initializeApp();

  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SizeConfig currentAppSize = SizeConfig();
    currentAppSize.init(context);

    final repo = AuthRepo();
    final storeageService = Storageservice();
    final paitentRepo = PaitientRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(repo, storeageService)..add(OnAppStart()),
        ),
        BlocProvider(create: (context) => PatientBloc(paitentRepo)),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: Homepage(),
          );
        },
      ),
    );
  }
}
