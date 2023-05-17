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
  File? get processedFile => throw _privateConstructorUsedError;
  File? get initialFile => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get faceCount => throw _privateConstructorUsedError;
  bool get exists => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageDataCopyWith<ImageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDataCopyWith<$Res> {
  factory $ImageDataCopyWith(ImageData value, $Res Function(ImageData) then) =
      _$ImageDataCopyWithImpl<$Res, ImageData>;
  @useResult
  $Res call(
      {File? processedFile,
      File? initialFile,
      String? name,
      int? faceCount,
      bool exists});
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
    Object? processedFile = freezed,
    Object? initialFile = freezed,
    Object? name = freezed,
    Object? faceCount = freezed,
    Object? exists = null,
  }) {
    return _then(_value.copyWith(
      processedFile: freezed == processedFile
          ? _value.processedFile
          : processedFile // ignore: cast_nullable_to_non_nullable
              as File?,
      initialFile: freezed == initialFile
          ? _value.initialFile
          : initialFile // ignore: cast_nullable_to_non_nullable
              as File?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      faceCount: freezed == faceCount
          ? _value.faceCount
          : faceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call(
      {File? processedFile,
      File? initialFile,
      String? name,
      int? faceCount,
      bool exists});
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
    Object? processedFile = freezed,
    Object? initialFile = freezed,
    Object? name = freezed,
    Object? faceCount = freezed,
    Object? exists = null,
  }) {
    return _then(_$_ImageData(
      processedFile: freezed == processedFile
          ? _value.processedFile
          : processedFile // ignore: cast_nullable_to_non_nullable
              as File?,
      initialFile: freezed == initialFile
          ? _value.initialFile
          : initialFile // ignore: cast_nullable_to_non_nullable
              as File?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      faceCount: freezed == faceCount
          ? _value.faceCount
          : faceCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exists: null == exists
          ? _value.exists
          : exists // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ImageData implements _ImageData {
  const _$_ImageData(
      {this.processedFile,
      this.initialFile,
      this.name,
      this.faceCount,
      this.exists = false});

  @override
  final File? processedFile;
  @override
  final File? initialFile;
  @override
  final String? name;
  @override
  final int? faceCount;
  @override
  @JsonKey()
  final bool exists;

  @override
  String toString() {
    return 'ImageData(processedFile: $processedFile, initialFile: $initialFile, name: $name, faceCount: $faceCount, exists: $exists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImageData &&
            (identical(other.processedFile, processedFile) ||
                other.processedFile == processedFile) &&
            (identical(other.initialFile, initialFile) ||
                other.initialFile == initialFile) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.faceCount, faceCount) ||
                other.faceCount == faceCount) &&
            (identical(other.exists, exists) || other.exists == exists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, processedFile, initialFile, name, faceCount, exists);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImageDataCopyWith<_$_ImageData> get copyWith =>
      __$$_ImageDataCopyWithImpl<_$_ImageData>(this, _$identity);
}

abstract class _ImageData implements ImageData {
  const factory _ImageData(
      {final File? processedFile,
      final File? initialFile,
      final String? name,
      final int? faceCount,
      final bool exists}) = _$_ImageData;

  @override
  File? get processedFile;
  @override
  File? get initialFile;
  @override
  String? get name;
  @override
  int? get faceCount;
  @override
  bool get exists;
  @override
  @JsonKey(ignore: true)
  _$$_ImageDataCopyWith<_$_ImageData> get copyWith =>
      throw _privateConstructorUsedError;
}
