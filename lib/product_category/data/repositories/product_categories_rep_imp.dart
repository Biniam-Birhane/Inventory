import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';

class ProductCategoryRepImplimentation implements ProductCategoryRepository {
  ProductCategoryRepImplimentation(this._productCategoryRemotedatasource);

  late ProductCategoryRemoteDataSource _productCategoryRemotedatasource;
  @override
  ResultVoid addProductCategory(
      {required String id,
      required String productName,
      // required double availableAmount,required double unitPrice
      }) async {
    try {
      await _productCategoryRemotedatasource.addProductCategory(
          id: id, productName: productName, 
          );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultVoid updateProductCategory(
      {required String id,
      required String productName,
      // required double availableAmount,required double unitPrice
      }) async {
    try {
      await _productCategoryRemotedatasource.updateProductCategory(
          id: id, productName: productName, );
      return const Right(null);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteProductCategory({required String id}) async {
    try {
      await _productCategoryRemotedatasource.deleteProductCategory(id: id);
      return const Right(null);
    } on APIException catch (e) {
      return left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductCategoryEntity>> getProductCategory() async {
    try {
      final result =
          await _productCategoryRemotedatasource.getProductCategory();
      return Right(result);
    } on APIException catch (e) {
      return left(APIFailure.fromException(e));
    }
  }
}
