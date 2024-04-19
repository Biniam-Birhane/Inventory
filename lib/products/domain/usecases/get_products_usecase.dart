import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';

class GetProductsUsecase extends UsecasesWithoutParams {
  GetProductsUsecase(this.repository);
  final ProductRepository repository;

  ResultFuture<List<ProductEntity>> call() async =>
      await repository.getProducts();
}
