import 'dart:collection';

import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/game/logic/summary.dart';
import 'package:app/views/camera/logic/model_communication.dart';

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

  BoardData getBoardData() {
    final players = _players.values;
    final routes = players
        .map(
          (player) => player.routes.routes
              .map((route) => RouteResult(player.color, route)),
        )
        .expand((i) => i)
        .toList();
    final stations = players
        .map(
          (player) => player.stations
              .map((station) => StationResult(player.color, station)),
        )
        .expand((i) => i)
        .toList();
    return BoardData(routes, stations);
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

class BoardData {
  final List<RouteResult> routes;
  final List<StationResult> stations;
  BoardData(this.routes, this.stations);
}
