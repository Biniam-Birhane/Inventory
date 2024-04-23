import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class ReportRepository {
  const ReportRepository();

  ResultFuture<List<ProductSale>> getDailyReports(
      {required double date, required double month, required double year});

  ResultFuture<List<ProductSale>> getMonthlyReports({ required double month,required double year});

  ResultFuture<List<ProductSale>> getYearlyReports({required double year});
}
