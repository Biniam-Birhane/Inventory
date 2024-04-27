import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetMonthlyProductReports
    extends UsecaseWithParams<void, GetMonthlyProductReportsParams> {
  const GetMonthlyProductReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductEntity>> call(
          GetMonthlyProductReportsParams params) async =>
      await _repository.getMonthlyProductReports(
          month: params.month, year: params.year);
}

class GetMonthlyProductReportsParams extends Equatable {
  const GetMonthlyProductReportsParams(
      {required this.month, required this.year});

  final int month;
  final int year;

  @override
  List<Object> get props => [month, year];
}
