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
  // TODO actually implement this

  const platform = const MethodChannel("com.flutter.result/result");

  Future<List<Object?>> emptyList() async{
    List<Object?> value;
    value = await platform.invokeMethod("EmptyList");
    return value;
  }

  final processing = Future.delayed(const Duration(seconds: 1));
  final artificialDelay = Future.delayed(const Duration(seconds: 1),emptyList);
  await Future.wait([processing, artificialDelay]);

  return [
    ModelResult(PlayerColors.green, Routes.Amsterdam_Essen),
    ModelResult(PlayerColors.red, Routes.Ankara_Erzurm),
  ];

  // await is a no-op - the future is already finished
  return await processing;
}
