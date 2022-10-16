import 'package:flutter/material.dart';

class CSizedBox extends StatelessWidget {
  const CSizedBox({
    super.key,
    this.width,
    this.height,
    required this.decoration,
  });

  final double? width;
  final double? height;
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: decoration,
      ),
    );
  }
}
