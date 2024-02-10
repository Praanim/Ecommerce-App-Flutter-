import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';

import '../../data/models/user.dart';

abstract class AuthRepository{
  Future<Either<AppException,void>> signInUser({
    required UserModel user
  });

  Future<Either<AppException,void>> signUpUser({
    required UserModel user
  });

}