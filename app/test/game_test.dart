import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/game/logic/game.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
