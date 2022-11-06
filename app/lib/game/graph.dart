import 'cities.dart';
import 'routes.dart';
import 'tickets.dart';

class Graph {
  final Set<Routes> _routes = {};
  final Set<Tickets> _tickets = {};

  void addRoute(Routes route) {
    _routes.add(route);
  }

  void addTicket(Tickets ticket) {
    _tickets.add(ticket);
  }

  List<Cities> neighbors(Cities city) {
    return _routes
        .where((route) => route.cities.contains(city))
        .map((route) => route.cities.difference({city}).first)
        .toList();
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
        newCities.map((city) => neighbors(city)).expand((e) => e),
      );

      oldSize = size;
      size = visited.length;
    }

    return visited.contains(destination);
  }

  int _sumTicketsPoint() {
    int points = 0;
    for (Tickets ticket in _tickets) {
      points += _ticketFinished(ticket) ? ticket.points : -ticket.points;
    }
    return points;
  }

  int _sumRoutesPoints() {
    int points = 0;
    for (Routes route in _routes) {
      points += route.getPoints();
    }
    return points;
  }

  int sumAllPoints() {
    return _sumTicketsPoint() + _sumRoutesPoints();
  }
}
