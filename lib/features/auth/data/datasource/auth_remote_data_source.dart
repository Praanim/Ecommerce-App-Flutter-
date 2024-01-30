import 'package:dartz/dartz.dart';
import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/core/services/remote/network_services.dart';
import 'package:eccomerce_frontend/features/auth/domain/models/user.dart';

abstract class AuthDataSource{
  Future<Either<AppException,User>> loginUser({
    required User user
  });
}

class AuthRemoteDataSource extends AuthDataSource{
  final NetworkService networkService;

  AuthRemoteDataSource({required this.networkService});

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async{
    try{
      final eitherResponse = await networkService.post('/user/signIn',
      data: user.toJson(),
      );
     return eitherResponse.fold((exception) =>Left(exception), (appResponse) {
          final user = User.fromJson(appResponse.data);

          return Right(user);
      },);

    }catch(e){
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 4,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }

  }

}