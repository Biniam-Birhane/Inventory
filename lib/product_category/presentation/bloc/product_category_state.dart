part of 'product_category_bloc.dart';

abstract class ProductCategoryState extends Equatable {
  const ProductCategoryState();  

  @override
  List<Object> get props => [];
}
class ProductCategoryInitial extends ProductCategoryState {}
