import 'package:simple_inventory/core/usecases/usecases.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';

class GetCustomers extends UsecasesWithoutParams<List<CustomerEntity>> {
  const GetCustomers(this._repository);
  final CustomerRepository _repository;

  @override
  ResultFuture<List<CustomerEntity>> call() async => _repository.getCustomers();
}
