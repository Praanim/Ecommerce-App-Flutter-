import 'dart:io';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/shared/app_response.dart';
import '../services/remote/remote.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, AppResponse>> handleException(
      Future<Response<dynamic>> Function() handler,
      {String endPoint = ''}) async {
    try {
      final res = await handler();
      return Right(
        AppResponse(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage));
    } catch (e) {
      String message = '';
      String identifier = '';
      int statusCode = 0;
      developer.log(e.runtimeType.toString());

      switch (e.runtimeType) {
        case SocketException:
          e as SocketException;
          message = 'Unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at $endPoint';
          break;

        case DioException:
          e as DioException;
          message = e.response?.data?['message'] ?? 'Internal Error Occured';
          statusCode = 1;
          identifier = 'DioException ${e.message} at $endPoint';
          break;

        default:
          message = 'Unknown error occurred';
          statusCode = 2;
          identifier = 'Unknown error ${e.toString()}\n at $endPoint';
      }

      return Left(AppException(
        identifier: identifier,
        message: message,
        statusCode: statusCode,
      ));
    }
  }
}
