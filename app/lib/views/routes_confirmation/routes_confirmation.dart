import 'package:app/game/consts.dart';
import 'package:app/game/logic/game.dart';
import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/misc/reusable/button.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app/views/routes_confirmation/board_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesConfirmRoute extends AppRoute<void> {
  static goTo(
    BuildContext context,
    BoardData boardData, {
    bool replace = false,
  }) async {
    final gameCubit = BlocProvider.of<GameCubit>(context);

    if (replace) {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacement(
        RoutesConfirmRoute(gameCubit, boardData: boardData),
      );
    } else {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).push(
        RoutesConfirmRoute(gameCubit, boardData: boardData),
      );
    }
  }

  final BoardData boardData;

  RoutesConfirmRoute(GameCubit gameCubit, {required this.boardData})
      : super(
          builder: (context) => BlocProvider.value(
            value: gameCubit,
            child: Scaffold(
              body: SafeArea(
                child: RoutesConfirmView(boardData: boardData),
              ),
            ),
          ),
        );
}

class RoutesConfirmView extends StatelessWidget {
  const RoutesConfirmView({super.key, required this.boardData});

  final BoardData boardData;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(flex: 4),
            const Text(
              "Wykryte trasy",
              style: TS.larger,
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 1),
            Material(
              color: C.white,
              elevation: 16,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: LayoutBuilder(
                  builder: (context, constraints) => SizedBox(
                    width: constraints.maxWidth,
                    height: GameConsts.boardAspectRatio * constraints.maxWidth,
                    child: BoardDisplay(boardData),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            const _Buttons(),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Button(
            color: C.mid,
            onTap: () => BlocProvider.of<GameCubit>(context).confirmRoutes(),
            child: Row(
              children: const [
                Spacer(),
                Text(
                  "Potwierdź i idź dalej",
                  style: TS.standard,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward),
                Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Button(
            onTap: () => BlocProvider.of<GameCubit>(context).forgetAll(),
            child: Row(
              children: const [
                Spacer(),
                Text(
                  "Zrób zdjęcie ponownie",
                  style: TS.standard,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 4),
                Icon(Icons.replay),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
