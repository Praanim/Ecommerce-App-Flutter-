import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/core/shared/shared.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthDataSource {
  ///Sign in user
  Future<Either<AppException, void>> sigIn({required UserModel user});

  ///Sign up user
  Future<Either<AppException, void>> signUp({required UserModel user});

  ///user auth state
  Stream<User?> authStateChanges();

  ///Get user by email
  Future<Either<AppException, UserModel>> getUserByEmail(String email);
}

class AuthRemoteDataSource extends AuthDataSource {
  final NetworkService networkService;

  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(
      {required this.networkService, required this.firebaseAuth});

  @override
  Future<Either<AppException, void>> sigIn({required UserModel user}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SharedClass.firebaseErrorInstance(e: e));
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser'));
    }
  }

  @override
  Stream<User?> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, void>> signUp({required UserModel user}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(SharedClass.firebaseErrorInstance(e: e));
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser'));
    }
  }

  @override
  Future<Either<AppException, UserModel>> getUserByEmail(String email) async {
    try {
      final eitherResponse =
          await networkService.get('/user', queryParameters: {'email': email});
      return eitherResponse.fold((appException) {
        return Left(appException);
      }, (appResponse) {
        final data = appResponse.data['message'];
        return Right(UserModel.fromJson(data));
      });
    } catch (e) {
      return Left(SharedClass.unknownErrorInstance(
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser'));
    }
  }
}
