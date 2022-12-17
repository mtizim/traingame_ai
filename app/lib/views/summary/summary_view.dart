import 'package:app/game/logic/summary.dart';
import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/tickets/tickets_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SummaryViewRoute extends AppRoute<void> {
  static goTo(
    BuildContext context,
    FinalizedGameState state, {
    bool replace = false,
  }) async {
    if (replace) {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).pushReplacement(
        SummaryViewRoute(state: state),
      );
    } else {
      // ignore: use_build_context_synchronously
      await Navigator.of(context).push(
        SummaryViewRoute(state: state),
      );
    }
  }

  final FinalizedGameState state;

  SummaryViewRoute({required this.state})
      : super(
          builder: (context) => Scaffold(
            body: SafeArea(
              child: SummaryView(
                state: state,
              ),
            ),
          ),
        );
}

class SummaryView extends HookWidget {
  const SummaryView({super.key, required this.state});

  final FinalizedGameState state;
  @override
  Widget build(BuildContext context) {
    final summary = useMemoized(() {
      final tmp = state.getSummary();
      tmp.sort(((a, b) => b.points.compareTo(a.points)));
      return tmp;
    });
    final first = summary[0];
    late final PlayerPoints? second;
    late final PlayerPoints? third;
    if (summary.length > 1) {
      second = summary[1];
    }
    if (summary.length > 2) {
      third = summary[2];
    }
    final remaining = summary.skip(3).toList();
    return Container(
      color: C.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: C.white,
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Podium(second: second, first: first, third: third),
                if (remaining.isEmpty) const SizedBox(height: 128),
                if (remaining.isNotEmpty)
                  _RemainingPlayerList(remaining: remaining, third: third)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemainingPlayerList extends StatelessWidget {
  const _RemainingPlayerList({
    Key? key,
    required this.remaining,
    required this.third,
  }) : super(key: key);

  final List<PlayerPoints> remaining;
  final PlayerPoints? third;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            ...List<int>.generate(remaining.length, (i) => i)
                .map<Widget>(
                  (i) => _RemainingPlayerListItem(
                    third: third,
                    playerPoints: remaining[i],
                    i: i,
                  ),
                )
                .toList()
                .spacedWith(
                  const SizedBox(
                    height: 16,
                  ),
                )
          ],
        ),
      ),
    );
  }
}

class _RemainingPlayerListItem extends StatelessWidget {
  const _RemainingPlayerListItem({
    Key? key,
    required this.third,
    required this.playerPoints,
    required this.i,
  }) : super(key: key);

  final PlayerPoints? third;
  final PlayerPoints playerPoints;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(
          color: third == null ? C.white : playerColorMap[playerPoints.color]!,
          width: 6,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            "#${(i + 4).toString()}",
            style: TS.larger.bold.withColor(
              playerColorMap[playerPoints.color]!,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 16),
          Icon(
            Icons.person,
            color: playerColorMap[playerPoints.color]!,
            size: 32,
          ),
          const Spacer(),
          Text(
            playerPoints.points.toString(),
            style: TS.larger.bold.withColor(
              playerColorMap[playerPoints.color]!,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _Podium extends StatelessWidget {
  const _Podium({
    Key? key,
    required this.second,
    required this.first,
    required this.third,
  }) : super(key: key);

  final PlayerPoints? second;
  final PlayerPoints first;
  final PlayerPoints? third;

  @override
  Widget build(BuildContext context) {
    final first = this.first;
    final second = this.second;
    final third = this.third;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Spacer(),
        _SecondPlace(second: second),
        const Spacer(),
        _FirstPlace(first: first),
        const Spacer(),
        _ThirdPlace(third: third),
        const Spacer(),
      ],
    );
  }
}

class _ThirdPlace extends StatelessWidget {
  const _ThirdPlace({
    Key? key,
    required this.third,
  }) : super(key: key);

  final PlayerPoints? third;

  @override
  Widget build(BuildContext context) {
    final third = this.third;
    return Column(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color: third == null ? C.white : playerColorMap[third.color]!,
              width: 8,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: (third != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Icon(
                      Icons.person,
                      color: playerColorMap[third.color]!,
                      size: 40,
                    ),
                    const Spacer(),
                    Text(
                      third.points.toString(),
                      style: TS.larger.bold
                          .withColor(playerColorMap[third.color]!),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          "#3",
          style: TS.larger.bold.withColor(
            third != null ? playerColorMap[third.color]! : C.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FirstPlace extends StatelessWidget {
  const _FirstPlace({
    Key? key,
    required this.first,
  }) : super(key: key);

  final PlayerPoints first;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(
              color: playerColorMap[first.color]!,
              width: 8,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Icon(
                Icons.person,
                color: playerColorMap[first.color]!,
                size: 40,
              ),
              const Spacer(),
              Text(
                first.points.toString(),
                style: TS.larger.bold.withColor(playerColorMap[first.color]!),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "#1",
          style: TS.larger.bold.withColor(playerColorMap[first.color]!),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SecondPlace extends StatelessWidget {
  const _SecondPlace({
    Key? key,
    required this.second,
  }) : super(key: key);

  final PlayerPoints? second;

  @override
  Widget build(BuildContext context) {
    final second = this.second;
    return Column(
      children: [
        Container(
          width: 80,
          height: 190,
          decoration: BoxDecoration(
            border: Border.all(
              color: second == null ? C.white : playerColorMap[second.color]!,
              width: 8,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: (second != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Icon(
                      Icons.person,
                      color: playerColorMap[second.color]!,
                      size: 40,
                    ),
                    const Spacer(),
                    Text(
                      second.points.toString(),
                      style: TS.larger.bold
                          .withColor(playerColorMap[second.color]!),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                  ],
                )
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          "#2",
          style: TS.larger.bold.withColor(
            second != null ? playerColorMap[second.color]! : C.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
