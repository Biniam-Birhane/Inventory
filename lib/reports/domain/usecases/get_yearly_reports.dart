import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetYearlyReports extends UsecaseWithParams<void, GetYearlyReportsParams> {
  const GetYearlyReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductSale>> call(GetYearlyReportsParams params) async =>
      await _repository.getYearlyReports(year: params.year);
}

class GetYearlyReportsParams extends Equatable {
  const GetYearlyReportsParams({required this.year});

  final double year;

  @override
  List<Object> get props => [year];
}
