import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
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
}

class AuthRemoteDataSource extends AuthDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource({required this.firebaseAuth});

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
}
