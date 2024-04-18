part of 'products_sales_bloc.dart';

abstract class ProductsSalesEvent extends Equatable {
  const ProductsSalesEvent();

  @override
  List<Object> get props => [];
}

class AddSalesEvent extends ProductsSalesEvent {
  const AddSalesEvent({required this.productSale});

  final ProductSale productSale;

  @override
  List<Object> get props => [productSale];
}

class UpdateSaleEvent extends ProductsSalesEvent {
  const UpdateSaleEvent({required this.productSale});
  final ProductSale productSale;
  @override
  List<Object> get props => [productSale];
}

class DeleteSaleEvent extends ProductsSalesEvent {
  const DeleteSaleEvent({required this.id});
  final String id;
  @override
  List<Object> get props => [id];
}

class GetSalesEvent extends ProductsSalesEvent {}
