import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  const CustomerRepositoryImpl(this._remoteDataSource);
  final RemoteDataSource _remoteDataSource;

  @override
  ResultVoid addCustomer(
      {required String name, required String phoneNumber}) async {
    try {
      await _remoteDataSource.addCustomer(name: name, phoneNumber: phoneNumber);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateCustomer(
      {required String id,
      required String name,
      required String phoneNumber}) async {
    try {
      await _remoteDataSource.updateCustomer(
          id: id, name: name, phoneNumber: phoneNumber);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteCustomer({required String id}) async {
    try {
      await _remoteDataSource.deleteCustomer(id: id);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<CustomerEntity>> getCustomers() async {
    try {
      final result = await _remoteDataSource.getCustomers();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
