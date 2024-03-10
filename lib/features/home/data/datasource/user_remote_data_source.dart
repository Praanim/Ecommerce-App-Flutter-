import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/features/home/domain/models/product_model.dart';

abstract class UserDataSource {}

class UserRemoteDataSource extends UserDataSource {
  final NetworkService networkService;

  UserRemoteDataSource({required this.networkService});
}
