import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';

class UpdateCustomer extends UsecaseWithParams<void, UpdateCustomerParams> {
  UpdateCustomer(this._repository);
  final CustomerRepository _repository;

  @override
  ResultVoid call(UpdateCustomerParams params) async =>
      _repository.updateCustomer(
        id: params.id,
        name: params.name,
        phoneNumber: params.phoneNumber,
      );
}

class UpdateCustomerParams extends Equatable {
  const UpdateCustomerParams(
      {required this.id, required this.name, required this.phoneNumber});
  final String id;
  final String name;
  final String phoneNumber;

  @override
  List<Object> get props => [name, phoneNumber];
}
