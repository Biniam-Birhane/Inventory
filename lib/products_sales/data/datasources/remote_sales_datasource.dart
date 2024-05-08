import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/data/models/product_sales_model.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class RemoteSalesDatasource {
  const RemoteSalesDatasource();

  Future<void> addSale({required ProductSale productSale});
  Future<void> deleteSale({required String id});
  Future<void> updateSale({required ProductSale productSale});
  Future<List<ProductSale>> getSales();
}

class RemoteSalesDataSourceImpl implements RemoteSalesDatasource {
  RemoteSalesDataSourceImpl();
  CollectionReference salesRef = FirebaseFirestore.instance.collection('sales');
  @override
  Future<void> addSale({required ProductSale productSale}) async {
    try {
      final String id = productSale.id;
      DateTime dateTime = DateTime.now();
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      final data = {
        'id': productSale.id,
        'buyerName': productSale.buyerName,
        'productName': productSale.productName,
        'productId':productSale.productId,
        'amount': productSale.amount,
        'totalCost': productSale.totalCost,
        'paidAmount': productSale.paidAmount,
        'unPaidAmount': productSale.unPaidAmount,
        'date': dateTime.day,
        'month': dateTime.month,
        'year': dateTime.year
      };
      data['createdAt'] = timestamp;
      await salesRef.doc(id).set(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<void> deleteSale({required String id}) async {
    try {
      await salesRef.doc(id).delete();
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<void> updateSale({required ProductSale productSale}) async {
    try {
      final String id = productSale.id;
      DateTime dateTime = DateTime.now();
      final data = {
        'id': productSale.id,
        'buyerName': productSale.buyerName,
        'productName': productSale.productName,
        'productId': productSale.productId,
        'amount': productSale.amount,
        'totalCost': productSale.totalCost,
        'paidAmount': productSale.paidAmount,
        'unPaidAmount': productSale.unPaidAmount,
        'date': productSale.date ?? dateTime.day,
        'month': productSale.month ?? dateTime.month,
        'year': productSale.year ?? dateTime.year
      };

      Timestamp timestamp = Timestamp.fromDate(dateTime);
      print('DateTime $dateTime TimeStamp $timestamp');

      // if (productSale.createdAt == null) {
      data['createdAt'] = timestamp;
      // } else {
      //   data['createdAt'] = productSale.createdAt!;
      // }
      await salesRef.doc(id).update(data);
    } on APIException catch (e) {
      print("response error: ${e.message}");
      throw APIException(message: e.message, statusCode: e.statusCode);
    }
  }

  @override
  Future<List<ProductSale>> getSales() async {
    try {
      QuerySnapshot querySnapshot = await salesRef.get();
      List<ProductSale> sales = querySnapshot.docs.map((doc) {
        return ProductSalesModel.fromMap(doc.data() as DataMap);
      }).toList();

      return sales;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
