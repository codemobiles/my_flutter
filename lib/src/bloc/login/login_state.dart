part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginInValid extends LoginState {
  final String errorUsername;
  final String errorPassword;

  const LoginInValid({this.errorUsername, this.errorPassword});

  @override
  List<Object> get props => [errorUsername, errorPassword];

  @override
  String toString() =>
      'LoginInValid { errorUsername: $errorUsername, errorPassword: $errorPassword }';
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}