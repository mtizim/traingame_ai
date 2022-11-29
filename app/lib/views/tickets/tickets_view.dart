import 'package:app/game/entities/players.dart';
import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app/views/tickets/logic/tickets_cubit.dart';
import 'package:app/views/tickets/player_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketsViewRoute extends AppRoute<void> {
  static goTo(BuildContext context, {bool replace = false}) async {
    final gameCubit = BlocProvider.of<GameCubit>(context);
    final ticketsViewCubit = TicketsViewCubit(gameCubit);
    ticketsViewCubit.init();
    if (replace) {
      await Navigator.of(context).pushReplacement(
        TicketsViewRoute(ticketsViewCubit),
      );
    } else {
      await Navigator.of(context).push(
        TicketsViewRoute(ticketsViewCubit),
      );
    }
  }

  TicketsViewRoute(TicketsViewCubit ticketsViewCubit)
      : super(
          builder: (context) {
            return BlocProvider.value(
              value: ticketsViewCubit,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: const Text(
                    "Uzupełnij bilety graczy",
                    style: TS.standard,
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  elevation: 16,
                  onPressed: () => ticketsViewCubit.finalize(),
                  icon: Text(
                    "Podlicz punkty",
                    style: TS.standard.bold,
                  ),
                  label: const Icon(
                    Icons.arrow_forward,
                    size: 32,
                  ),
                  backgroundColor: C.mid,
                ),
                body: const SafeArea(child: _TicketsViewGuard()),
              ),
            );
          },
        );
}

class _TicketsViewGuard extends StatelessWidget {
  const _TicketsViewGuard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketsViewCubit, TicketsViewState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox(),
          initialized: (s) => TicketsView(state: s),
        );
      },
    );
  }
}

class TicketsView extends StatelessWidget {
  const TicketsView({
    required this.state,
    Key? key,
  }) : super(key: key);

  final TicketsViewStateInitialized state;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: List<int>.generate(state.playerColors.length, (i) => i)
              .map(
                (index) {
                  final playerColor = state.playerColors[index];
                  return [
                    SliverAppBar(
                      backgroundColor: playerColorMap[playerColor]!,
                      pinned: true,
                      expandedHeight: 64,
                      collapsedHeight: 32,
                      toolbarHeight: 0,
                    ),
                    SliverToBoxAdapter(
                      child: PlayerTickets(state: state, player: playerColor),
                    )
                  ];
                },
              )
              .expand((e) => e)
              .toList() +
          [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 128 + 96,
              ),
            )
          ],
    );
  }
}

const playerColorMap = {
  PlayerColors.black: C.playerBlack,
  PlayerColors.red: C.playerRed,
  PlayerColors.blue: C.playerBlue,
  PlayerColors.green: C.playerGreen,
  PlayerColors.yellow: C.playerYellow,
};
