import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/tickets/logic/tickets_cubit.dart';
import 'package:app/views/tickets/ticket_picker.dart';
import 'package:flutter/material.dart';

class LaunchTicketPickerButton extends StatelessWidget {
  const LaunchTicketPickerButton({
    required this.player,
    required this.cubit,
    Key? key,
  }) : super(key: key);
  final PlayerColors player;
  final TicketsViewCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      color: C.dark,
      child: InkWell(
        onTap: () async {
          final ticket = await showModalBottomSheet<Tickets?>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            builder: (context) => TicketPicker(
              availableTickets: cubit.state
                  .mapOrNull(initialized: (v) => v.availableTickets)!,
            ),
          );
          if (ticket == null) {
            return;
          }
          cubit.useTicket(ticket, player);
        },
        splashColor: C.dark,
        borderRadius: BorderRadius.circular(8),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(
            Icons.add_rounded,
            size: 60,
            color: C.lightestest,
          ),
        ),
      ),
    );
  }
}
