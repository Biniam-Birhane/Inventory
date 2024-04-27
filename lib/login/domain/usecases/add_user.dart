import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/login/domain/repositories/login_repository.dart';

class AddUser extends UsecaseWithParams<void, AddUserParams> {
  const AddUser(this._repository);

  final LoginRepository _repository;
  @override
  ResultVoid call(AddUserParams params) =>
      _repository.addUser(username: params.username, password: params.password);
}

class AddUserParams extends Equatable {
  const AddUserParams({required this.username, required this.password});
  final String username;
  final String password;

  const AddUserParams.empty()
      : this(username: 'empty_username', password: "empty_password");
  @override
  List<Object> get props => [username, password];
}
