import 'package:nattt_bazaar/core/services/providers/dio_network_service_provider.dart';
import 'package:nattt_bazaar/features/product/data/datasource/product_data_source.dart';
import 'package:nattt_bazaar/features/product/data/repositories/product_repository_impl.dart';
import 'package:nattt_bazaar/features/product/domain/repositories/product_repository.dart';
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
