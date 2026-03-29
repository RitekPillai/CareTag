import 'dart:developer';

import 'package:caretag/Modules/%20Diagonostic/model_view/bloc/diagonostic_bloc.dart';
import 'package:caretag/Modules/%20Diagonostic/model_view/repo/diagonostic_repo.dart';
import 'package:caretag/Modules/%20Diagonostic/view/pages/diagonostic_Detail_page.dart';
import 'package:caretag/Modules/Invoice/model_view/bloc/invoice_bloc.dart';
import 'package:caretag/Modules/Invoice/model_view/repo/invoice_repo.dart';
import 'package:caretag/Modules/auth/model_view/service/AuthenticationService.dart';
import 'package:caretag/Modules/doctor_details/model_view/bloc/doctor_detail_bloc.dart';
import 'package:caretag/Modules/doctor_details/model_view/repo/doctor_detail_repo.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/cart_bloc.dart';
import 'package:caretag/Modules/pharmacy/model_view/bloc/pharmacy/parmacy_bloc.dart';
import 'package:caretag/Modules/pharmacy/model_view/repo/cart_repo.dart';
import 'package:caretag/Modules/pharmacy/model_view/repo/pharmacy_repo.dart';
import 'package:caretag/Modules/pharmacy/view/pharmacy_homepage.dart';
import 'package:caretag/Modules/records_module/view/pages/diagonostic_detail.dart';
import 'package:caretag/auth_gate.dart';

import 'package:caretag/constants/messagingService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/card_registration/data/repos/paitent_repo.dart';
import 'package:caretag/Modules/card_registration/model_view/bloc/patient_bloc_bloc.dart';

import 'package:caretag/constants/appsize.dart';
import 'package:caretag/utils/hiveService.dart';
import 'package:caretag/utils/storage_service.dart';

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
    final authenticationService = Authenticationservice();
    final invoiceRepo = InvoiceRepo(auth: authenticationService);
    final doctorDetailRepo = DoctorDetailRepo();
    final diagonosticRepo = DiagonosticRepo();
    final cartRepo = CartRepo();
    final pharmacyRepo = PharmacyRepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(repo, storeageService)..add(OnAppStart()),
        ),
        BlocProvider(create: (context) => PatientBloc(paitentRepo)),
        BlocProvider<InvoiceBloc>(
          create: (context) => InvoiceBloc(invoiceRepo),
        ),

        BlocProvider<DiagonosticBloc>(
          create: (context) => DiagonosticBloc(diagonosticRepo),
        ),

        BlocProvider<DoctorDetailBloc>(
          create: (context) =>
              DoctorDetailBloc(authenticationService, doctorDetailRepo),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(authenticationService, cartRepo),
        ),
        BlocProvider<PharmacyBloc>(
          create: (context) =>
              PharmacyBloc(authenticationService, pharmacyRepo),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),

              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(outline: Colors.transparent),
            ),
            home: Authgate(),
          );
        },
      ),
    );
  }
}
