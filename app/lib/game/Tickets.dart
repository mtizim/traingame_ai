import 'Cities.dart';

enum Tickets {
  //TEST TICKETS
  LisbonPamplona({Cities.Lisbon, Cities.Rostov}, 50),
  AthinaAncora({Cities.Athens, Cities.Ankara}, 5);

  final Set<Cities> cities;
  final int points;
  const Tickets(this.cities, this.points);

  Set<Cities> getCities() {
    return this.cities;
  }

  int getPoints() {
    return this.points;
  }
}
