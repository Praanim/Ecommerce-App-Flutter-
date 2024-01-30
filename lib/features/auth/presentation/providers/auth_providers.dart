import 'package:eccomerce_frontend/features/auth/domain/providers/auth_provider.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);
