import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/src/domain/entities/app_errors.dart';
import 'package:movie_app/src/domain/entities/customer_exceptions.dart';

class ApiCallWithError {
  const ApiCallWithError._();

  static Future<Either<AppError, T>> call<T>(Future<T> Function() f) async {
    try {
      return Right(await f());
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on TimeoutException {
      return const Left(AppError(AppErrorType.timeout));
    } on CustomException catch (e) {
      return Left(AppError(AppErrorType.api,
          error: e.errorMessage, statusCode: e.errorCode));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
