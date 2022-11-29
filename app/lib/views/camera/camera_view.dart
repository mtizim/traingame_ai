import 'package:app/misc/reusable/button.dart';
import 'package:app/misc/reusable/progress_indicator.dart';
import 'package:app/misc/styleconsts.dart';
import 'package:app/views/camera/camera_overlay.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'logic/camera_cubit.dart';

class CameraView extends HookWidget {
  const CameraView({super.key, required this.state});

  final CameraViewStateInitialized state;

  @override
  Widget build(BuildContext context) {
    final cameraController = state.controller;
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              elevation: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CameraPreview(
                  cameraController,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: state.processing ? 1 : 0,
                          child: Container(
                            color: C.dark.withAlpha(150),
                            child: Center(
                              child: Column(
                                children: [
                                  const Spacer(),
                                  const AppProgressIndicator(),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Poczekaj na analizę zdjęcia",
                                    textAlign: TextAlign.center,
                                    style: TS.standard.bold.withColor(C.white),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      CameraOverlay(
                        controller: cameraController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 160,
          child: Center(
            child: Button(
              onTap: BlocProvider.of<CameraCubit>(context).takePhoto,
              child: const Text(
                "Zrób zdjęcie planszy",
                style: TS.standardMinus,
              ),
            ),
          ),
        )
      ],
    );
  }
}
