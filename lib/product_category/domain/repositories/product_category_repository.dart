import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';

abstract class ProductCategoryRepository {
  const ProductCategoryRepository();
  ResultVoid addProductCategory(
      {required String id,
      required String productName,
      // required double availableAmount,required double unitPrice
      });
  ResultVoid updateProductCategory(
      {required String id,
      required String productName,
      // required double availableAmount,required double unitPrice
      });
  ResultVoid deleteProductCategory({required String id});
  ResultFuture<List<ProductCategoryEntity>> getProductCategory();
}
