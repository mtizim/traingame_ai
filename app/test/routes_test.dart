import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/routes.dart';

void main() {
  test("Number of routes", () {
    expect(Routes.values.length, 90);
  });
  group("Points for different route lengths", () {
    test("Route length 1", ()
    {
      Routes route = Routes.Vienna_Budapest;
      expect(route.distance, 1);
      expect(route.getPoints(), 1);
    });
    test("Route length 2", ()
    {
      Routes route = Routes.Cadiz_Lisbon;
      expect(route.distance, 2);
      expect(route.getPoints(), 2);
    });
    test("Route length 3", ()
    {
      Routes route = Routes.Rostov_Sochi;
      expect(route.distance, 3);
      expect(route.getPoints(), 4);
    });
    test("Route length 4", ()
    {
      Routes route = Routes.Rostov_Sevastopol;
      expect(route.distance, 4);
      expect(route.getPoints(), 7);
    });
    test("Route length 6", ()
    {
      Routes route = Routes.Palermo_Smyrna;
      expect(route.distance, 6);
      expect(route.getPoints(), 15);
    });
    test("Route length 8", ()
    {
      Routes route = Routes.Stockholm_Petrograd;
      expect(route.distance, 8);
      expect(route.getPoints(), 21);
    });
  });

}