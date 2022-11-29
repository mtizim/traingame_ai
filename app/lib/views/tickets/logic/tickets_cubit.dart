import 'dart:collection';

import 'package:app/game/entities/players.dart';
import 'package:app/game/entities/tickets.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tickets_cubit.freezed.dart';

class TicketsViewCubit extends Cubit<TicketsViewState> {
  final GameCubit gameCubit;

  // invariant: If this cubit is active, gamecubit.state is GameCubitStateCounting
  TicketsViewCubit(this.gameCubit) : super(const TicketsViewState.initial());

  GameCubitStateCounting get _gameCubitState =>
      gameCubit.state.mapOrNull(counting: ((c) => c))!;

  TicketsViewStateInitialized get _ensureInitialized =>
      state.mapOrNull(initialized: ((c) => c))!;

  void init() async {
    final playerColors = _gameCubitState.gameState.getPlayerColors();
    final tickets = List<Tickets>.from(Tickets.values);
    tickets.sort(((a, b) => a.toString().compareTo(b.toString())));
    emit(
      TicketsViewState.initialized(
        playerColors: playerColors,
        ticketsMap: HashMap.fromIterables(
          playerColors,
          playerColors.map(
            (_) => [],
          ),
        ),
        availableTickets: tickets,
      ),
    );
  }

  void useTicket(Tickets ticket, PlayerColors player) {
    final state = _ensureInitialized;
    final ticketsMap = {...state.ticketsMap};
    ticketsMap.putIfAbsent(player, () => <Tickets>[]);
    ticketsMap[player]!.add(ticket);
    emit(
      state.copyWith(
        ticketsMap: ticketsMap,
        availableTickets:
            state.availableTickets.where((t) => t != ticket).toList(),
      ),
    );
  }

  void freeTicket(Tickets ticket) {
    final state = _ensureInitialized;
    final ticketsMap = {...state.ticketsMap};
    final tickets = [...state.availableTickets];
    tickets.add(ticket);
    tickets.sort(((a, b) => a.toString().compareTo(b.toString())));
    for (final entry in ticketsMap.entries) {
      final ticketList = entry.value;
      if (ticketList.contains(ticket)) {
        ticketList.remove(ticket);
        break;
      }
    }
    emit(
      state.copyWith(
        ticketsMap: ticketsMap,
        availableTickets: tickets,
      ),
    );
  }

  void finalize() {
    final state = _ensureInitialized;
    gameCubit.consumeTickets(state.ticketsMap);
  }
}

@freezed
class TicketsViewState with _$TicketsViewState {
  const factory TicketsViewState.initial() = TicketsViewStateInitial;
  const factory TicketsViewState.initialized({
    required List<PlayerColors> playerColors,
    required Map<PlayerColors, List<Tickets>> ticketsMap,
    required List<Tickets> availableTickets,
  }) = TicketsViewStateInitialized;
}
