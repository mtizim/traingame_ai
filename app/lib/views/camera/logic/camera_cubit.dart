import 'package:app/views/camera/logic/model_communication.dart';
import 'package:app/views/global_logic/game_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraViewState> {
  final GameCubit gameCubit;

  CameraCubit(this.gameCubit) : super(const CameraViewState.initial());

  Future<void> reset() => init();

  Future<void> init() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.external,
        orElse: () => cameras.first,
      ),
    );
    final controller =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      if (e.code == "CameraAccessDenied") {
        emit(const CameraViewState.noAccess());
        return;
      }
      emit(
        CameraViewState.error(
          code: e.code,
          description: e.description ?? "",
        ),
      );
    }

    emit(
      CameraViewState.initialized(controller: controller, processing: false),
    );
  }

  Future<bool> takePhoto() async {
    return state.mapOrNull(
          initialized: (s) async {
            late final XFile image;
            try {
              await s.controller.setFlashMode(FlashMode.off);
              image = await s.controller.takePicture();
              await s.controller.pausePreview();
            } on CameraException catch (e) {
              if (e.code == "Previous capture has not returned yet.") {
                return false;
              }
              await s.controller.resumePreview();
              emit(
                CameraViewState.error(
                  code: e.code,
                  description: e.description ?? "",
                ),
              );
              return false;
            }
            emit(s.copyWith(processing: true));
            final results = await detectRoutesFromImage(image);
            final resultsSuccess = gameCubit.consumeModelResults(results);
            if (!resultsSuccess) {
              emit(const CameraViewState.retake());
            }
            return resultsSuccess;
          },
        ) ??
        true;
  }

  @override
  Future<void> close() async {
    final controller = state.mapOrNull(initialized: (s) => s.controller);
    await controller?.dispose();
    await super.close();
  }
}

@freezed
class CameraViewState with _$CameraViewState {
  const factory CameraViewState.initial() = CameraViewStateInitial;
  const factory CameraViewState.initialized({
    required CameraController controller,
    required bool processing,
  }) = CameraViewStateInitialized;
  const factory CameraViewState.error({
    required String code,
    required String description,
  }) = CameraViewStateError;
  const factory CameraViewState.retake() = CameraViewStateRetake;
  const factory CameraViewState.noAccess() = CameraViewStateNoAccess;
}
