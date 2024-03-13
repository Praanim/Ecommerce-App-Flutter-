import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/providers/auth_provider.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/auth_providers.dart';
import 'package:eccomerce_frontend/features/auth/presentation/providers/state/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

        //it the state is already failure then no need to proceed.
        if (state is AuthFailure) {
          return;
        }

        eitherResponses[1].fold((appException) {
          state = AuthFailure(appException: appException);
        }, (userModel) {
          //initializing the userModel class after succefull login in firebase
          //also the user is found in the db.
          ref.read(userDataProvider.notifier).state = userModel as UserModel;
          state = AuthSuccess(
            userModel: userModel,
          );
        });
      });
    } catch (e) {
      state = AuthFailure(
          appException: SharedClass.unknownErrorInstance(
              identifier: 'Something went wrong in AuthNotifier'));
    }
  }

  Future<void> signUpUser({
    required UserModel userModel,
  }) async {
    state = AuthLoading();

    final eitherRes = await authRepository.signUpUser(user: userModel);
    eitherRes.fold(
      (appException) {
        return state = AuthFailure(appException: appException);
      },
      (UserCredential userCredential) async {
        final eitherRes = await authRepository.createUserInDb(
            userModel: userModel.copyWith(id: userCredential.user!.uid));
        return state = eitherRes.fold(
            (appException) => AuthFailure(appException: appException),
            (userModel) => AuthSuccess(userModel: userModel));
      },
    );
  }

  ///Signs out the current user
  void signOut() async {
    state = AuthLoading();
    final eitherResponse = await authRepository.signOutUser();

    state = eitherResponse.fold(
        (appException) => AuthFailure(appException: appException),
        (_) => AuthSignOut());
  }
}
