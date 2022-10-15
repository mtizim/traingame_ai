// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'camera_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CameraViewState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(CameraController controller) initialized,
    required TResult Function(String error) error,
    required TResult Function() noAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(CameraController controller)? initialized,
    TResult? Function(String error)? error,
    TResult? Function()? noAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(CameraController controller)? initialized,
    TResult Function(String error)? error,
    TResult Function()? noAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraViewStateInitial value) initial,
    required TResult Function(CameraViewStateInitialized value) initialized,
    required TResult Function(CameraViewStateError value) error,
    required TResult Function(CameraViewStateNoAccess value) noAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraViewStateInitial value)? initial,
    TResult? Function(CameraViewStateInitialized value)? initialized,
    TResult? Function(CameraViewStateError value)? error,
    TResult? Function(CameraViewStateNoAccess value)? noAccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraViewStateInitial value)? initial,
    TResult Function(CameraViewStateInitialized value)? initialized,
    TResult Function(CameraViewStateError value)? error,
    TResult Function(CameraViewStateNoAccess value)? noAccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraViewStateCopyWith<$Res> {
  factory $CameraViewStateCopyWith(
          CameraViewState value, $Res Function(CameraViewState) then) =
      _$CameraViewStateCopyWithImpl<$Res, CameraViewState>;
}

/// @nodoc
class _$CameraViewStateCopyWithImpl<$Res, $Val extends CameraViewState>
    implements $CameraViewStateCopyWith<$Res> {
  _$CameraViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CameraViewStateInitialCopyWith<$Res> {
  factory _$$CameraViewStateInitialCopyWith(_$CameraViewStateInitial value,
          $Res Function(_$CameraViewStateInitial) then) =
      __$$CameraViewStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraViewStateInitialCopyWithImpl<$Res>
    extends _$CameraViewStateCopyWithImpl<$Res, _$CameraViewStateInitial>
    implements _$$CameraViewStateInitialCopyWith<$Res> {
  __$$CameraViewStateInitialCopyWithImpl(_$CameraViewStateInitial _value,
      $Res Function(_$CameraViewStateInitial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CameraViewStateInitial implements CameraViewStateInitial {
  const _$CameraViewStateInitial();

  @override
  String toString() {
    return 'CameraViewState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CameraViewStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(CameraController controller) initialized,
    required TResult Function(String error) error,
    required TResult Function() noAccess,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(CameraController controller)? initialized,
    TResult? Function(String error)? error,
    TResult? Function()? noAccess,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(CameraController controller)? initialized,
    TResult Function(String error)? error,
    TResult Function()? noAccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraViewStateInitial value) initial,
    required TResult Function(CameraViewStateInitialized value) initialized,
    required TResult Function(CameraViewStateError value) error,
    required TResult Function(CameraViewStateNoAccess value) noAccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraViewStateInitial value)? initial,
    TResult? Function(CameraViewStateInitialized value)? initialized,
    TResult? Function(CameraViewStateError value)? error,
    TResult? Function(CameraViewStateNoAccess value)? noAccess,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraViewStateInitial value)? initial,
    TResult Function(CameraViewStateInitialized value)? initialized,
    TResult Function(CameraViewStateError value)? error,
    TResult Function(CameraViewStateNoAccess value)? noAccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CameraViewStateInitial implements CameraViewState {
  const factory CameraViewStateInitial() = _$CameraViewStateInitial;
}

/// @nodoc
abstract class _$$CameraViewStateInitializedCopyWith<$Res> {
  factory _$$CameraViewStateInitializedCopyWith(
          _$CameraViewStateInitialized value,
          $Res Function(_$CameraViewStateInitialized) then) =
      __$$CameraViewStateInitializedCopyWithImpl<$Res>;
  @useResult
  $Res call({CameraController controller});
}

/// @nodoc
class __$$CameraViewStateInitializedCopyWithImpl<$Res>
    extends _$CameraViewStateCopyWithImpl<$Res, _$CameraViewStateInitialized>
    implements _$$CameraViewStateInitializedCopyWith<$Res> {
  __$$CameraViewStateInitializedCopyWithImpl(
      _$CameraViewStateInitialized _value,
      $Res Function(_$CameraViewStateInitialized) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = null,
  }) {
    return _then(_$CameraViewStateInitialized(
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController,
    ));
  }
}

/// @nodoc

class _$CameraViewStateInitialized implements CameraViewStateInitialized {
  const _$CameraViewStateInitialized({required this.controller});

  @override
  final CameraController controller;

  @override
  String toString() {
    return 'CameraViewState.initialized(controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraViewStateInitialized &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraViewStateInitializedCopyWith<_$CameraViewStateInitialized>
      get copyWith => __$$CameraViewStateInitializedCopyWithImpl<
          _$CameraViewStateInitialized>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(CameraController controller) initialized,
    required TResult Function(String error) error,
    required TResult Function() noAccess,
  }) {
    return initialized(controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(CameraController controller)? initialized,
    TResult? Function(String error)? error,
    TResult? Function()? noAccess,
  }) {
    return initialized?.call(controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(CameraController controller)? initialized,
    TResult Function(String error)? error,
    TResult Function()? noAccess,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraViewStateInitial value) initial,
    required TResult Function(CameraViewStateInitialized value) initialized,
    required TResult Function(CameraViewStateError value) error,
    required TResult Function(CameraViewStateNoAccess value) noAccess,
  }) {
    return initialized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraViewStateInitial value)? initial,
    TResult? Function(CameraViewStateInitialized value)? initialized,
    TResult? Function(CameraViewStateError value)? error,
    TResult? Function(CameraViewStateNoAccess value)? noAccess,
  }) {
    return initialized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraViewStateInitial value)? initial,
    TResult Function(CameraViewStateInitialized value)? initialized,
    TResult Function(CameraViewStateError value)? error,
    TResult Function(CameraViewStateNoAccess value)? noAccess,
    required TResult orElse(),
  }) {
    if (initialized != null) {
      return initialized(this);
    }
    return orElse();
  }
}

