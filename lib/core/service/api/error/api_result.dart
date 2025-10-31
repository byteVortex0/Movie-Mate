import 'error_handler.dart';
import 'error_model.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends ApiResult<T> {
  final ErrorModel errorModel;
  const Failure(this.errorModel);

  static Future<Failure<T>> handle<T>(dynamic e) async {
    final failure = await ErrorHandler.handle(e);
    return Failure<T>(failure.errorModel);
  }
}
