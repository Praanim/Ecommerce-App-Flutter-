import 'package:dartz/dartz.dart';
import 'package:nattt_bazaar/core/exceptions/http_exceptions.dart';
import 'package:nattt_bazaar/core/services/remote/network_services.dart';
import 'package:nattt_bazaar/features/home/domain/models/product_model.dart';

abstract class UserDataSource {}

class UserRemoteDataSource extends UserDataSource {
  final NetworkService networkService;

  UserRemoteDataSource({required this.networkService});
}