abstract class CameraViewStateInitialized implements CameraViewState {
  const factory CameraViewStateInitialized(
          {required final CameraController controller}) =
      _$CameraViewStateInitialized;

  CameraController get controller;
  @JsonKey(ignore: true)
  _$$CameraViewStateInitializedCopyWith<_$CameraViewStateInitialized>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraViewStateErrorCopyWith<$Res> {
  factory _$$CameraViewStateErrorCopyWith(_$CameraViewStateError value,
          $Res Function(_$CameraViewStateError) then) =
      __$$CameraViewStateErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$CameraViewStateErrorCopyWithImpl<$Res>
    extends _$CameraViewStateCopyWithImpl<$Res, _$CameraViewStateError>
    implements _$$CameraViewStateErrorCopyWith<$Res> {
  __$$CameraViewStateErrorCopyWithImpl(_$CameraViewStateError _value,
      $Res Function(_$CameraViewStateError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$CameraViewStateError(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CameraViewStateError implements CameraViewStateError {
  const _$CameraViewStateError({required this.error});

  @override
  final String error;

  @override
  String toString() {
    return 'CameraViewState.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraViewStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraViewStateErrorCopyWith<_$CameraViewStateError> get copyWith =>
      __$$CameraViewStateErrorCopyWithImpl<_$CameraViewStateError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(CameraController controller) initialized,
    required TResult Function(String error) error,
    required TResult Function() noAccess,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(CameraController controller)? initialized,
    TResult? Function(String error)? error,
    TResult? Function()? noAccess,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(CameraController controller)? initialized,
    TResult Function(String error)? error,
    TResult Function()? noAccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraViewStateInitial value) initial,
    required TResult Function(CameraViewStateInitialized value) initialized,
    required TResult Function(CameraViewStateError value) error,
    required TResult Function(CameraViewStateNoAccess value) noAccess,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraViewStateInitial value)? initial,
    TResult? Function(CameraViewStateInitialized value)? initialized,
    TResult? Function(CameraViewStateError value)? error,
    TResult? Function(CameraViewStateNoAccess value)? noAccess,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraViewStateInitial value)? initial,
    TResult Function(CameraViewStateInitialized value)? initialized,
    TResult Function(CameraViewStateError value)? error,
    TResult Function(CameraViewStateNoAccess value)? noAccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CameraViewStateError implements CameraViewState {
  const factory CameraViewStateError({required final String error}) =
      _$CameraViewStateError;

  String get error;
  @JsonKey(ignore: true)
  _$$CameraViewStateErrorCopyWith<_$CameraViewStateError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CameraViewStateNoAccessCopyWith<$Res> {
  factory _$$CameraViewStateNoAccessCopyWith(_$CameraViewStateNoAccess value,
          $Res Function(_$CameraViewStateNoAccess) then) =
      __$$CameraViewStateNoAccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CameraViewStateNoAccessCopyWithImpl<$Res>
    extends _$CameraViewStateCopyWithImpl<$Res, _$CameraViewStateNoAccess>
    implements _$$CameraViewStateNoAccessCopyWith<$Res> {
  __$$CameraViewStateNoAccessCopyWithImpl(_$CameraViewStateNoAccess _value,
      $Res Function(_$CameraViewStateNoAccess) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CameraViewStateNoAccess implements CameraViewStateNoAccess {
  const _$CameraViewStateNoAccess();

  @override
  String toString() {
    return 'CameraViewState.noAccess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraViewStateNoAccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(CameraController controller) initialized,
    required TResult Function(String error) error,
    required TResult Function() noAccess,
  }) {
    return noAccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(CameraController controller)? initialized,
    TResult? Function(String error)? error,
    TResult? Function()? noAccess,
  }) {
    return noAccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(CameraController controller)? initialized,
    TResult Function(String error)? error,
    TResult Function()? noAccess,
    required TResult orElse(),
  }) {
    if (noAccess != null) {
      return noAccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CameraViewStateInitial value) initial,
    required TResult Function(CameraViewStateInitialized value) initialized,
    required TResult Function(CameraViewStateError value) error,
    required TResult Function(CameraViewStateNoAccess value) noAccess,
  }) {
    return noAccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CameraViewStateInitial value)? initial,
    TResult? Function(CameraViewStateInitialized value)? initialized,
    TResult? Function(CameraViewStateError value)? error,
    TResult? Function(CameraViewStateNoAccess value)? noAccess,
  }) {
    return noAccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CameraViewStateInitial value)? initial,
    TResult Function(CameraViewStateInitialized value)? initialized,
    TResult Function(CameraViewStateError value)? error,
    TResult Function(CameraViewStateNoAccess value)? noAccess,
    required TResult orElse(),
  }) {
    if (noAccess != null) {
      return noAccess(this);
    }
    return orElse();
  }
}

abstract class CameraViewStateNoAccess implements CameraViewState {
  const factory CameraViewStateNoAccess() = _$CameraViewStateNoAccess;
}
