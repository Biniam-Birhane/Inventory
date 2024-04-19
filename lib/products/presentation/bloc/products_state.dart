part of 'products_bloc.dart';

class ProductsState extends Equatable {
  const ProductsState(
      {this.getProductsStatus = FormzSubmissionStatus.initial,
      this.addProductStatus = FormzSubmissionStatus.initial,
      this.updateProductStatus = FormzSubmissionStatus.initial,
      this.deleteProductStatus = FormzSubmissionStatus.initial,
      this.products = const <ProductEntity>[],
      this.errorMessage = ''});

  final FormzSubmissionStatus getProductsStatus;
  final FormzSubmissionStatus addProductStatus;
  final FormzSubmissionStatus updateProductStatus;
  final FormzSubmissionStatus deleteProductStatus;
  final List<ProductEntity> products;
  final String errorMessage;

  ProductsState copyWith(
      {FormzSubmissionStatus? getProductsStatus,
      FormzSubmissionStatus? addProductStatus,
      FormzSubmissionStatus? updateProductStatus,
      FormzSubmissionStatus? deleteProductStatus,
      List<ProductEntity>? products,
      String? errorMessage}) {
    return ProductsState(
        getProductsStatus: getProductsStatus ?? this.getProductsStatus,
        addProductStatus: addProductStatus ?? this.addProductStatus,
        updateProductStatus: updateProductStatus ?? this.updateProductStatus,
        deleteProductStatus: deleteProductStatus ?? this.deleteProductStatus,
        products: products ?? this.products,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        getProductsStatus,
        addProductStatus,
        updateProductStatus,
        deleteProductStatus,
        products,
        errorMessage
      ];
}

class ProductsInitial extends ProductsState {}
