import 'package:get_it/get_it.dart';
import 'package:simple_inventory/customers/data/datasources/remote_datasource.dart';
import 'package:simple_inventory/customers/data/repositories/customer_repository_impl.dart';
import 'package:simple_inventory/customers/domain/repositories/customer_repository.dart';
import 'package:simple_inventory/customers/domain/usecases/add_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/delete_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/get_customers.dart';
import 'package:simple_inventory/customers/domain/usecases/update_customer.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/products_sales/data/datasources/remote_sales_datasource.dart';
import 'package:simple_inventory/products_sales/data/repositories/sales_repository_impl.dart';
import 'package:simple_inventory/products_sales/domain/repositories/sales_repository.dart';
import 'package:simple_inventory/products_sales/domain/usecases/add_sale.dart';
import 'package:simple_inventory/products_sales/domain/usecases/delete_sale.dart';
import 'package:simple_inventory/products_sales/domain/usecases/get_sales.dart';
import 'package:simple_inventory/products_sales/domain/usecases/update_sale.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(() => ProductsSalesBloc(
        addSale: sl(), getSales: sl(), deleteSale: sl(), updateSale: sl()))
    ..registerLazySingleton(() => AddSale(sl()))
    ..registerLazySingleton(() => DeleteSale(sl()))
    ..registerLazySingleton(() => UpdateSale(sl()))
    ..registerLazySingleton(() => GetSales(sl()))
    ..registerLazySingleton<SalesRepository>(() => SalesRepositoryImpl(sl()))
    ..registerLazySingleton<RemoteSalesDatasource>(
        () => RemoteSalesDataSourceImpl());

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
