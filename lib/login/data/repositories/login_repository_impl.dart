import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/login/data/datasources/remote_data_source.dart';
import 'package:simple_inventory/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._remoteLoginDS);

  final RemoteLoginDataSource _remoteLoginDS;

  @override
  ResultFuture<String> login(
      {required String username, required String password}) async {
    try {
      final result =
          await _remoteLoginDS.login(username: username, password: password);
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultVoid logout() async {
    try {
      final response = await _remoteLoginDS.logout();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
