import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/cities.dart';

void main() {
  test("Number of cities", () {
    expect(Cities.values.length, 47);
  });
}