import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/reports/domain/repositories/report_repository.dart';

class GetYearlyProductReports
    extends UsecaseWithParams<void, GetYearlyProductReportsParams> {
  const GetYearlyProductReports(this._repository);

  final ReportRepository _repository;

  @override
  ResultFuture<List<ProductEntity>> call(
          GetYearlyProductReportsParams params) async =>
      await _repository.getYearlyProductReports(year: params.year);
}

class GetYearlyProductReportsParams extends Equatable {
  const GetYearlyProductReportsParams({required this.year});

  final int year;

  @override
  List<Object> get props => [year];
}
