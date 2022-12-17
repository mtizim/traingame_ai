import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/game/logic/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/cities.dart';

void main() {
  test("Creating empty game", () {
    MutableGameState game = MutableGameState();
    expect(game.getPlayerColors().isEmpty, true);
  });
  test("Adding one player with routes", () {
    MutableGameState game = MutableGameState();
    game.setPlayerRoutes(
      PlayerColors.red,
      [Routes.Sofia_Bucharest, Routes.Budapest_Bucharest],
    );
    expect(game.getPlayerColors(), [PlayerColors.red]);
  });
  test("Adding multiple players with routes", () {
    MutableGameState game = MutableGameState();
    game.setPlayerRoutes(
      PlayerColors.red,
      [Routes.Sofia_Bucharest, Routes.Budapest_Bucharest],
    );
    game.setPlayerRoutes(PlayerColors.blue, [Routes.Athens_Smyrna]);
    expect(
      game.getPlayerColors().toSet(),
      {PlayerColors.red, PlayerColors.blue},
    );
  });
  test("Adding one player with tickets", () {
    MutableGameState game = MutableGameState();
    game.setPlayerTicket(PlayerColors.red, Tickets.Madrid_Zurich);
    expect(game.getPlayerColors(), [PlayerColors.red]);
  });
  test("Adding multiple players with tickets", () {
    MutableGameState game = MutableGameState();
    game.setPlayerTicket(PlayerColors.red, Tickets.Madrid_Zurich);
    game.setPlayerTicket(PlayerColors.blue, Tickets.Athens_Ankara);
    expect(
      game.getPlayerColors().toSet(),
      {PlayerColors.red, PlayerColors.blue},
    );
  });
  test("Reset game", () {
    MutableGameState game = MutableGameState();
    game.setPlayerTicket(PlayerColors.red, Tickets.Madrid_Zurich);
    game.setPlayerTicket(PlayerColors.blue, Tickets.Athens_Ankara);
    game.resetPlayers();
    expect(game.getPlayerColors().isEmpty, true);
  });
  test("Longest routes", () {
    MutableGameState game = MutableGameState();
    game.setPlayerRoutes(PlayerColors.green, [Routes.Sarajevo_Sofia]); //2
    game.setPlayerRoutes(PlayerColors.blue, [Routes.Budapest_Sarajevo]); //3
    game.setPlayerRoutes(PlayerColors.black, [Routes.Vienna_Budapest]); //1
    game.setPlayerStations(PlayerColors.blue, [Cities.Sarajevo]);

    // ignore: prefer_for_elements_to_map_fromiterable
    final playerPointsMap = Map<PlayerColors, int>.fromIterable(
      game.finalize().getSummary(),
      key: (p) => p.color,
      value: (p) => p.maxRouteLength,
    );

    expect(
      [
        PlayerColors.blue,
        PlayerColors.green,
        PlayerColors.black,
        PlayerColors.red,
        PlayerColors.yellow
      ].map((v) => playerPointsMap[v]).toList(),
      [3, 2, 1, null, null],
    );
  });
}
