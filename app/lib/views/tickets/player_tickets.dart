import 'package:app/game/entities/players.dart';
import 'package:app/views/tickets/launch_ticket_picker_button.dart';
import 'package:app/views/tickets/logic/tickets_cubit.dart';
import 'package:app/views/tickets/tickets_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PlayerTickets extends HookWidget {
  const PlayerTickets({
    required this.player,
    required this.state,
    Key? key,
  }) : super(key: key);

  final PlayerColors player;
  final TicketsViewStateInitialized state;
  @override
  Widget build(BuildContext context) {
    final tickets = state.ticketsMap[player]!;

    return SizedBox(
      height: MediaQuery.of(context).size.height - 96 * 2 - 96 * 1.25,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 3,
        children: tickets
                .map<Widget>(
                  (ticket) => TicketCard(ticket: ticket),
                )
                .toList() +
            [
              if (tickets.length < 3 * 4)
                LaunchTicketPickerButton(
                  player: player,
                  cubit: BlocProvider.of<TicketsViewCubit>(context),
                )
            ],
      ),
    );
  }
}
