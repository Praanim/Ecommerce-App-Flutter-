import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/providers/auth_provider.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository authRepository;

  AuthNotifier();

  @override
  AuthState build() {
    authRepository = ref.watch(authRepositoryProvider);
    return AuthInitial();
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = AuthLoading();

    Future<Either<AppException, void>> firstApi() async {
      return authRepository.signInUser(
          user: UserModel(email: email, password: password));
    }

    Future<Either<AppException, UserModel>> secondApi() {
      return authRepository.getUserByEmail(email: email);
    }

    //creating a list of futures
    final List<Future<Either<AppException, dynamic>>> futures = [
      firstApi(),
      secondApi()
    ];

    //executing two future api calls at the same time or simultaneously.
    try {
      return Future.wait(
        futures,
      ).then((eitherResponses) {
        eitherResponses[0].fold((appException) {
          state = AuthFailure(appException: appException);
          return;
        }, (r) => null);

        eitherResponses[1].fold((appException) {
          state = AuthFailure(appException: appException);
        }, (userModel) {
          //initializing the userModel class after succefull login in firebase
          //also the user is found in the db.
          ref.read(userDataProvider.notifier).state = userModel;
          state = AuthSuccess();
        });
      });
    } catch (e) {
      state = AuthFailure(
          appException: SharedClass.unknownErrorInstance(
              identifier: 'Something went wrong in AuthNotifier'));
    }
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
