import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayerTickets extends HookWidget {
  const PlayerTickets({
    required this.player,
    Key? key,
  }) : super(key: key);

  final PlayerColors player;
  @override
  Widget build(BuildContext context) {
    final tickets = useState<List<Tickets>>([]);
    return SizedBox(
      height: MediaQuery.of(context).size.height - 96 * 2 - 96,
      child: Column(
        children: [
          Container(
            color: C.white,
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    )
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: C.dark,
                      height: 96,
                      width: 128,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
