import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/misc/reusable/button.dart';
import 'package:app/misc/reusable/progress_indicator.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/camera/camera_view.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/camera_cubit.dart';

class CameraViewRoute extends AppRoute<void> {
  static goTo(BuildContext context) async {
    final gameCubit = BlocProvider.of<GameCubit>(context);
    final cameraCubit = CameraCubit(gameCubit);
    await cameraCubit.init();
    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(
      CameraViewRoute(cameraCubit),
    );
    await cameraCubit.close();
  }

  CameraViewRoute(CameraCubit cameraCubit)
      : super(
          builder: (context) {
            return BlocProvider.value(
              value: cameraCubit,
              child: const Scaffold(body: SafeArea(child: CameraViewGuard())),
            );
          },
        );
}

class CameraViewGuard extends StatelessWidget {
  const CameraViewGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraCubit, CameraViewState>(
      builder: (context, state) => state.map(
        initial: (_) => const Center(
          child: AppProgressIndicator(),
        ),
        initialized: (s) => CameraView(state: s),
        error: (s) => Center(
          child: Column(
            children: [
              Text(s.code, style: TS.standard.withColor(C.mid)),
              Text(s.description, style: TS.standardMinus.withColor(C.black)),
            ],
          ),
        ),
        noAccess: (_) => const _NoAccessView(),
      ),
    );
  }
}

class _NoAccessView extends StatelessWidget {
  const _NoAccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const Spacer(
              flex: 3,
            ),
            Row(
              children: [
                const Icon(Icons.priority_high, size: 64),
                Expanded(
                  child: Text(
                    '''Aplikacja nie może działać bez dostępu do aparatu.
                            \nWłącz dostęp do aparatu i uruchom aplikację ponownie''',
                    style: TS.standardMinus.withColor(C.mid),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),
            const Spacer(flex: 1),
            Button(
              onTap: () async {
                await AppSettings.openAppSettings();
                // ignore: use_build_context_synchronously
                BlocProvider.of<CameraCubit>(context).init();
              },
              child: const Text(
                "Otwórz ustawienia",
                style: TS.standard,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
