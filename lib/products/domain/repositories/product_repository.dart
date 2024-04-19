import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';

abstract class ProductRepository {
  ResultVoid addProduct({required ProductEntity product});
  ResultVoid updateProduct({required ProductEntity product});
  ResultVoid deleteProduct({required String id});
  ResultFuture<List<ProductEntity>> getProducts();
}
