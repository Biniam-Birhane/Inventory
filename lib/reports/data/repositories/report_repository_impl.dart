import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/data/datasources/remote_report_datasource.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._remoteReportDatasource);

  final RemoteReportDatasource _remoteReportDatasource;

  @override
  ResultFuture<List<ProductSale>> getDailyReports(
      {required int date, required int month, required int year}) async {
    try {
      final sales =
          await _remoteReportDatasource.getDailyReports(date, month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getDailyProductReports(
      {required int date, required int month, required int year}) async {
    try {
      final sales = await _remoteReportDatasource.getDailyProductReports(
          date, month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductSale>> getYearlyReports({required int year}) async {
    try {
      final sales = await _remoteReportDatasource.getyearlyReports(year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getYearlyProductReports(
      {required int year}) async {
    try {
      final sales = await _remoteReportDatasource.getyearlyProductReports(year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductSale>> getMonthlyReports(
      {required int month, required int year}) async {
    try {
      final sales =
          await _remoteReportDatasource.getMonthlyReports(month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getMonthlyProductReports(
      {required int month, required int year}) async {
    try {
      final sales =
          await _remoteReportDatasource.getMonthlyProductReports(month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
