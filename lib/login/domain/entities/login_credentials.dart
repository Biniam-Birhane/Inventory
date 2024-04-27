import 'package:equatable/equatable.dart';

class LoginCredentials extends Equatable {
  const LoginCredentials({required this.username, required this.password});
  final String username;
  final String password;

  const LoginCredentials.empty()
      : this(username: 'empty_username', password: "empty_password");

  @override
  List<Object> get props => [username, password];
}
