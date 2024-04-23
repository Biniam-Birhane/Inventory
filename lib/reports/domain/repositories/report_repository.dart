import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class ReportRepository {
  const ReportRepository();

  ResultFuture<List<ProductSale>> getDailyReports(
      {required int date, required int month, required int year});

  ResultFuture<List<ProductSale>> getMonthlyReports({ required int month,required int year});

  ResultFuture<List<ProductSale>> getYearlyReports({required int year});
}
