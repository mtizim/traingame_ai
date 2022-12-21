// ignore_for_file: constant_identifier_names

import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/logic/game.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/tickets/tickets_view.dart';
import 'package:flutter/material.dart';

class BoardDisplay extends StatelessWidget {
  const BoardDisplay(
    this.boardData, {
    Key? key,
  }) : super(key: key);

  final BoardData boardData;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _BoardPainter(boardData),
      isComplex: true,
      child: Container(color: Colors.white),
    );
  }
}

class _BoardPainter extends CustomPainter {
  const _BoardPainter(this.boardData);

  final BoardData boardData;

  static const noPlayerRouteWidth = 1.5;
  static const playerRouteWidth = 6.0;
  static const cityRadius = 4.0;
  static const stationRadius = 6.0;
  static const leftRightShift = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final noPlayerPaint = Paint()
      ..color = C.noPlayer
      ..strokeWidth = noPlayerRouteWidth
      ..style = PaintingStyle.fill;

    final width = size.width;

    Routes.values.toList().take(200).forEach((route) {
      drawRoute(route, canvas, noPlayerPaint, width, false);
    });

    boardData.routes.forEach((routeData) {
      final playerPaint = Paint()
        ..color = playerColorMap[routeData.color]!
        ..style = PaintingStyle.fill
        ..strokeWidth = playerRouteWidth
        ..strokeCap = StrokeCap.round;
      drawRoute(routeData.route, canvas, playerPaint, width, true);
    });

    Cities.values.forEach((city) {
      canvas.drawCircle(
        city._locationToOffset(width),
        cityRadius,
        noPlayerPaint,
      );
    });

    boardData.stations.forEach((cityData) {
      final playerPaint = Paint()
        ..color = playerColorMap[cityData.color]!
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        cityData.city._locationToOffset(width),
        stationRadius,
        playerPaint,
      );
    });
  }

  void drawRoute(
    Routes route,
    Canvas canvas,
    Paint paint,
    double width,
    bool reduceAdjacent,
  ) {
    final cities = route.cities.toList();
    var cityOneLocation = cities[0]._locationToOffset(width);
    var cityTwoLocation = cities[1]._locationToOffset(width);

    if (Routes.leftRoutes.contains(route)) {
      final shift = _tangentLineDeltaRightUp(
        cityOneLocation,
        cityTwoLocation,
        leftRightShift,
      );

      cityOneLocation -= shift;
      cityTwoLocation -= shift;
      if (reduceAdjacent) {
        paint.strokeWidth /= 1.5;
      }
      canvas.drawLine(cityOneLocation, cityTwoLocation, paint);
    } else if (Routes.rightRoutes.contains(route)) {
      final shift = _tangentLineDeltaRightUp(
        cityOneLocation,
        cityTwoLocation,
        leftRightShift,
      );

      cityOneLocation += shift;
      cityTwoLocation += shift;
      if (reduceAdjacent) {
        paint.strokeWidth /= 1.5;
      }
      canvas.drawLine(cityOneLocation, cityTwoLocation, paint);
    } else {
      canvas.drawLine(cityOneLocation, cityTwoLocation, paint);
    }
  }

  @override
  bool shouldRepaint(_BoardPainter old) => true;
}

Offset _tangentLineDeltaRightUp(Offset start, Offset end, double scale) {
  final goodOrder = start.dy <= end.dy;
  late final Offset lower;
  late final Offset upper;
  if (goodOrder) {
    lower = start;
    upper = end;
  } else {
    lower = end;
    upper = start;
  }

  final dy = lower.dy - upper.dy;
  final dx = lower.dx - upper.dx;
  if (dy == 0) {
    return Offset(0, -dx.sign);
  }

  final slope = (dy) / (dx);
  final unscaled = Offset(-slope, 1);
  final unscaledLength = unscaled.distance;

  return (unscaled / unscaledLength) * scale;
}

extension GetOffset on Cities {
  Offset _locationToOffset(
    double width,
  ) {
    const max_x = 2900;
    const min_x = 100;
    const max_y = 1900;
    const min_y = 100;

    const x_span = max_x - min_x;
    const y_span = max_y - min_y;

    final x = location[0];
    final y = location[1];
    // rescale to [<0;3>,<0;2>]
    final dx = (x - min_x) / x_span * 3;
    final dy = 2 - (y - min_y) / y_span * 2;
    // rescale to the bounding box pixels
    return Offset(dx, dy) * width / 3;
  }
}
