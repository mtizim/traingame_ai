// ignore_for_file: dead_code

import 'dart:collection';
import 'dart:convert';
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
  final bytes = await image.readAsBytes();
  final processing =
      platform.invokeMethod("detectRoutes",<String, Uint8List>{"bytes":bytes});
  final artificialDelay = Future.delayed(const Duration(seconds: 1));
  await Future.wait([processing, artificialDelay]);

  //artificial json
  var jsonList = await processing;
  var result = <ModelResult>[];
  for(String json in jsonList){
    result.add(modelFromJson(jsonDecode(json)) as ModelResult);
  }

  // await is a no-op - the future is already finished
  return await result ?? [];
}

ModelResult? modelFromJson(LinkedHashMap<String,dynamic> json){
  for(Routes i in Routes.values){
    List<String> cities = i.citiesNames;
    if (cities.toSet().containsAll(json['cities'].toSet())){
      for(PlayerColors j in PlayerColors.values) {
        if(j.name==json['PlayerColour']) {
          return ModelResult(j, i);
        }
      }
    }
  }
}
