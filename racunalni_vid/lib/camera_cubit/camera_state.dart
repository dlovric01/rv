part of 'camera_cubit.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState.imageState(
    ImageData imageData,
    bool isLoading,
    CameraController? controller,
  ) = _Loaded;
}
