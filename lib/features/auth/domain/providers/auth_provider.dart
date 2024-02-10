import 'package:eccomerce_frontend/core/services/remote/providers/firebase_providers.dart';
import 'package:eccomerce_frontend/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:eccomerce_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) {
    return AuthRemoteDataSource(firebaseAuth:ref.watch(firebaseAuthProvider) );
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);

  return AuthRepositoryImpl(authDataSource: authDataSource);
});