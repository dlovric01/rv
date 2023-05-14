part of 'camera_cubit.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState.imageState(
    File? file,
    bool isLoading,
    CameraController? controller,
    String? name,
    bool faceNotFound,
  ) = _Loaded;
}
