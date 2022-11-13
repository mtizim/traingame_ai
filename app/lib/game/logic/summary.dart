import 'dart:collection';

import 'package:app/game/entities/players.dart';
import 'package:app/game/logic/game.dart';

class FinalizedGameState {
  late HashMap<PlayerColors, Player> _players;
  FinalizedGameState(HashMap<PlayerColors, Player> players);

  MutableGameState toMutable() {
    return MutableGameState.fromFinalized(_players);
  }

  List<PlayerPoints> getSummary() {
    return _players.values.map((p) => PlayerPoints(p)).toList();
  }
}

class PlayerPoints {
  late final PlayerColors _color;
  late final int _points;

  PlayerPoints(Player player) {
    _color = player.color;
    _points = player.sumAllPoints();
  }

  PlayerColors get color => _color;
  int get points => _points;
}
