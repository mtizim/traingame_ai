import 'dart:collection';

import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/game/logic/summary.dart';

class MutableGameState {
  MutableGameState.fromFinalized(this._players);
  MutableGameState() {
    _players = HashMap();
  }

  late HashMap<PlayerColors, Player> _players;

  void setPlayerRoutes(PlayerColors playerColor, List<Routes> routes) {
    if (!_players.containsKey(playerColor)) {
      _players[playerColor] = Player(playerColor);
    }
    final player = _players[playerColor]!;
    for (final route in routes) {
      player.addRoute(route);
    }
  }

  void setPlayerStations(PlayerColors playerColor, List<Cities> stations) {
    if (!_players.containsKey(playerColor)) {
      _players[playerColor] = Player(playerColor);
    }
    final player = _players[playerColor]!;
    for (final station in stations) {
      player.addStation(station);
    }
  }

  List<PlayerColors> getPlayerColors() {
    return _players.keys.toList();
  }

  void resetPlayers() {
    _players = HashMap();
  }

  void setPlayerTicket(PlayerColors playerColor, Tickets ticket) {
    if (!_players.containsKey(playerColor)) {
      _players[playerColor] = Player(playerColor);
    }
    final player = _players[playerColor]!;
    player.addTicket(ticket);
  }

  FinalizedGameState finalize() {
    return FinalizedGameState(_players);
  }
}
