// ignore_for_file: dead_code

import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class ModelResult {
  final PlayerColors color;
  final Routes route;

  ModelResult(this.color, this.route);
}

// unknown input type yet
Future<List<ModelResult>> detectRoutesFromImage(XFile image) async {
  const platform = MethodChannel("com.flutter.result/result");

  final processing =
      platform.invokeMethod<List<ModelResult>>("detectRoutes", image);
  final artificialDelay = Future.delayed(const Duration(seconds: 1));
  await Future.wait([processing, artificialDelay]);

  // await is a no-op - the future is already finished
  return await processing ?? [];
}
