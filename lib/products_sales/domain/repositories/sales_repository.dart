import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';

abstract class SalesRepository {
  const SalesRepository();

  ResultVoid addSale({required ProductSale productSale});
  ResultVoid updateSale({required ProductSale productSale});
  ResultVoid deleteSale({required String id});
  ResultFuture<List<ProductSale>> getSales();
}
