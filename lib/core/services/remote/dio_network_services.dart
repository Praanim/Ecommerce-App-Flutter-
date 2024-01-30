
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eccomerce_frontend/core/constants/api_constants.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/mixins/exception_handler_mixin.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/core/shared/app_response.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  ///[Dio] instance
  final Dio dio;

  //constructor
  DioNetworkService({required this.dio}) {
    dio.options = dioBaseOptions;
  }

  @override
  String get baseUrl => ApiConstants.baseUrl;

  @override
  Map<String, Object> get headers => ApiConstants.defaultHeaders;

  ///Get [BaseOptions] for the http Client
  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    return header;
  }

  @override
  Future<Either<AppException, AppResponse>> get(String endPoint,
      {Map<String, dynamic>? queryParameters})async {
    final eitherRes = await handleException(() => dio.get(endPoint,
      queryParameters: queryParameters),
      endPoint: endPoint);

    return eitherRes;
  }

  @override
  Future<Either<AppException, AppResponse>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    final eitherRes = await handleException(
        () => dio.post(
              endpoint,
              data: data,
            ),
        endPoint: endpoint);

    return eitherRes;
  }
}
