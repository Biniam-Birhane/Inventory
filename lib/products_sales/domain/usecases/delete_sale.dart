import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';

class DeleteSale extends UsecaseWithParams<void, DeleteSaleParams> {
  const DeleteSale(this._repository);

  final SalesRepository _repository;

  @override
  ResultVoid call(DeleteSaleParams params) async =>
      await _repository.deleteSale(id: params.id);
}

class DeleteSaleParams extends Equatable {
  const DeleteSaleParams({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
