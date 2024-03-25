import 'package:nattt_bazaar/core/services/providers/dio_network_service_provider.dart';
import 'package:nattt_bazaar/core/services/providers/firebase_providers.dart';
import 'package:nattt_bazaar/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:nattt_bazaar/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:nattt_bazaar/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataSourceProvider = Provider<AuthDataSource>(
  (ref) {
    return AuthRemoteDataSource(
      networkService: ref.watch(networkServiceProvider),
      firebaseAuth: ref.watch(firebaseAuthProvider),
    );
  },
);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authDataSource = ref.watch(authDataSourceProvider);

  return AuthRepositoryImpl(authDataSource: authDataSource);
});
