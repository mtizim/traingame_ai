import 'package:app/game/consts.dart';
import 'package:app/misc/reusable/colored_sized_box.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class CameraOverlay extends StatelessWidget {
  const CameraOverlay({super.key, required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Center(
        child: AspectRatio(
          aspectRatio: GameConsts.boardAspectRatio,
          child: _CameraOverlayGraphics(),
        ),
      ),
    );
  }
}

class _CameraOverlayGraphics extends StatelessWidget {
  const _CameraOverlayGraphics();

  @override
  Widget build(BuildContext context) {
    const width = 4.0;
    const length = 48.0;
    const radius = 8.0;
    const color = C.lightest;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _TopLeft(
              length: length,
              width: width,
              color: color,
              radius: radius,
            ),
            Spacer(),
            _TopRight(
              length: length,
              width: width,
              color: color,
              radius: radius,
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            _BottomLeft(
              length: length,
              width: width,
              color: color,
              radius: radius,
            ),
            Spacer(),
            _BottomRight(
              length: length,
              width: width,
              color: color,
              radius: radius,
            ),
          ],
        ),
      ],
    );
  }
}

class _TopLeft extends StatelessWidget {
  const _TopLeft({
    Key? key,
    required this.length,
    required this.width,
    required this.color,
    required this.radius,
  }) : super(key: key);

  final double length;
  final double width;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length,
      width: length,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CSizedBox(
              height: width,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: width,
            right: 0,
            child: CSizedBox(
              height: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Positioned(
            top: width,
            left: 0,
            bottom: 0,
            child: CSizedBox(
              width: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TopRight extends StatelessWidget {
  const _TopRight({
    Key? key,
    required this.length,
    required this.width,
    required this.color,
    required this.radius,
  }) : super(key: key);

  final double length;
  final double width;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length,
      width: length,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: CSizedBox(
              height: width,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radius),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: width,
            left: 0,
            child: CSizedBox(
              height: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Positioned(
            top: width,
            right: 0,
            bottom: 0,
            child: CSizedBox(
              width: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomLeft extends StatelessWidget {
  const _BottomLeft({
    Key? key,
    required this.length,
    required this.width,
    required this.color,
    required this.radius,
  }) : super(key: key);

  final double length;
  final double width;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length,
      width: length,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: CSizedBox(
              height: width,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width,
            right: 0,
            child: CSizedBox(
              height: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Positioned(
            bottom: width,
            left: 0,
            top: 0,
            child: CSizedBox(
              width: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BottomRight extends StatelessWidget {
  const _BottomRight({
    Key? key,
    required this.length,
    required this.width,
    required this.color,
    required this.radius,
  }) : super(key: key);

  final double length;
  final double width;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length,
      width: length,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: CSizedBox(
              height: width,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(radius),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: width,
            left: 0,
            child: CSizedBox(
              height: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          ),
          Positioned(
            bottom: width,
            right: 0,
            top: 0,
            child: CSizedBox(
              width: width,
              decoration: BoxDecoration(
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
