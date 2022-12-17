import 'package:app/game/entities/player_routes.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Number of player colors", () {
    expect(PlayerColors.values.length, 5);
  });
  test("Creating player", () {
    Player playerRed = Player(PlayerColors.red);
    expect(playerRed.color, PlayerColors.red);
  });
  test("New player has 12 points", () {
    Player playerRed = Player(PlayerColors.red);
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12);
  });
  test("Adding one route", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Cadiz_Lisbon);
    expect(
      playerRed.sumAllPoints([playerRed].allRoutes()),
      12 + Routes.Cadiz_Lisbon.distance,
    );
  });
  test("Adding multiple routes", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Cadiz_Lisbon);
    playerRed.addRoute(Routes.Cadiz_Madrid);
    playerRed.addRoute(Routes.Madrid_Barcelona);
    playerRed.addRoute(Routes.Pamplona_Barcelona);

    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + 10);
  });
  test("Adding one unfinished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara);
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + -5);
  });
  test("Adding one finished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna);
    playerRed.addRoute(Routes.Smyrna_Ankara);
    playerRed.addTicket(Tickets.Athens_Ankara);
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + 11);
  });
  test("Adding multiple unfinished tickets", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara);
    playerRed.addTicket(Tickets.Berlin_Bucharest);
    playerRed.addTicket(Tickets.Budapest_Sofia);
    playerRed.addTicket(Tickets.Madrid_Zurich);
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + -26);
  });
  test("Adding multiple finished tickets", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara); //5
    playerRed.addRoute(Routes.Athens_Smyrna); //2
    playerRed.addRoute(Routes.Smyrna_Ankara); //4
    playerRed.addTicket(Tickets.Berlin_Bucharest); //8
    playerRed.addRoute(Routes.Berlin_Vienna); //4
    playerRed.addRoute(Routes.Vienna_Budapest); //1
    playerRed.addRoute(Routes.Budapest_Bucharest); //7
    playerRed.addTicket(Tickets.Budapest_Sofia); //5
    playerRed.addRoute(Routes.Sofia_Bucharest); //2
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + 38);
  });
  test("Reset routes", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna);
    playerRed.addRoute(Routes.Smyrna_Ankara);
    playerRed.reset();
    expect(playerRed.sumAllPoints([playerRed].allRoutes()), 12 + 0);
  });
  test("Longest route 1", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna);
    playerRed.addRoute(Routes.Smyrna_Ankara);
    expect(playerRed.getMaxRouteLength(), 5);
  });

  test("Longest route 2", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna); //2
    playerRed.addRoute(Routes.Smyrna_Constantinople); //2
    playerRed.addRoute(Routes.Constantinople_Ankara); //2
    playerRed.addRoute(Routes.Smyrna_Ankara); //3
    playerRed.addRoute(Routes.Palermo_Smyrna); //6

    // Should be unused
    playerRed.addRoute(Routes.Constantinople_Sevastopol);
    playerRed.addRoute(Routes.Ankara_Erzurm);
    expect(playerRed.getMaxRouteLength(), 15);
  });
}

extension _AllPlayerRoutes on Iterable<Player> {
  PlayerRoutes allRoutes() {
    final res = PlayerRoutes();
    // ignore: avoid_function_literals_in_foreach_calls
    forEach((player) => res.addRoutes(player.routes.routes));
    return res;
  }
}
