import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:eccomerce_frontend/features/auth/domain/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return authDataSource.loginUser(user: user);
  }

}