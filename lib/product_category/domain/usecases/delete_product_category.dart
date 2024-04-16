import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/product_category/domain/repositories/product_category_repository.dart';

class DeleteProductCategoryUsecase
    extends UsecaseWithParams<void, DeleteCategoryUsecaseParam> {
  DeleteProductCategoryUsecase(this.repository);
  final ProductCategoryRepository repository;
  ResultVoid call(DeleteCategoryUsecaseParam param) async =>
      await repository.deleteProductCategory(id: param.id);
}

class DeleteCategoryUsecaseParam extends Equatable {
  DeleteCategoryUsecaseParam({required this.id});
  final String id;

  List<Object> get props => [id];
}
