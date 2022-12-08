import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Number of player colors", () {
    expect(PlayerColors.values.length,5);
  });
  test("Creating player", () {
    Player playerRed = Player(PlayerColors.red);
    expect(playerRed.color,PlayerColors.red);
  });
  test("New player has 0 points", () {
    Player playerRed = Player(PlayerColors.red);
    expect(playerRed.sumAllPoints(),0);
  });
  test("Adding one route", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Cadiz_Lisbon);
    expect(playerRed.sumAllPoints(),2);
  });
  test("Adding multiple routes", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Cadiz_Lisbon);
    playerRed.addRoute(Routes.Cadiz_Madrid);
    playerRed.addRoute(Routes.Madrid_Barcelona);
    playerRed.addRoute(Routes.Pamplona_Barcelona);
    expect(playerRed.sumAllPoints(),10);
  });
  test("Adding one unfinished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara);
    expect(playerRed.sumAllPoints(),-5);
  });
  test("Adding one finished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna);
    playerRed.addRoute(Routes.Smyrna_Ankara);
    playerRed.addTicket(Tickets.Athens_Ankara);
    expect(playerRed.sumAllPoints(),11);
  });
  test("Adding multiple unfinished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara);
    playerRed.addTicket(Tickets.Berlin_Bucharest);
    playerRed.addTicket(Tickets.Budapest_Sofia);
    playerRed.addTicket(Tickets.Madrid_Zurich);
    expect(playerRed.sumAllPoints(),-26);
  });
  test("Adding multiple finished ticket", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addTicket(Tickets.Athens_Ankara);//5
    playerRed.addRoute(Routes.Athens_Smyrna);//2
    playerRed.addRoute(Routes.Smyrna_Ankara);//4
    playerRed.addTicket(Tickets.Berlin_Bucharest);//8
    playerRed.addRoute(Routes.Berlin_Vienna);//4
    playerRed.addRoute(Routes.Vienna_Budapest);//1
    playerRed.addRoute(Routes.Budapest_Bucharest);//7
    playerRed.addTicket(Tickets.Budapest_Sofia);//5
    playerRed.addRoute(Routes.Sofia_Bucharest);//2
    expect(playerRed.sumAllPoints(),38);
  });
  test("Reset routes", () {
    Player playerRed = Player(PlayerColors.red);
    playerRed.addRoute(Routes.Athens_Smyrna);
    playerRed.addRoute(Routes.Smyrna_Ankara);
    playerRed.resetRoutes();
    expect(playerRed.sumAllPoints(),0);
  });
}