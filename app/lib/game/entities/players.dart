import 'dart:math';

import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/player_routes.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';

enum PlayerColors { green, blue, yellow, black, red }

class Player {
  late final PlayerColors color;
  late PlayerRoutes _routes;
  late List<Cities> _stations;
  late Set<Tickets> _tickets;

  Player(this.color) {
    _routes = PlayerRoutes();
    _tickets = {};
  }

  void reset() {
    _routes = PlayerRoutes();
    _tickets = {};
  }

  int sumAllPoints() {
    return _routes.sumPoints() + _sumTicketsPoints() + _sumStationPoints();
  }

  void addRoute(Routes route) {
    _routes.addRoute(route);
  }

  void addTicket(Tickets ticket) {
    _tickets.add(ticket);
  }

  void addStation(Cities stationLocation) {
    _stations.add(stationLocation);
  }

  int _sumStationPoints() {
    return (3 - _stations.length) * 4;
  }

  int _sumTicketsPoints() {
    final possibleStationRoutes = Routes.values
        .where(
          (route) => _stations
              .any((stationLocation) => route.cities.contains(stationLocation)),
        )
        .toSet();
    possibleStationRoutes.removeAll({_routes.routes});

    final possibleStationRouteCombinations = _stations
        .map(
          (station) => possibleStationRoutes
              .where((route) => route.cities.contains(station))
              .toList(),
        )
        .toList();

    // Finds the max amount of points for all possible combinations of routes
    // picked to be used for the stations
    var maxPossibleSum = 0;
    final stationCombinationLengths =
        possibleStationRouteCombinations.map((r) => r.length).toList();
    final combinations = stationCombinationLengths.reduce((a, b) => a * b);
    for (var i = 0; i < combinations; i++) {
      final indices = [];
      var j = i;
      for (var div in stationCombinationLengths) {
        indices.add(j % div);
        j = j ~/ div;
      }

      final pickedRoutes = List.generate(
        indices.length,
        (k) => possibleStationRouteCombinations[k][indices[k]],
      );

      _routes.routes.addAll(pickedRoutes);

      final sum = __sumTicketsPoints();
      if (sum >= maxPossibleSum) {
        maxPossibleSum = sum;
      }

      _routes.routes.removeAll(pickedRoutes);
    }

    return maxPossibleSum;
  }

  int __sumTicketsPoints() {
    int points = 0;
    for (Tickets ticket in _tickets) {
      points += _ticketFinished(ticket) ? ticket.points : -ticket.points;
    }
    return points;
  }

  bool _ticketFinished(Tickets ticket) {
    final ticketCities = ticket.cities.toList();

    final source = ticketCities.first;
    final destination = ticketCities.last;

    Set<Cities> oldVisited = {};
    Set<Cities> visited = {};
    visited.add(source);

    var oldSize = -1;
    var size = visited.length;
    while (!visited.contains(destination) && oldSize != size) {
      final newCities = visited.difference(oldVisited);
      oldVisited = {...visited};

      visited.addAll(
        newCities.map((city) => _routes.neighbors(city)).expand((e) => e),
      );

      oldSize = size;
      size = visited.length;
    }

    return visited.contains(destination);
  }

  int getMaxRouteLength() {
    // naive algorithm because N is really small
    final routes = _routes.routes;
    final cities = routes.map((route) => route.cities).expand((e) => e).toSet();
    return cities.map((city) => _getMaxRouteLength(city, routes)).reduce(max);
  }

  int _getMaxRouteLength(Cities city, Set<Routes> routes) {
    // naive algorithm because N is really small
    final nextRoutes = routes.where((route) => route.cities.contains(city));

    if (nextRoutes.isEmpty) {
      return 0;
    }

    return nextRoutes
        .map(
          (route) =>
              route.distance +
              _getMaxRouteLength(
                route.cities.difference({city}).first,
                routes.difference({route}),
              ),
        )
        .reduce(max);
  }
}
