import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/data/datasources/product_remote_datasource.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';

class ProductRepositoryImp implements ProductRepository {
  ProductRepositoryImp(this.productRemoteDatasource);
  final ProductRemoteDatasource productRemoteDatasource;
  ResultVoid addProduct({required ProductEntity product}) async {
    try {
      await productRemoteDatasource.addProduct(product: product);
      return Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultVoid updateProduct({required ProductEntity product}) async {
    try {
      await productRemoteDatasource.updateProduct(product: product);
      return Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultVoid deleteProduct({required String id}) async {
    try {
      await productRemoteDatasource.deleteProduct(id: id);
      return Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<List<ProductEntity>> getProducts() async {
    try {
      final result = await productRemoteDatasource.getProducts();
      return Right(result);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
