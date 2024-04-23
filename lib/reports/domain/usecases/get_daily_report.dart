import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetDailyReports extends UsecaseWithParams<void, GetDailyReportsParams> {
  const GetDailyReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductSale>> call(GetDailyReportsParams params) async =>
      await _repository.getDailyReports(
          date: params.date, month: params.month, year: params.year);
}

class GetDailyReportsParams extends Equatable {
  const GetDailyReportsParams(
      {required this.date, required this.month, required this.year});

  final double date;
  final double month;
  final double year;

  @override
  List<Object> get props => [date, month, year];
}
