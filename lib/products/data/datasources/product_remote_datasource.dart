import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/data/models/product_model.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';

abstract class ProductRemoteDatasource {
  Future<void> addProduct({required ProductEntity product});
  Future<void> updateProduct({required ProductEntity product});
  Future<void> deleteProduct({required String id});
  Future<List<ProductEntity>> getProducts();
}

class ProductRemoteDatasourceImp implements ProductRemoteDatasource {
  ProductRemoteDatasourceImp();
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');
  @override
  Future<void> addProduct({required ProductEntity product}) async {
    try {
      final String id = product.id;
      final data = {
        'id': product.id,
        'productId': product.productId,
        'productName': product.productName,
        'amount': product.amount,
        'unitPrice': product.unitPrice,
      };
      await productRef.doc(id).set(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<void> updateProduct({required ProductEntity product}) async {
    try {
      final String id = product.id;
      final data = {
        "id": product.id,
        "productId": product.productId,
        "productName": product.productName,
        "amount": product.amount,
        "unitPrice": product.unitPrice
      };
      await productRef.doc(id).update(data);
    } on APIException catch (e) {
      print("update error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<void> deleteProduct({required String id}) async {
    try {
      await productRef.doc(id).delete();
    } on APIException catch (e) {
      print("delete error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      QuerySnapshot querySnapshot = await productRef.get();
      List<ProductEntity> products = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as DataMap);
      }).toList();
      return products;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
