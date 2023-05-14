import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:racunalni_vid/camera_repository.dart';

part 'camera_state.dart';
part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState.imageState(null, true, null, null));

  late CameraController _controller;
  late List<CameraDescription> _cameras;

  Future<void> initController() async {
    emit(state.copyWith(isLoading: true));
    _cameras = await availableCameras();

    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.max,
    );

    await _controller.initialize().then((_) {}).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    _controller.setFlashMode(FlashMode.off);
    _controller.setFocusMode(FocusMode.auto);
    emit(state.copyWith(isLoading: false, controller: _controller));
  }

  Future<void> takePicture() async {
    emit(state.copyWith(isLoading: true));
    final xFile = await _controller.takePicture();
    await sendImageForProcessing(File(xFile.path));

    emit(state.copyWith(file: File(xFile.path), isLoading: false));
  }

  Future<void> clearState() async {
    emit(state.copyWith(file: null));
  }
}
