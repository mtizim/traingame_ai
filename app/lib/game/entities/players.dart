import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/player_routes.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';

enum PlayerColors { green, blue, yellow, black, red }

class Player {
  late final PlayerColors color;
  late PlayerRoutes _routes;
  late Set<Tickets> _tickets;

  Player(this.color) {
    _routes = PlayerRoutes();
    _tickets = {};
  }

  void resetRoutes() {
    _routes = PlayerRoutes();
    _tickets = {};
  }

  int sumAllPoints() {
    return _routes.sumPoints() + _sumTicketsPoints();
  }

  void addRoute(Routes route) {
    _routes.addRoute(route);
  }

  void addTicket(Tickets ticket) {
    _tickets.add(ticket);
  }

  int _sumTicketsPoints() {
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
}
