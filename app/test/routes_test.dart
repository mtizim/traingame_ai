import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/routes.dart';

void main() {
  test("Size of routes", () {
    expect(Routes.values.length, 87);
  });

}