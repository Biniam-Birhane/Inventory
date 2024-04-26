import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetDailyProductReports
    extends UsecaseWithParams<void, GetDailyProductReportsParams> {
  const GetDailyProductReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductEntity>> call(
          GetDailyProductReportsParams params) async =>
      await _repository.getDailyProductReports(
          date: params.date, month: params.month, year: params.year);
}

class GetDailyProductReportsParams extends Equatable {
  const GetDailyProductReportsParams(
      {required this.date, required this.month, required this.year});

  final int date;
  final int month;
  final int year;

  @override
  List<Object> get props => [date, month, year];
}
