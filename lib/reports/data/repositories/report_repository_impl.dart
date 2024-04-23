import 'package:dartz/dartz.dart';
import 'package:simple_inventory/core/errors/api_exception.dart';
import 'package:simple_inventory/core/errors/failure.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/data/datasources/remote_report_datasource.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  const ReportRepositoryImpl(this._remoteReportDatasource);

  final RemoteReportDatasource _remoteReportDatasource;

  @override
  ResultFuture<List<ProductSale>> getDailyReports(
      {required double date,
      required double month,
      required double year}) async {
    try {
      final sales =
          await _remoteReportDatasource.getDailyReports(date, month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductSale>> getYearlyReports(
      {required double year}) async {
    try {
      final sales = await _remoteReportDatasource.getyearlyReports(year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductSale>> getMonthlyReports(
      {required double month, required double year}) async {
    try {
      final sales =
          await _remoteReportDatasource.getMonthlyReports(month, year);
      return Right(sales);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
