import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';

class AddProductCategoryUsecase
    extends UsecaseWithParams<void, AddProductCategoryParams> {
  AddProductCategoryUsecase(this.repository);
  final ProductCategoryRepository repository;
  ResultVoid call(AddProductCategoryParams params) async =>
      await repository.addProductCategory(
          id: params.id,
          productName: params.productName,
          availableAmount: params.availableAmount,
          unitPrice:params.unitPrice);
}

class AddProductCategoryParams extends Equatable {
  AddProductCategoryParams(
      {required this.id,
      required this.productName,
      required this.availableAmount,required this.unitPrice});
  final String id;
  final String productName;
  final double availableAmount;
  final double unitPrice;

  List<Object> get props => [id, productName, availableAmount];
}
