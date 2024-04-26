import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/login/domain/repositories/login_repository.dart';

class LoginUsecase extends UsecaseWithParams<String, LoginParams> {
  const LoginUsecase(this._repository);

  final LoginRepository _repository;
  @override
  ResultFuture<String> call(LoginParams params) =>
      _repository.login(username: params.username, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.username, required this.password});
  final String username;
  final String password;

  const LoginParams.empty()
      : this(username: 'empty_username', password: "empty_password");
  @override
  List<Object> get props => [username, password];
}
