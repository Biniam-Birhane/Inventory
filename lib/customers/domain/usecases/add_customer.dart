import 'package:equatable/equatable.dart';
import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';

class AddCustomer extends UsecaseWithParams<void, AddCustomerParams> {
  AddCustomer(this._repository);
  final CustomerRepository _repository;

  @override
  ResultVoid call(AddCustomerParams params) async => await _repository.addCustomer(
        name: params.name,
        phoneNumber: params.phoneNumber,
      );
}

class AddCustomerParams extends Equatable {
  const AddCustomerParams({required this.name, required this.phoneNumber});
  final String name;
  final String phoneNumber;

  @override
  List<Object> get props => [name, phoneNumber];
}
