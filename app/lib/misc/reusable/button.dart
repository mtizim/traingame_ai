import 'package:app/misc/styleconsts.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, this.color = C.light, this.onTap, this.child});

  final Color color;
  final Widget? child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 8,
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
