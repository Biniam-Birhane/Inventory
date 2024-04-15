import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';

abstract class CustomerRepository {
  const CustomerRepository();

  ResultVoid addCustomer({required String name, required String phoneNumber});
  ResultVoid updateCustomer(
      {required String id, required String name, required String phoneNumber});
  ResultVoid deleteCustomer({required String id});
  ResultFuture<List<CustomerEntity>> getCustomers();
}
