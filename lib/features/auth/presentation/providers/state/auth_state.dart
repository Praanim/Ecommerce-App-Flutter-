import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';
import 'package:eccomerce_frontend/features/auth/data/models/user.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel userModel;

  AuthSuccess({required this.userModel});
}

final class AuthFailure extends AuthState {
  final AppException appException;

  AuthFailure({required this.appException});
}

final class AuthSignOut extends AuthState {}
