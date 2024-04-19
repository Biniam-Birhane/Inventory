import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';

class UpdateProductUsecase
    extends UsecaseWithParams<void, UpdateProductUsecaseParams> {
  UpdateProductUsecase(this.repository);
  final ProductRepository repository;
  @override
  ResultVoid call(UpdateProductUsecaseParams params) async =>
      await repository.updateProduct(product: params.product);
}

class UpdateProductUsecaseParams extends Equatable {
  const UpdateProductUsecaseParams({required this.product});
  final ProductEntity product;

  List<Object> get props => [product];
}
