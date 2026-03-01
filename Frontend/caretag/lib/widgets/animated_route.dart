import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Route customRoute<T extends StateStreamableSource<Object?>>(
  Widget page,
  T blocInstance,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BlocProvider<T>.value(value: blocInstance, child: page),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
