part of 'product_category_bloc.dart';

abstract class ProductCategoryEvent extends Equatable {
  const ProductCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetProductCategoryEvent extends ProductCategoryEvent {
  const GetProductCategoryEvent();
}

class AddProductCategoryEvent extends ProductCategoryEvent {
  const AddProductCategoryEvent(
      {required this.id,
      required this.productName,
      required this.availableAmount});
  final String id;
  final String productName;
  final double availableAmount;
}

class UpdateProductCategoryEvent extends ProductCategoryEvent {
  const UpdateProductCategoryEvent(
      {required this.id,
      required this.productName,
      required this.availableAmount});
  final String id;
  final String productName;
  final double availableAmount;
}

class DeleteProductCategoryEvent extends ProductCategoryEvent {
  const DeleteProductCategoryEvent({required this.id});
  final String id;
}
