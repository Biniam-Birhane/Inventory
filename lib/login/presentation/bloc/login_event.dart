part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginRequestedEvent extends LoginEvent {
  const LoginRequestedEvent({required this.username, required this.password});

  final String username;
  final String password;
  @override
  List<Object> get props => [username, password];
}

class AddUserEvent extends LoginEvent {
  const AddUserEvent({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object> get props => [email, password];
}

class LogOutEvent extends LoginEvent {}
