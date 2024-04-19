import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/entities/product_entitiy.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';

class AddProductUsecase
    extends UsecaseWithParams<void, AddProductUsecaseParams> {
  AddProductUsecase(this.repository);
  final ProductRepository repository;
  @override
  ResultVoid call(AddProductUsecaseParams params) async =>
      await repository.addProduct(product: params.product);
}

class AddProductUsecaseParams extends Equatable {
  const AddProductUsecaseParams({required this.product});
  final ProductEntity product;

  List<Object> get props => [product];
}
