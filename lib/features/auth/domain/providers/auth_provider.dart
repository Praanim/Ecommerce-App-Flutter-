import 'package:eccomerce_frontend/core/services/remote/providers/dio_network_service_provider.dart';
import 'package:eccomerce_frontend/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:eccomerce_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) {
    final networkService = ref.watch(networkServiceProvider);
    return AuthRemoteDataSource(networkService: networkService);
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);

  return AuthRepositoryImpl(authDataSource: authDataSource);
});