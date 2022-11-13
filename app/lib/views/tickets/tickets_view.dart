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

  TicketsViewRoute(TicketsViewCubit cameraCubit)
      : super(
          builder: (context) {
            return BlocProvider.value(
              value: cameraCubit,
              child: const Scaffold(body: SafeArea(child: _TicketsViewGuard())),
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
    print(state.playerColors);
    return CustomScrollView(
      slivers: List<int>.generate(state.playerColors.length, (i) => i)
              .map(
                (index) {
                  final playerColor = state.playerColors[index];
                  return [
                    SliverAppBar(
                      backgroundColor: _playerColorMap[playerColor]!,
                      floating: true,
                      pinned: true,
                      expandedHeight: 96,
                      collapsedHeight: 32 * (index + 1),
                      toolbarHeight: 0,
                    ),
                    SliverToBoxAdapter(
                      child: PlayerTickets(player: playerColor),
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

const _playerColorMap = {
  PlayerColors.black: C.playerBlack,
  PlayerColors.red: C.playerRed,
  PlayerColors.blue: C.playerBlue,
  PlayerColors.green: C.playerGreen,
  PlayerColors.yellow: C.playerYellow,
};
