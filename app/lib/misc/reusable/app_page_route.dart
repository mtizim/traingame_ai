import 'package:flutter/material.dart';

class AppRoute<T> extends MaterialPageRoute<T> {
  AppRoute({
    required WidgetBuilder builder,
  }) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
