import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/player_routes.dart';

void main() {
  test("Player with no routes gets 0 points", () {
    PlayerRoutes playerRoutes = PlayerRoutes();
    expect(playerRoutes.sumPoints(), 0);
  });
  test("Adding a route", () {
    PlayerRoutes playerRoutes = PlayerRoutes();
    Routes route = Routes.Vienna_Budapest;
    playerRoutes.addRoute(route);
    expect(playerRoutes.sumPoints()!=0, true);
  });
  group("Sum points for routes", () {
    test("1. set of routes", () {
      PlayerRoutes playerRoutes = PlayerRoutes();
      List<Routes> routes = [
        Routes.Cadiz_Lisbon,
        Routes.Stockholm_Petrograd,
        Routes.Danzig_Warsaw
      ];
      for (var route in routes) {playerRoutes.addRoute(route);}
      expect(playerRoutes.sumPoints(), 25);
    });
    test("2. set of routes", () {
      PlayerRoutes playerRoutes = PlayerRoutes();
      List<Routes> routes = [
        Routes.Warsaw_Kyiv,
        Routes.Rome_Palermo,
        Routes.Smyrna_Constantinople,
        Routes.Budapest_Bucharest,
        Routes.Ankara_Erzurm
      ];
      for (var route in routes) {playerRoutes.addRoute(route);}
      expect(playerRoutes.sumPoints(), 27);
    });
    test("3. set of routes", () {
      PlayerRoutes playerRoutes = PlayerRoutes();
      List<Routes> routes = [
        Routes.Zagreb_Budapest,
        Routes.Budapest_Bucharest,
        Routes.Bucharest_Constantinople,
        Routes.Constantinople_Ankara,
        Routes.Sevastopol_Erzurm,
        Routes.Sevastopol_Sochi,
        Routes.Kyiv_Bucharest,
        Routes.Rostov_Sevastopol,
      ];
      for (var route in routes) {playerRoutes.addRoute(route);}
      expect(playerRoutes.sumPoints(), 38);
    });
  });
  group("Find cities neighbours", () {
    test("City without routes", () {
      Cities city = Cities.Cadiz;
      PlayerRoutes playerRoutes = PlayerRoutes();
      Set<Cities> returned = playerRoutes.neighbors(city).toSet();
      Set<Cities> expected = {Cities.Lisbon,Cities.Madrid};
      expect(setEquals(returned, expected), false);
    });
    test("City with one route", () {
      Cities city = Cities.Cadiz;
      PlayerRoutes playerRoutes = PlayerRoutes();
      playerRoutes.addRoute(Routes.Cadiz_Lisbon);
      Set<Cities> returned = playerRoutes.neighbors(city).toSet();
      Set<Cities> expected = {Cities.Lisbon};
      expect(setEquals(returned, expected), true);
    });
    test("City with multiple routes", () {
      Cities city = Cities.Paris;
      PlayerRoutes playerRoutes = PlayerRoutes();
      playerRoutes.addRoute(Routes.Paris_Brussels);
      playerRoutes.addRoute(Routes.Paris_Frankfurt);
      playerRoutes.addRoute(Routes.Paris_Zurich);
      playerRoutes.addRoute(Routes.Paris_Marseille);
      Set<Cities> returned = playerRoutes.neighbors(city).toSet();
      Set<Cities> expected = {Cities.Brussels,Cities.Frankfurt,Cities.Zurich,Cities.Marseille};
      expect(setEquals(returned, expected), true);
    });
  });

}