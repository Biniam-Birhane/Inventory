import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';

class GetProductCategoryUsecase
    extends UsecasesWithoutParams<List<ProductCategoryEntity>> {
  GetProductCategoryUsecase(this.repository);
  final ProductCategoryRepository repository;

  @override
  ResultFuture<List<ProductCategoryEntity>> call() async =>
      await repository.getProductCategory();
}
