import 'dart:collection';
import 'dart:math';

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

  List<PlayerPoints> getSummary() {
    final playerPoints = _players.values.map((p) => PlayerPoints(p)).toList();
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
  late final int _points;
  late final int _maxRouteLength;

  PlayerPoints(Player player) {
    _points = player.sumAllPoints();
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
