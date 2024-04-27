part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoggedIn extends LoginState {
  const LoggedIn({required this.username, required this.token});
  final String username;
  final String token;
  @override
  List<Object> get props => [username, token];
}

class LoginRequesting extends LoginState {}

class LoggedOut extends LoginState {}

class LoggingOut extends LoginState {}

class LoginError extends LoginState {
  const LoginError({required this.errorMessage});
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
