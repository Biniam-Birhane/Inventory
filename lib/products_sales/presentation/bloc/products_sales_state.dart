part of 'products_sales_bloc.dart';

class ProductsSalesState extends Equatable {
  const ProductsSalesState(
      {this.addSalesStatus = FormzSubmissionStatus.initial,
      this.deleteSalesStatus = FormzSubmissionStatus.initial,
      this.updateSalesStatus = FormzSubmissionStatus.initial,
      this.getSalesStatus = FormzSubmissionStatus.initial,
      this.sales = const <ProductSale>[],
      this.errorMessage = ''});
  final FormzSubmissionStatus addSalesStatus;
  final FormzSubmissionStatus deleteSalesStatus;
  final FormzSubmissionStatus updateSalesStatus;
  final FormzSubmissionStatus getSalesStatus;
  final List<ProductSale> sales;
  final String errorMessage;

  ProductsSalesState copyWith(
      {FormzSubmissionStatus? addSalesStatus,
      FormzSubmissionStatus? deleteSalesStatus,
      FormzSubmissionStatus? updateSalesStatus,
      FormzSubmissionStatus? getSalesStatus,
      List<ProductSale>? sales,
      String? errorMessage}) {
    return ProductsSalesState(
        addSalesStatus: addSalesStatus ?? this.addSalesStatus,
        deleteSalesStatus: deleteSalesStatus ?? this.deleteSalesStatus,
        updateSalesStatus: updateSalesStatus ?? this.updateSalesStatus,
        getSalesStatus: getSalesStatus ?? this.getSalesStatus,
        sales: sales ?? this.sales,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [
        sales,
        addSalesStatus,
        getSalesStatus,
        deleteSalesStatus,
        updateSalesStatus,
        errorMessage
      ];
}
