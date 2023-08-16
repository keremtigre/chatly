part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginComplated extends LoginState {}

class LoginError extends LoginState {
  final String? errorMessage;
  LoginError({this.errorMessage});
}
