// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ImageData {
  File? get file => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get faceCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageDataCopyWith<ImageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDataCopyWith<$Res> {
  factory $ImageDataCopyWith(ImageData value, $Res Function(ImageData) then) =
      _$ImageDataCopyWithImpl<$Res, ImageData>;
  @useResult
  $Res call({File? file, String? name, int? faceCount});
}

/// @nodoc
class _$ImageDataCopyWithImpl<$Res, $Val extends ImageData>
    implements $ImageDataCopyWith<$Res> {
  _$ImageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
    Object? name = freezed,
    Object? faceCount = freezed,
  }) {
    return _then(_value.copyWith(
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      faceCount: freezed == faceCount
          ? _value.faceCount
          : faceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ImageDataCopyWith<$Res> implements $ImageDataCopyWith<$Res> {
  factory _$$_ImageDataCopyWith(
          _$_ImageData value, $Res Function(_$_ImageData) then) =
      __$$_ImageDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? file, String? name, int? faceCount});
}

/// @nodoc
class __$$_ImageDataCopyWithImpl<$Res>
    extends _$ImageDataCopyWithImpl<$Res, _$_ImageData>
    implements _$$_ImageDataCopyWith<$Res> {
  __$$_ImageDataCopyWithImpl(
      _$_ImageData _value, $Res Function(_$_ImageData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? file = freezed,
    Object? name = freezed,
    Object? faceCount = freezed,
  }) {
    return _then(_$_ImageData(
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      faceCount: freezed == faceCount
          ? _value.faceCount
          : faceCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ImageData implements _ImageData {
  const _$_ImageData({this.file, this.name, this.faceCount});

  @override
  final File? file;
  @override
  final String? name;
  @override
  final int? faceCount;

  @override
  String toString() {
    return 'ImageData(file: $file, name: $name, faceCount: $faceCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageData &&
            (identical(other.file, file) || other.file == file) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.faceCount, faceCount) ||
                other.faceCount == faceCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, file, name, faceCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageDataCopyWith<_$_ImageData> get copyWith =>
      __$$_ImageDataCopyWithImpl<_$_ImageData>(this, _$identity);
}

abstract class _ImageData implements ImageData {
  const factory _ImageData(
      {final File? file,
      final String? name,
      final int? faceCount}) = _$_ImageData;

  @override
  File? get file;
  @override
  String? get name;
  @override
  int? get faceCount;
  @override
  @JsonKey(ignore: true)
  _$$_ImageDataCopyWith<_$_ImageData> get copyWith =>
      throw _privateConstructorUsedError;
}
