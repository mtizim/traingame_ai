import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraViewState> {
  CameraCubit() : super(const CameraViewState.initial());

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
      emit(CameraViewState.error(
          code: e.code, description: e.description ?? ""));
    }

    emit(CameraViewState.initialized(controller: controller));
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
  const factory CameraViewState.initialized(
      {required CameraController controller}) = CameraViewStateInitialized;
  const factory CameraViewState.error(
      {required String code,
      required String description}) = CameraViewStateError;
  const factory CameraViewState.noAccess() = CameraViewStateNoAccess;
}
