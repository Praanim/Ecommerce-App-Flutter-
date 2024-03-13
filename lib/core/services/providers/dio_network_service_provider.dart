import 'package:dio/dio.dart';
import 'package:eccomerce_frontend/core/services/remote/dio_network_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider((ref) {
  final Dio dio = Dio();
  return DioNetworkService(dio: dio);
});