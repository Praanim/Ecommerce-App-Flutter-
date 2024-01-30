import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';

import '../models/user.dart';

abstract class AuthRepository{
  Future<Either<AppException,User>> loginUser({
    required User user
  });
}