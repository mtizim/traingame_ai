import 'dart:collection';

import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/logic/game.dart';
import 'package:app/game/logic/summary.dart';
import 'package:app/views/camera/logic/model_communication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_cubit.freezed.dart';

class GameCubit extends Cubit<GameCubitState> {
  GameCubit() : super(const GameCubitState.reset());

  void reset() {
    emit(const GameCubitState.reset());
  }

  GameCubitStateCounting _ensureCounting() {
    state.mapOrNull(
      finalized: (finalized) => emit(
        GameCubitState.counting(
          gameState: finalized.gameState.toMutable(),
          ticketsKnown: false,
          routesKnown: false,
        ),
      ),
      reset: (_) => emit(
        GameCubitState.counting(
          gameState: MutableGameState(),
          ticketsKnown: false,
          routesKnown: false,
        ),
      ),
    );
    return state.mapOrNull(counting: ((c) => c))!;
  }

  void _checkIfAllKnown() {
    state.mapOrNull(
      counting: (s) {
        if (!(s.routesKnown && s.ticketsKnown)) return;
        emit(GameCubitState.finalized(gameState: s.gameState.finalize()));
      },
    );
  }

  void consumeModelResults(List<ModelResult> results) {
    final countingState = _ensureCounting();
    final detectedColors = results.map((r) => r.color).toSet();
    final playersMap = HashMap<PlayerColors, List<Routes>>.fromIterable(
      detectedColors,
      key: (color) => color,
      value: (color) => [],
    );

    for (final result in results) {
      playersMap[result.color]!.add(result.route);
    }
    playersMap.forEach((playerColor, routes) {
      countingState.gameState.setPlayerRoutes(playerColor, routes);
    });
    emit(countingState.copyWith(routesKnown: true));
    _checkIfAllKnown();
  }
}

@freezed
class GameCubitState with _$GameCubitState {
  const factory GameCubitState.reset() = GameCubitStateReset;
  const factory GameCubitState.counting({
    required MutableGameState gameState,
    required bool ticketsKnown,
    required bool routesKnown,
  }) = GameCubitStateCounting;
  const factory GameCubitState.finalized({
    required FinalizedGameState gameState,
  }) = GameCubitStateFinalized;
}
