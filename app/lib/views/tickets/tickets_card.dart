import 'package:app/game/entities/tickets.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/tickets/logic/tickets_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    Key? key,
    required this.ticket,
  }) : super(key: key);

  final Tickets ticket;

  @override
  Widget build(BuildContext context) {
    final cities = ticket.cities.toList();
    final citiesSorted = cities[0].name.length <= cities[1].name.length
        ? cities
        : cities.reversed.toList();
    return Material(
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      color: C.light,
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            child: Icon(
              Icons.confirmation_num_outlined,
              size: 24,
              color: C.white,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () =>
                  BlocProvider.of<TicketsViewCubit>(context).freeTicket(ticket),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.cancel,
                  size: 20,
                  color: C.dark,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    citiesSorted[0].name,
                    style: TS.small.bold,
                  ),
                  Text(
                    "|",
                    style: TS.small.bold,
                  ),
                  Text(
                    citiesSorted[1].name,
                    style: TS.small.bold,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
