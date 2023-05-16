import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:racunalni_vid/camera_repository.dart';
import 'package:racunalni_vid/image_data.dart';

part 'camera_state.dart';
part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState.imageState(ImageData(), true, null));

  late CameraController _controller;
  late List<CameraDescription> _cameras;

  Future<void> initController() async {
    emit(state.copyWith(isLoading: true));
    _cameras = await availableCameras();

    _controller = CameraController(_cameras[1], ResolutionPreset.max);

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
    try {
      emit(state.copyWith(isLoading: true, imageData: const ImageData()));
      final xFile = await _controller.takePicture();

      final imageData = await sendImageForProcessing(File(xFile.path));

      emit(state.copyWith(imageData: imageData, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> clearState() async {
    emit(state.copyWith(
      imageData: const ImageData(faceCount: null, file: null, name: null),
      isLoading: false,
    ));
  }

  Future<void> addToDatabase(File file, String username) async {
    try {
      emit(state.copyWith(isLoading: true));
      final imageData = await addUserToDatabase(file, username);
      emit(state.copyWith(
        imageData: imageData,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
