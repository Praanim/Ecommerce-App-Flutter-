import 'package:eccomerce_frontend/core/services/remote/providers/dio_network_service_provider.dart';
import 'package:eccomerce_frontend/features/home/data/datasource/home_remote_data_source.dart';
import 'package:eccomerce_frontend/features/home/data/repositories/product_repository_impl.dart';
import 'package:eccomerce_frontend/features/home/domain/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Home data source provider
final homeDataSourceProvider = Provider<HomeDataSource>(
  (ref) =>
      HomeRemoteDataSource(networkService: ref.watch(networkServiceProvider)),
);

///Product repo provider
final productRepositoryProvider = Provider<ProductReposiotry>(
  (ref) =>
      ProductReposiotryImpl(homeDataSource: ref.watch(homeDataSourceProvider)),
);
