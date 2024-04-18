import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/data/datasources/remote_sales_datasource.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';

class SalesRepositoryImpl implements SalesRepository {
  const SalesRepositoryImpl(this._remoteSalesDatasource);

  final RemoteSalesDatasource _remoteSalesDatasource;

  @override
  ResultVoid addSale({required ProductSale productSale}) async {
    try {
      await _remoteSalesDatasource.addSale(productSale: productSale);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateSale({required ProductSale productSale}) async {
    try {
      await _remoteSalesDatasource.updateSale(productSale: productSale);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteSale({required String id}) async {
    try {
      await _remoteSalesDatasource.deleteSale(id: id);
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductSale>> getSales() async {
    try {
      final sales = await _remoteSalesDatasource.getSales();
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
