import 'package:app/game/entities/routes.dart';

import 'cities.dart';

class PlayerRoutes {
  final Set<Routes> routes = {};

  void addRoute(Routes route) {
    routes.add(route);
  }

  List<Cities> neighbors(Cities city) {
    return routes
        .where((route) => route.cities.contains(city))
        .map((route) => route.cities.difference({city}).first)
        .toList();
  }

  int sumPoints() {
    int points = 0;
    for (Routes route in routes) {
      points += route.getPoints();
    }
    return points;
  }
}
