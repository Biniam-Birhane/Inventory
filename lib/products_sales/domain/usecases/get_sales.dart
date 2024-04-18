import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';

class GetSales extends UsecasesWithoutParams {
  const GetSales(this._repository);

  final SalesRepository _repository;

  @override
  ResultFuture<List<ProductSale>> call() async => await _repository.getSales();
}
