part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.loginStatus = FormzSubmissionStatus.initial,
      this.addUserStatus = FormzSubmissionStatus.initial,
      this.logoutStatus = FormzSubmissionStatus.initial,
      this.loggedInUsername = '',
      this.token = '',
      this.errorMessage = ''});

  final FormzSubmissionStatus loginStatus;
  final FormzSubmissionStatus addUserStatus;
  final FormzSubmissionStatus logoutStatus;
  final String loggedInUsername;
  final String token;
  final String errorMessage;

  LoginState copyWith({
    FormzSubmissionStatus? loginStatus,
    FormzSubmissionStatus? addUserStatus,
    FormzSubmissionStatus? logoutStatus,
    String? loggedInUsername,
    String? token,
    String? errorMessage,
  }) {
    return LoginState(
        loginStatus: loginStatus ?? this.loginStatus,
        addUserStatus: addUserStatus ?? this.addUserStatus,
        logoutStatus: logoutStatus ?? this.logoutStatus,
        loggedInUsername: loggedInUsername ?? this.loggedInUsername,
        token: token ?? this.token,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        loginStatus,
        addUserStatus,
        logoutStatus,
        loggedInUsername,
        token,
        errorMessage
      ];
}
