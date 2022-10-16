import 'package:app/misc/reusable/app_page_route.dart';
import 'package:app/misc/reusable/button.dart';
import 'package:app/misc/reusable/progress_indicator.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'logic/camera_cubit.dart';

class CameraViewRoute extends AppRoute<void> {
  static goTo(BuildContext context) async {
    final cubit = CameraCubit();
    await cubit.init();
    // ignore: use_build_context_synchronously
    await Navigator.of(context).push(CameraViewRoute(cubit));
    await cubit.close();
  }

  CameraViewRoute(CameraCubit cubit)
      : super(
          builder: (context) {
            return BlocProvider.value(
              value: cubit,
              child: const Scaffold(body: CameraViewGuard()),
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
                    Text(s.code, style: TS.big.withColor(C.mid)),
                    Text(s.description, style: TS.larger.withColor(C.black)),
                  ],
                ),
              ),
              noAccess: (_) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                      '''The application cannot function without camera access.
                      \n Please enable camera access and reload the app''',
                      style: TS.standard.withColor(C.mid)),
                ),
              ),
            ));
  }
}

class CameraView extends HookWidget {
  const CameraView({super.key, required this.state});

  final CameraViewStateInitialized state;

  @override
  Widget build(BuildContext context) {
    final cameraController = state.controller;
    return Column(
      children: [
        Expanded(child: CameraPreview(cameraController)),
        const SizedBox(
          height: 160,
          child: Center(
              child: Button(
            child: Text(
              "Dummy button",
              style: TS.standardMinus,
            ),
          )),
        )
      ],
    );
  }
}
