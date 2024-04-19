import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products/domain/repositories/product_repository.dart';

class DeleteProductUsecase
    extends UsecaseWithParams<void, DeleteProductUsecaseParams> {
  DeleteProductUsecase(this.repository);
  final ProductRepository repository;
  @override
  ResultVoid call(DeleteProductUsecaseParams params) async =>
      await repository.deleteProduct(id: params.id);
}

class DeleteProductUsecaseParams extends Equatable {
  const DeleteProductUsecaseParams({required this.id});
  final String id;

  List<Object> get props => [id];
}
