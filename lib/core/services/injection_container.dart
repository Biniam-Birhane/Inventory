import 'package:get_it/get_it.dart';
import 'package:simple_inventory/customers/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/customers/data/repositories/customer_repository_impl.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';
import 'package:simple_inventory/customers/domain/usecases/add_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/delete_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/get_customers.dart';
import 'package:simple_inventory/customers/domain/usecases/update_customer.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => CustomersBloc(
          addCustomer: sl(),
          getCustomers: sl(),
          deleteCustomer: sl(),
          updateCustomer: sl(),
        ))
    ..registerLazySingleton(() => AddCustomer(sl()))
    ..registerLazySingleton(() => GetCustomers(sl()))
    ..registerLazySingleton(() => DeleteCustomer(sl()))
    ..registerLazySingleton(() => UpdateCustomer(sl()))
    ..registerLazySingleton<CustomerRepository>(
        () => CustomerRepositoryImpl(sl()))
    ..registerLazySingleton<RemoteDataSource>(() => RemoteCustomerDatasource());
}
