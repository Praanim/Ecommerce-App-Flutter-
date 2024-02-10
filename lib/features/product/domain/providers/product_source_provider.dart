import 'package:eccomerce_frontend/core/services/remote/providers/dio_network_service_provider.dart';
import 'package:eccomerce_frontend/features/product/data/datasource/product_data_source.dart';
import 'package:eccomerce_frontend/features/product/data/repositories/product_repository_impl.dart';
import 'package:eccomerce_frontend/features/product/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Home data source provider
final productDataSourceProvider = Provider<ProductDataSource>(
  (ref) => ProductRemoteDataSource(
      networkService: ref.watch(networkServiceProvider)),
);

///Product repo provider
final productRepositoryProvider = Provider<ProductReposiotry>(
  (ref) => ProductReposiotryImpl(
      productDataSource: ref.watch(productDataSourceProvider)),
);
