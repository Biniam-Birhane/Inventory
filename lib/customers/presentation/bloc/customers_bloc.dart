import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/core/utils/typedef.dart';
import 'package:simple_inventory/customers/domain/entities/customer_entity.dart';
import 'package:simple_inventory/customers/domain/usecases/add_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/delete_customer.dart';
import 'package:simple_inventory/customers/domain/usecases/get_customers.dart';
import 'package:simple_inventory/customers/domain/usecases/update_customer.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc({
    required AddCustomer addCustomer,
    required GetCustomers getCustomers,
    required DeleteCustomer deleteCustomer,
    required UpdateCustomer updateCustomer,
  })  : _addCustomer = addCustomer,
        _getCustomers = getCustomers,
        _deleteCustomer = deleteCustomer,
        // _updateCustomer = updateCustomer,
        super(CustomersInitial()) {
    on<AddCustomerEvent>(_addCustomerHandler);
    on<GetCustomersEvent>(_getCustomersHandler);
    on<DeleteCustomerEvent>(_deleteCustomerHandler);
  }
  final AddCustomer _addCustomer;
  final GetCustomers _getCustomers;
  final DeleteCustomer _deleteCustomer;
  // final UpdateCustomer _updateCustomer;

  void _addCustomerHandler(
      AddCustomerEvent event, Emitter<CustomersState> emit) async {
    emit(AddingCustomer());

    final result = await _addCustomer(
        AddCustomerParams(name: event.name, phoneNumber: event.phoneNumber));
    result.fold(
        (failure) => emit(CustomerError(
            errorMessage: failure.errorMessage,
            statusCode: failure.statusCode)),
        (_) => emit(CustomerAdded()));
  }

  void _deleteCustomerHandler(
      DeleteCustomerEvent event, Emitter<CustomersState> emit) async {
    emit(DeletingCustomer());
    final result = await _deleteCustomer(DeleteCustomerParams(id: event.id));
    result.fold(
        (l) => emit(CustomerError(
            errorMessage: l.errorMessage, statusCode: l.statusCode)),
        (r) => emit(CustomerDeleted()));
  }

  Future<void> _getCustomersHandler(
      GetCustomersEvent event, Emitter<CustomersState> emit) async {
    emit(GettingCustomers());

    final result = await _getCustomers();
    result.fold(
        (failure) => emit(CustomerError(
            errorMessage: failure.errorMessage,
            statusCode: failure.statusCode)),
        (customers) => emit(CustomersLoaded(customers: customers)));
  }
}
