import 'dart:math';

import 'package:app/misc/reusable/button.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const dotSize = 128.0;
    return Center(
      child: Column(
        children: [
          const Spacer(
            flex: 6,
          ),
          const _Fancy(dotSize: dotSize),
          const SizedBox(height: 64),
          Button(
            onTap: () {
              final cubit = BlocProvider.of<GameCubit>(context);
              cubit.reset();
              cubit.startCounting();
            },
            child: const Text(
              "Zacznij podliczanie punktów",
              style: TS.standard,
            ),
          ),
          const Spacer(
            flex: 6,
          )
        ],
      ),
    );
  }
}

class _Fancy extends StatelessWidget {
  const _Fancy({
    Key? key,
    required this.dotSize,
  }) : super(key: key);

  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: pi / 4,
          child: Container(
            color: C.darkest,
            height: dotSize / 2.5,
            width: dotSize / 2.5,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: dotSize,
                  width: dotSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.lightest,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: dotSize,
                  width: dotSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.light,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: dotSize,
                  width: dotSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.mid,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: dotSize,
                  width: dotSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.dark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
