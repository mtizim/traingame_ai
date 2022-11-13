import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app/views/tickets/logic/tickets_cubit.dart';
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
        print("bebug" + state.toString());
        return state.map(
          initial: (_) => Container(
            color: Colors.black,
          ),
          initialized: (s) => TicketsView(state: s),
        );
      },
    );
  }
}

class TicketsView extends StatelessWidget {
  const TicketsView({
    required TicketsViewStateInitialized state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Tickets view TODO"));
  }
}
