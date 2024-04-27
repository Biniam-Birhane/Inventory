import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/data/models/product_model.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/data/models/product_sales_model.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class RemoteReportDatasource {
  const RemoteReportDatasource();
  Future<List<ProductSale>> getDailyReports(int date, int month, int year);
  Future<List<ProductEntity>> getDailyProductReports(
      int date, int month, int year);
  Future<List<ProductSale>> getMonthlyReports(int month, int year);
  Future<List<ProductEntity>> getMonthlyProductReports(int month, int year);
  Future<List<ProductSale>> getyearlyReports(int year);
  Future<List<ProductEntity>> getyearlyProductReports(int year);
}

class RemoteReportDatasourceImpl implements RemoteReportDatasource {
  RemoteReportDatasourceImpl();
  CollectionReference salesRef = FirebaseFirestore.instance.collection('sales');
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('products');

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
  Future<List<ProductEntity>> getDailyProductReports(
      int date, int month, int year) async {
    try {
      QuerySnapshot querySnapshot = await productRef
          .where('date', isEqualTo: date)
          .where('month', isEqualTo: month)
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
      List<ProductEntity> products = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as DataMap);
      }).toList();
      print(products);
      return products;
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
  Future<List<ProductEntity>> getMonthlyProductReports(
      int month, int year) async {
    try {
      QuerySnapshot querySnapshot = await productRef
          .where('month', isEqualTo: month)
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
      List<ProductEntity> products = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as DataMap);
      }).toList();
      print(products);
      return products;
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

  @override
  Future<List<ProductEntity>> getyearlyProductReports(int year) async {
    try {
      print(year);
      QuerySnapshot querySnapshot = await salesRef
          .where('year', isEqualTo: year)
          .orderBy('createdAt', descending: true)
          .get();
      print(querySnapshot.docs.map((e) => print(e)));

      List<ProductEntity> sales = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as DataMap);
      }).toList();
      print(sales);
      return sales;
    } on APIException {
      rethrow;
    } on Exception catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
