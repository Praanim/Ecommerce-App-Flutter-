import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier({required this.authRepository}) : super(AuthInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = AuthLoading();

    final eitherRes = await authRepository.signInUser(
        user: UserModel(email: email, password: password));

    state = eitherRes.fold(
      (appException) => AuthFailure(appException: appException),
      (_) {
        return AuthSuccess();
      },
    );
  }

  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    state = AuthLoading();

    final eitherRes = await authRepository.signUpUser(
        user: UserModel(email: email, password: password));

    state = eitherRes.fold(
      (appException) => AuthFailure(appException: appException),
      (_) {
        return AuthSuccess();
      },
    );
  }
}
