part of 'product_category_bloc.dart';

class ProductCategoryState extends Equatable {
  const ProductCategoryState(
      {this.addProductCategoryStatus = FormzSubmissionStatus.initial,
      this.updateProductCategoryStatus = FormzSubmissionStatus.initial,
      this.getProductCategoryStatus = FormzSubmissionStatus.initial,
      this.deleteProductCategoryStatus = FormzSubmissionStatus.initial,
      this.productCategories = const <ProductCategoryEntity>[],
      this.errorMessage = ''});

  final FormzSubmissionStatus getProductCategoryStatus;
  final FormzSubmissionStatus addProductCategoryStatus;
  final FormzSubmissionStatus updateProductCategoryStatus;
  final FormzSubmissionStatus deleteProductCategoryStatus;
  final List<ProductCategoryEntity> productCategories;
  final String errorMessage;

  ProductCategoryState copyWith(
      {FormzSubmissionStatus? getProductCategoryStatus,
      FormzSubmissionStatus? addProductCategoryStatus,
      FormzSubmissionStatus? updateProductCategoryStatus,
      FormzSubmissionStatus? deleteProductCategoryStatus,
      List<ProductCategoryEntity>? productCategories,
      String? errorMessage}) {
    return ProductCategoryState(
        getProductCategoryStatus:
            getProductCategoryStatus ?? this.getProductCategoryStatus,
        addProductCategoryStatus:
            addProductCategoryStatus ?? this.addProductCategoryStatus,
        updateProductCategoryStatus:
            updateProductCategoryStatus ?? this.updateProductCategoryStatus,
        deleteProductCategoryStatus:
            deleteProductCategoryStatus ?? this.deleteProductCategoryStatus,
        productCategories: productCategories ?? this.productCategories,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        getProductCategoryStatus,
        addProductCategoryStatus,
        updateProductCategoryStatus,
        deleteProductCategoryStatus,
        productCategories,
        errorMessage
      ];
}

class ProductCategoryInitial extends ProductCategoryState {}
