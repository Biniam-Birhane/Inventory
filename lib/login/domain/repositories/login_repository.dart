import 'package:simple_inventory/core/utils/typedef.dart';

abstract class LoginRepository {
  LoginRepository();

  ResultFuture<String> login(
      {required String username, required String password});
  ResultVoid addUser({required String username, required String password});
  ResultVoid logout();
}
