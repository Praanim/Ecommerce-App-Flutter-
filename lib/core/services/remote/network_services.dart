import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/core/shared/app_response.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, AppResponse>> get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, AppResponse>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, AppResponse>> put(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
