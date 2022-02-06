import '../../../core/errors/failure.dart';

export '../../../core/errors/failure.dart';

abstract class UseCase<T, S> {
  Future<Either<Failure, T>> call(S param);
}

abstract class RightUseCase<T, S> {
  Future<T> call(S param);
}

abstract class StreamUseCase<T, S> {
  Stream<T> call(S param);
}
