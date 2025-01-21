import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/src/domain/entities/customer_exceptions.dart';

import '../token_services.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  dynamic get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
    bool extractData = true,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization':
                requiresToken ? 'Bearer ${await TokenService.getToken()}' : '',
          },
        ),
      );
      return extractData ? response.data['response'] : response.data;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(e.message);
      }
      if (e.type == DioExceptionType.unknown) {
        if (e.message!.contains('SocketException')) {
          throw SocketException(e.message ?? "");
        }
      }
      if (e.type == DioExceptionType.badResponse) {
        if (e.response?.statusCode == 102) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 502) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
        if (e.response?.statusCode == 401) {
          throw CustomException(errorCode: e.response?.statusCode);
        }
      }
      if (e.response?.data is Map<String, dynamic>) {
        throw CustomException(
            errorCode: e.response?.statusCode,
            errorMessage:
                e.response?.data['message'] ?? e.response?.statusMessage);
      }
      throw CustomException(
        errorCode: e.response?.statusCode,
        errorMessage: e.response?.data['message'] ?? e.response?.statusMessage,
      );
    }
  }

  // dynamic post(
  //   String path, {
  //   Map<String, dynamic>? params,
  //   Map<String, dynamic>? queryParams,
  //   bool requiresToken = true,
  //   FormData? formData,
  //   bool extractData = true,
  // }) async {
  //   bool isFormData = (formData != null);
  //   try {
  //     final headers = {
  //       'Authorization':
  //           requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
  //     };

  //     final response = await _dio.post(
  //       path,
  //       data: isFormData ? formData : params,
  //       queryParameters: queryParams,
  //       options: Options(
  //         contentType: isFormData ? Headers.formUrlEncodedContentType : null,
  //         headers: headers,
  //       ),
  //     );
  //     return extractData ? response.data['data'] : response.data;
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       throw TimeoutException(e.message);
  //     }
  //     if (e.type == DioExceptionType.unknown) {
  //       if (e.message!.contains('SocketException')) {
  //         throw SocketException(e.message ?? "");
  //       }
  //       if (e.message!.contains('HandshakeException')) {
  //         throw HandshakeException(e.message ?? "");
  //       }
  //     }
  //     if (e.type == DioExceptionType.badResponse) {
  //       if (e.response?.statusCode == 401) {
  //         // ignore: use_build_context_synchronously
  //         navigatorKey.currentState!.context.go(
  //           Routes.signin,
  //         );
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 102) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 502) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //     }
  //     if (e.response?.data is Map<String, dynamic>) {
  //       throw CustomException(
  //           errorCode: e.response?.statusCode,
  //           errorMessage:
  //               e.response?.data['message'] ?? e.response?.statusMessage);
  //     }
  //     throw CustomException(
  //         errorCode: e.response?.statusCode,
  //         errorMessage: e.response?.statusMessage);
  //   }
  // }

  // dynamic delete(
  //   String path, {
  //   Map<String, dynamic>? params,
  //   Map<String, dynamic>? queryParams,
  //   bool requiresToken = true,
  //   bool isFormData = false,
  //   bool extractData = true,
  //   FormData? formData,
  // }) async {
  //   try {
  //     final response = await _dio.delete(
  //       path,
  //       data: isFormData ? formData! : params,
  //       queryParameters: queryParams,
  //       options: Options(
  //         contentType: isFormData ? Headers.formUrlEncodedContentType : null,
  //         headers: {
  //           'Authorization':
  //               requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
  //         },
  //       ),
  //     );
  //     return extractData ? response.data['data'] : response.data;
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       throw TimeoutException(e.message);
  //     }
  //     if (e.type == DioExceptionType.unknown) {
  //       if (e.message!.contains('SocketException')) {
  //         throw SocketException(e.message ?? "");
  //       }
  //       if (e.message!.contains('HandshakeException')) {
  //         throw HandshakeException(e.message ?? "");
  //       }
  //     }
  //     if (e.type == DioExceptionType.badResponse) {
  //       if (e.response?.statusCode == 401) {
  //         // ignore: use_build_context_synchronously
  //         navigatorKey.currentState!.context.go(
  //           Routes.signin,
  //         );
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 102) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 502) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //     }
  //     if (e.response?.data is Map<String, dynamic>) {
  //       throw CustomException(
  //           errorCode: e.response?.statusCode,
  //           errorMessage:
  //               e.response?.data['message'] ?? e.response?.statusMessage);
  //     }
  //     throw CustomException(
  //         errorCode: e.response?.statusCode,
  //         errorMessage: e.response?.statusMessage);
  //   }
  // }

  // //-------------------------------------------
  // Future<dynamic> put(
  //   String path, {
  //   Map<String, dynamic>? params,
  //   Map<String, dynamic>? queryParams,
  //   bool requiresToken = true,
  //   bool isFormData = false,
  //   FormData? formData,
  //   bool extractData = true,
  // }) async {
  //   try {
  //     final headers = {
  //       'Authorization':
  //           requiresToken ? 'Bearer ${await _tokenService.getToken()}' : '',
  //     };

  //     final response = await _dio.put(
  //       path,
  //       data: isFormData ? formData! : params,
  //       queryParameters: queryParams,
  //       options: Options(
  //         contentType: isFormData ? Headers.formUrlEncodedContentType : null,
  //         headers: headers,
  //       ),
  //     );

  //     return extractData ? response.data['data'] : response.data;
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       throw TimeoutException(e.message);
  //     }
  //     if (e.type == DioExceptionType.unknown) {
  //       if (e.message!.contains('SocketException')) {
  //         throw SocketException(e.message ?? "");
  //       }
  //       if (e.message!.contains('HandshakeException')) {
  //         throw HandshakeException(e.message ?? "");
  //       }
  //     }
  //     if (e.type == DioExceptionType.badResponse) {
  //       if (e.response?.statusCode == 401) {
  //         // ignore: use_build_context_synchronously
  //         navigatorKey.currentState!.context.goNamed(Routes.signin);
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 102) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //       if (e.response?.statusCode == 502) {
  //         throw CustomException(errorCode: e.response?.statusCode);
  //       }
  //     }
  //     if (e.response?.data is Map<String, dynamic>) {
  //       throw CustomException(
  //           errorCode: e.response?.statusCode,
  //           errorMessage:
  //               e.response?.data['message'] ?? e.response?.statusMessage);
  //     }
  //     throw CustomException(
  //         errorCode: e.response?.statusCode,
  //         errorMessage: e.response?.statusMessage);
  //   }
  // }
}
