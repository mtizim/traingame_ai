import 'cities.dart';

// ignore_for_file: constant_identifier_names

enum Tickets {
  //TEST TICKETS
  Lisbon_Rostov({Cities.Lisbon, Cities.Rostov}, 50),
  Athina_Ancora({Cities.Athens, Cities.Ankara}, 5);

  final Set<Cities> _cities;
  final int _points;
  const Tickets(this._cities, this._points);

  Set<Cities> get cities {
    return _cities;
  }

  int get points {
    return _points;
  }
}
