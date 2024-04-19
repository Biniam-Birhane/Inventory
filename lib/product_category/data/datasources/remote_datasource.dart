import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/data/models/product_category_model.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';

abstract class ProductCategoryRemoteDataSource {
  const ProductCategoryRemoteDataSource();
  Future<void> addProductCategory(
      {required String id,
      required String productName,
      required double availableAmount});
  Future<void> updateProductCategory(
      {required String id,
      required String productName,
      required double availableAmount});
  Future<void> deleteProductCategory({
    required String id,
  });
  Future<List<ProductCategoryEntity>> getProductCategory();
}

class ProductCategoryRemoteDataSourceImp
    implements ProductCategoryRemoteDataSource {
  ProductCategoryRemoteDataSourceImp();
  CollectionReference customerRef =
      FirebaseFirestore.instance.collection('product_category');
  Future<void> addProductCategory(
      {required String id,
      required String productName,
      required double availableAmount}) async {
    try {
      final data = {
        'id': id,
        'productName': productName,
        'availableAmount': availableAmount
      };
      await customerRef.doc(id).set(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<void> updateProductCategory(
      {required String id,
      required String productName,
      required double availableAmount}) async {
    try {
      final data = {
        'id': id,
        'productName': productName,
        'availableAmount': availableAmount
      };
      await customerRef.doc(id).update(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<void> deleteProductCategory({required String id}) async {
    try {
      await customerRef.doc(id).delete();
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  Future<List<ProductCategoryEntity>> getProductCategory() async {
    try {
      QuerySnapshot querySnapshot = await customerRef.get();

      List<ProductCategoryEntity> productCategories =
          querySnapshot.docs.map((doc) {
        return ProductCategoryModel.fromMap(doc.data() as DataMap);
      }).toList();
      return productCategories;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
