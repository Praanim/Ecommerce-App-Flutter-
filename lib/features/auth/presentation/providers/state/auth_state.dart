import 'package:eccomerce_frontend/core/exceptions/http_exceptions.dart';

abstract class AuthState{}

final class AuthInitial extends AuthState{}

final class AuthLoading extends AuthState{}

final class AuthSuccess extends AuthState{}

final class AuthFailure extends AuthState{
  final AppException appException;

  AuthFailure({required this.appException});

}