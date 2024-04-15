import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';

class DeleteCustomer extends UsecaseWithParams<void, DeleteCustomerParams> {
  DeleteCustomer(this._repository);
  final CustomerRepository _repository;

  @override
  ResultVoid call(DeleteCustomerParams params) async =>
      _repository.deleteCustomer(id: params.id);
}

class DeleteCustomerParams extends Equatable {
  const DeleteCustomerParams({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
