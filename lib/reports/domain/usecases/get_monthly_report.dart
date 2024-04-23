import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetMonthlyReports
    extends UsecaseWithParams<void, GetMonthlyReportsParams> {
  const GetMonthlyReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductSale>> call(GetMonthlyReportsParams params) async =>
      await _repository.getMonthlyReports(
          month: params.month, year: params.year);
}

class GetMonthlyReportsParams extends Equatable {
  const GetMonthlyReportsParams({required this.month, required this.year});

  final double month;
  final double year;

  @override
  List<Object> get props => [month, year];
}
