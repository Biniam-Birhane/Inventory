import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/entities/product_sales.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';

class UpdateSale extends UsecaseWithParams<void, UpdateSaleParams> {
  const UpdateSale(this._repository);

  final SalesRepository _repository;

  @override
  ResultVoid call(UpdateSaleParams params) async =>
      await _repository.updateSale(productSale: params.productSale);
}

class UpdateSaleParams extends Equatable {
  const UpdateSaleParams({required this.productSale});

  final ProductSale productSale;

  @override
  List<Object> get props => [productSale];
}
