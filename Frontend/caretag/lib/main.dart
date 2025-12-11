import 'package:caretag/Modules/auth/data/repo/auth_repo.dart';
import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:caretag/Modules/auth/model_view/service/storageService.dart';
import 'package:caretag/Modules/auth/view/auth_pages/auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = AuthRepo();
    final storeageService = Storageservice();
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(repo, storeageService),
        child: const AuthPage(login: true),
      ),
    );
  }
}
