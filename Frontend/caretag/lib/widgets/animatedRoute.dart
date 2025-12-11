import 'package:caretag/Modules/auth/model_view/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route customRoute(Widget page, AuthBloc authblock) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BlocProvider.value(value: authblock, child: page),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
