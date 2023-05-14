import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_data.freezed.dart';

@freezed
class ImageData with _$ImageData {
  const factory ImageData({
    required File file,
    String? name,
  }) = _ImageData;
}
