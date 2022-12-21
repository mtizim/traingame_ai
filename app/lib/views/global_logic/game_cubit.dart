import 'dart:collection';

import 'package:app/game/entities/cities.dart';
import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/routes.dart';
import 'package:app/game/entities/tickets.dart';
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

  void startCounting() {
    _ensureCounting();
  }

  GameCubitStateCounting _ensureCounting() {
    state.mapOrNull(
      finalized: (finalized) => emit(
        GameCubitState.counting(
          gameState: finalized.gameState.toMutable(),
          routesConfirmed: false,
          ticketsKnown: false,
          routesKnown: false,
        ),
      ),
      reset: (_) => forgetAll(),
    );
    return state.mapOrNull(counting: ((c) => c))!;
  }

  void _checkIfAllKnown(GameCubitState state_) {
    state_.mapOrNull(
      counting: (s) {
        if (!(s.routesKnown && s.ticketsKnown && s.routesConfirmed)) return;
        emit(GameCubitState.finalized(gameState: s.gameState.finalize()));
      },
    );
  }

  void confirmRoutes() {
    final countingState = _ensureCounting();
    final nextState = countingState.copyWith(routesConfirmed: true);
    emit(nextState);
    _checkIfAllKnown(nextState);
  }

  void forgetAll() {
    emit(
      GameCubitState.counting(
        gameState: MutableGameState(),
        routesConfirmed: false,
        ticketsKnown: false,
        routesKnown: false,
      ),
    );
  }

  bool consumeModelResults(ModelResult result) {
    final countingState = _ensureCounting();

    if (!result.perspectiveSuccess) {
      return false;
    }

    List<RouteResult> routeResults = result.routesResults;
    List<StationResult> stationResults = result.stationResults;
    final detectedColors = routeResults
        .map((r) => r.color)
        .toSet()
        .union(stationResults.map((s) => s.color).toSet());

    if (detectedColors.isEmpty) {
      return false;
    }

    final playersRouteMap = HashMap<PlayerColors, List<Routes>>.fromIterable(
      detectedColors,
      key: (color) => color,
      value: (color) => [],
    );
    final playersStationMap = HashMap<PlayerColors, List<Cities>>.fromIterable(
      detectedColors,
      key: (color) => color,
      value: (color) => [],
    );

    for (final result in routeResults) {
      playersRouteMap[result.color]!.add(result.route);
    }
    for (final result in stationResults) {
      playersStationMap[result.color]!.add(result.city);
    }

    countingState.gameState.resetPlayers();
    playersRouteMap.forEach((playerColor, routes) {
      countingState.gameState.setPlayerRoutes(playerColor, routes);
    });
    playersStationMap.forEach((playerColor, stations) {
      countingState.gameState.setPlayerStations(playerColor, stations);
    });
    final nextState = countingState.copyWith(routesKnown: true);
    emit(nextState);
    _checkIfAllKnown(nextState);
    return true;
  }

  void consumeTickets(Map<PlayerColors, List<Tickets>> ticketsMap) {
    final countingState = _ensureCounting();
    for (final e in ticketsMap.entries) {
      final playerColor = e.key;
      final tickets = e.value;
      for (final ticket in tickets) {
        countingState.gameState.setPlayerTicket(playerColor, ticket);
      }
    }
    final nextState = countingState.copyWith(ticketsKnown: true);
    emit(nextState);
    _checkIfAllKnown(nextState);
  }
}

@freezed
class GameCubitState with _$GameCubitState {
  const factory GameCubitState.reset() = GameCubitStateReset;
  const factory GameCubitState.counting({
    required MutableGameState gameState,
    required bool ticketsKnown,
    required bool routesConfirmed,
    required bool routesKnown,
  }) = GameCubitStateCounting;
  const factory GameCubitState.finalized({
    required FinalizedGameState gameState,
  }) = GameCubitStateFinalized;
}
