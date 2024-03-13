import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/user.dart';

abstract class AuthRepository {
  Future<Either<AppException, void>> signInUser({required UserModel user});

  Future<Either<AppException, UserCredential>> signUpUser(
      {required UserModel user});

  Future<Either<AppException, UserModel>> getUserByEmail(
      {required String email});

  Future<Either<AppException, UserModel>> createUserInDb(
      {required UserModel userModel});

  Future<Either<AppException, void>> signOutUser();
}
