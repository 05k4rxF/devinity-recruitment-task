import 'package:freezed_annotation/freezed_annotation.dart';

export 'package:dartz/dartz.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure({String? message}) = _Failure;

  const factory Failure.databaseClientFailure() = DatabaseClientFailure;
  const factory Failure.instanceAlreadyExist() = InstanceAlreadyExistFailure;
  const factory Failure.instanceDoesNotExist() = InstanceDoesNotExistFailure;
  const factory Failure.invalidParameter() = InvalidParameterFailure;
  const factory Failure.localDataSourceFailure() = LocalDataSourceFailure;
}
