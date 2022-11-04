import 'dart:math';

import 'Players.dart';
import 'Cities.dart';
import 'Routes.dart';
import 'Tickets.dart';

class Graph {
  final Set<Routes> routes;
  final Set<Tickets> tickets;
  final Players player;

  Graph(this.routes, this.tickets, this.player);

  void addRoute(Routes route) {
    routes.add(route);
  }

  bool TicketFinished(Tickets ticket) {
    Set<Cities> ticket_cities = ticket.getCities();
    Cities source = ticket_cities.first;
    Cities destination = ticket_cities.difference({source}).first;

    Set<Cities> source_connection = {};
    Set<Cities> destination_connection = {};
    Set<Routes> source_check = {...this.routes};
    Set<Routes> destination_check = {...this.routes};
    Set<Routes> source_remove = {};
    Set<Routes> destination_remove = {};
    int i = 0;
    source_connection.add(source);
    destination_connection.add(destination);
    int connection_set_length = 0;

    while (min(source_connection.length, destination_connection.length) >
        connection_set_length) {
      connection_set_length =
          min(source_connection.length, destination_connection.length);
      for (Routes route in source_check.intersection(destination_check)) {
        i++;
        Set<Cities> tmp_cities = route.getCities();
        if (source_connection.intersection(tmp_cities).length != 0) {
          source_connection.addAll(tmp_cities);
          source_remove.add(route);
        }
        if (destination_connection.intersection(tmp_cities).length != 0) {
          destination_connection.addAll(tmp_cities);
          destination_remove.add(route);
        }
        print('src:' + source_connection.toString());
        print('dst:' + destination_connection.toString());
        print(route.cities);
        print('-----------------------');
        if (source_connection.intersection(destination_connection).length !=
            0) {
          print(i);
          return true;
        }
      }
      source_check.removeAll(source_remove);
      destination_check.removeAll(destination_remove);
    }
    print(i);
    return false;
  }

  int sumTicketsPoint() {
    int points = 0;
    for (Tickets ticket in this.tickets) {
      points +=
          TicketFinished(ticket) ? ticket.getPoints() : -ticket.getPoints();
    }
    return points;
  }

  int sumRoutesPoints() {
    int points = 0;
    for (Routes route in this.routes) {
      points += route.getPoints();
    }
    return points;
  }

  int sumAllPoints() {
    return sumTicketsPoint() + sumRoutesPoints();
  }
}
