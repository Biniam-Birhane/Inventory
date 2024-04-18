import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';

class AddSale extends UsecaseWithParams<void, AddSaleParams> {
  const AddSale(this._repository);

  final SalesRepository _repository;

  @override
  ResultVoid call(AddSaleParams params) async =>
      await _repository.addSale(productSale: params.productSale);
}

class AddSaleParams extends Equatable {
  const AddSaleParams({required this.productSale});

  final ProductSale productSale;

  @override
  List<Object> get props => [productSale];
}
