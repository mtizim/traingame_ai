import 'package:flutter_test/flutter_test.dart';
import 'package:app/game/entities/tickets.dart';

void main() {
  test("Number of tickets", () {
    expect(Tickets.values.length, 46);
  });
}