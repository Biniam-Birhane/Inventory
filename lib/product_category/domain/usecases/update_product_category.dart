import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/entities/product_category.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';

class UpdateProductCategoryUsecase
    extends UsecaseWithParams<void, UpdateProductCategoryParam> {
  UpdateProductCategoryUsecase(this.repository);
  final ProductCategoryRepository repository;

  ResultVoid call(UpdateProductCategoryParam params) async =>
      await repository.updateProductCategory(
          id: params.id,
          productName: params.productName,
          availableAmount: params.availableAmount,
          unitPrice: params.unitPrice);
}

class UpdateProductCategoryParam extends Equatable {
  UpdateProductCategoryParam(
      {required this.id,
      required this.productName,
      required this.availableAmount,required this.unitPrice});
  final String id;
  final String productName;
  final double availableAmount;
  final double unitPrice;

  List<Object> get props => [id, productName, availableAmount];
}
