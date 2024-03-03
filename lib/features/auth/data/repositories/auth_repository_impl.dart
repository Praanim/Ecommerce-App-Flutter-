import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';
import 'package:eccomerce_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<AppException, void>> signInUser({required UserModel user}) {
    return authDataSource.sigIn(user: user);
  }

  @override
  Future<Either<AppException, void>> signUpUser({required UserModel user}) {
    return authDataSource.signUp(user: user);
  }

  @override
  Future<Either<AppException, UserModel>> getUserByEmail(
      {required String email}) {
    return authDataSource.getUserByEmail(email);
  }
}
