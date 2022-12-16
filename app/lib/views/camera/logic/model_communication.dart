// ignore_for_file: dead_code

import 'dart:collection';
import 'dart:convert';
import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

class RouteResult {
  final PlayerColors color;
  final Routes route;

  RouteResult(this.color, this.route);
}

class StationResult {
  final PlayerColors color;
  final Cities city;

  StationResult(this.color, this.city);
}

class Result {
  final bool perspective;
  final List<RouteResult> routesResults;
  final List<StationResult> stationsResults;
  Result(this.perspective, this.routesResults, this.stationsResults);
}

// unknown input type yet
Future<Result> detectRoutesFromImage(XFile image) async {
  const platform = MethodChannel("com.flutter.result/result");
  final bytes = await image.readAsBytes();
  final processing = platform
      .invokeMethod("detectRoutes", <String, Uint8List>{"bytes": bytes});
  final artificialDelay = Future.delayed(const Duration(seconds: 1));
  await Future.wait([processing, artificialDelay]);
  // await is a no-op - the future is already finished
  final jsonString = await processing;
  final json = jsonDecode(jsonString);
  final routesResult = <RouteResult?>[];
  final stationsResult = <StationResult?>[];
  if(json['perspective']==false){
    return  Result(false, routesResult.whereType<RouteResult>().toList(), stationsResult.whereType<StationResult>().toList());
  }
  for (LinkedHashMap<String, dynamic> route in json['routes']) {
    routesResult.add(routeFromJson(route));
  }
  for (LinkedHashMap<String, dynamic> route in json['stations']) {
    stationsResult.add(stationFromJson(route));
  }
  Result result = Result(true, routesResult.whereType<RouteResult>().toList(), stationsResult.whereType<StationResult>().toList());
  return result;
}

RouteResult? routeFromJson(LinkedHashMap<String, dynamic> json) {
  for (Routes i in Routes.values) {
    List<String> cities = i.citiesNames;
    if (cities.toSet().containsAll(json['cities'].toSet())) {
      for (PlayerColors j in PlayerColors.values) {
        if (j.name == json['PlayerColour']) {
          return RouteResult(j, i);
        }
      }
    }
  }
  return null;
}

StationResult? stationFromJson(LinkedHashMap<String, dynamic> json) {
  for (Cities i in Cities.values) {
    if (i.name==json["city"].toString()) {
      for (PlayerColors j in PlayerColors.values) {
        if (j.name == json['PlayerColour']) {
          return StationResult(j, i);
        }
      }
    }
  }
  return null;
}
