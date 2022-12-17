import 'dart:collection';
import 'dart:math';

import 'package:app/game/entities/player_routes.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/logic/game.dart';

class FinalizedGameState {
  late HashMap<PlayerColors, Player> _players;
  FinalizedGameState(HashMap<PlayerColors, Player> players) {
    _players = players;
  }

  MutableGameState toMutable() {
    return MutableGameState.fromFinalized(_players);
  }

  PlayerRoutes _getAllPlayerRoutes() {
    final res = PlayerRoutes();
    // ignore: avoid_function_literals_in_foreach_calls
    _players.values.forEach((player) => res.addRoutes(player.routes.routes));
    return res;
  }

  List<PlayerPoints> getSummary() {
    final allPlayerRoutes = _getAllPlayerRoutes();
    final playerPoints =
        _players.values.map((p) => PlayerPoints(p, allPlayerRoutes)).toList();
    final longestRouteLength =
        playerPoints.map((p) => p.maxRouteLength).reduce(max);

    playerPoints
        .where((p) => p.maxRouteLength == longestRouteLength)
        .forEach((p) => p.giveLongestRouteBonus());

    return playerPoints;
  }
}

class PlayerPoints {
  late final PlayerColors _color;
  late int _points;
  late final int _maxRouteLength;

  PlayerPoints(Player player, PlayerRoutes allPlayerRoutes) {
    _points = player.sumAllPoints(allPlayerRoutes);
    _maxRouteLength = player.getMaxRouteLength();
    _color = player.color;
  }

  void giveLongestRouteBonus() {
    _points += 10;
  }

  PlayerColors get color => _color;
  int get points => _points;
  int get maxRouteLength => _maxRouteLength;
}
