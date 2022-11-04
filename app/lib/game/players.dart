import 'package:app/game/graph.dart';
import 'package:app/game/tickets.dart';

enum PlayerColors { green, blue, yellow, black, red }

class Player {
  final PlayerColors color;
  final Graph graph;

  Player(this.color, this.graph);

  int sumAllPoints() {
    return graph.sumAllPoints();
  }

  void addTicket(Tickets ticket) {
    graph.addTicket(ticket);
  }
}
