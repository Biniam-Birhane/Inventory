import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/data/models/product_sales_model.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class RemoteReportDatasource {
  const RemoteReportDatasource();
  Future<List<ProductSale>> getDailyReports(
      int date, int month, int year);
  Future<List<ProductSale>> getMonthlyReports(int month, int year);
  Future<List<ProductSale>> getyearlyReports(int year);
}

class RemoteReportDatasourceImpl implements RemoteReportDatasource {
  RemoteReportDatasourceImpl();
  CollectionReference salesRef = FirebaseFirestore.instance.collection('sales');

  @override
  Future<List<ProductSale>> getDailyReports(
      int date, int month, int year) async {
    try {
      QuerySnapshot querySnapshot = await salesRef
          .where('date', isEqualTo: date)
          .where('month', isEqualTo: month)
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
      List<ProductSale> sales = querySnapshot.docs.map((doc) {
        return ProductSalesModel.fromMap(doc.data() as DataMap);
      }).toList();
      return sales;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      print(e);
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<ProductSale>> getMonthlyReports(int month, int year) async {
    try {
      QuerySnapshot querySnapshot = await salesRef
          .where('month', isEqualTo: month)
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
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

  @override
  Future<List<ProductSale>> getyearlyReports(int year) async {
    try {
      QuerySnapshot querySnapshot = await salesRef
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
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
