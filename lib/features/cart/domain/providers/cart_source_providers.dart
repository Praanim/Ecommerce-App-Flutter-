import 'package:eccomerce_frontend/core/services/providers/dio_network_service_provider.dart';
import 'package:eccomerce_frontend/features/cart/data/datasource/cart_data_source.dart';
import 'package:eccomerce_frontend/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:eccomerce_frontend/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///provider for [CartRepository]
final cartRepoProvider = Provider<CartRepository>(
  (ref) => CartRepositoryImpl(
    cartDataSource: ref.watch(cartDataSourceProvider),
  ),
);

///provider for [CartDataSource]
final cartDataSourceProvider = Provider<CartDataSource>(
  (ref) => CartRemoteDataSource(
    networkService: ref.watch(networkServiceProvider),
  ),
);
