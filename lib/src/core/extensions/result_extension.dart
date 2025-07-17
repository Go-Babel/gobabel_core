import 'package:result_dart/result_dart.dart';

extension ResultDartExt<R extends Object> on ResultDart<R, Exception> {
  AsyncResult<T> asErrorAsync<T extends Object>() {
    return AsyncResult<T>.error(
      fold((_) => throw Exception('No error found'), (onFailure) => onFailure),
    );
  }

  Result<T> asError<T extends Object>() {
    return Failure(
      fold((_) => throw Exception('No error found'), (onFailure) => onFailure),
    );
  }
}
