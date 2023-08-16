part of 'signup_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpComplated extends SignUpState {}

class SignUpError extends SignUpState {
  final String? errorMessage;
  SignUpError({this.errorMessage});
}
