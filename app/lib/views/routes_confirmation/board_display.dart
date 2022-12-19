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
      painter: _BoardPainter(boardData),
    );
  }
}

class _BoardPainter extends CustomPainter {
  const _BoardPainter(this.boardData);

  final BoardData boardData;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;

    const noPlayerRouteWidth = 1.5;
    const playerRouteWidth = 6.0;
    const cityRadius = 4.0;
    const stationRadius = 6.0;

    final noPlayerPaint = Paint()
      ..color = C.noPlayer
      ..strokeWidth = noPlayerRouteWidth
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    Routes.values.forEach((route) {
      final cities = route.cities.toList();
      canvas.drawLine(
        cities[0]._locationToOffset(width),
        cities[1]._locationToOffset(width),
        noPlayerPaint,
      );
    });

    boardData.routes.forEach((routeData) {
      final playerPaint = Paint()
        ..color = playerColorMap[routeData.color]!
        ..style = PaintingStyle.fill
        ..strokeWidth = playerRouteWidth
        ..strokeCap = StrokeCap.round;
      final cities = routeData.route.cities.toList();
      canvas.drawLine(
        cities[0]._locationToOffset(width),
        cities[1]._locationToOffset(width),
        playerPaint,
      );
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
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(
        cityData.city._locationToOffset(width),
        stationRadius,
        playerPaint,
      );
    });
  }

  @override
  bool shouldRepaint(_BoardPainter old) => false;
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
