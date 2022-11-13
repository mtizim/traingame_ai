import 'package:app/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class C {
  static const darkest = Color(0xFF582707);
  static const dark = Color(0xFF972D07);
  static const mid = Color(0xFFFF4B3E);
  static const light = Color(0xFFFFB20F);
  static const lightest = Color(0xFFFFE548);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const playerBlack = black;
  static const playerBlue = Colors.blue;
  static const playerGreen = Colors.green;
  static const playerYellow = Colors.yellow;
  static const playerRed = Colors.red;
}

class TS {
  static const small = TextStyle(
    fontFamily: FontFamily.rubik,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 18 / 12,
  );

  static const standardMinus = TextStyle(
    fontFamily: FontFamily.rubik,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );

  static const standard = TextStyle(
    fontFamily: FontFamily.rubik,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 28 / 20,
  );

  static const larger = TextStyle(
    fontFamily: FontFamily.rubik,
    fontSize: 32,
    fontWeight: FontWeight.w500,
    height: 40 / 32,
  );

  static const big = TextStyle(
    fontFamily: FontFamily.rubik,
    fontSize: 48,
    fontWeight: FontWeight.w500,
    height: 56 / 48,
  );
}

extension Sanity on TextStyle {
  TextStyle withColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle withWeight(FontWeight weight) {
    return copyWith(fontWeight: weight);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }
}

extension SpacedWith on List<Widget> {
  List<Widget> spacedWith(Widget wi) {
    return expand((e) sync* {
      yield e;
      yield wi;
    }).toList().sublist(0, (length * 2 - 1).clamp(0, double.infinity).toInt());
  }
}
