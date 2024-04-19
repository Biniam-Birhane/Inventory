part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends ProductsEvent {
  const AddProductEvent({required this.product});
  final ProductEntity product;
}

class UpdateProductEvent extends ProductsEvent {
  const UpdateProductEvent({required this.product});
  final ProductEntity product;
}

class DeleteProductEvent extends ProductsEvent {
  const DeleteProductEvent({required this.id});
  final String id;
}

class GetProductsEvent extends ProductsEvent {
  const GetProductsEvent();
}
