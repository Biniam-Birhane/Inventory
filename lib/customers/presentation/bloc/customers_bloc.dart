import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
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
        _updateCustomer = updateCustomer,
        super(const CustomersState()) {
    on<AddCustomerEvent>(_addCustomerHandler);
    on<GetCustomersEvent>(_getCustomersHandler);
    on<DeleteCustomerEvent>(_deleteCustomerHandler);
    on<UpdateCustomerEvent>(_updateCustomerHandler);
  }
  final AddCustomer _addCustomer;
  final GetCustomers _getCustomers;
  final DeleteCustomer _deleteCustomer;
  final UpdateCustomer _updateCustomer;

  void _addCustomerHandler(
      AddCustomerEvent event, Emitter<CustomersState> emit) async {
    emit(state.copyWith(addCustomerstatus: FormzSubmissionStatus.inProgress));

    final result = await _addCustomer(
        AddCustomerParams(name: event.name, phoneNumber: event.phoneNumber));
    result.fold(
        (failure) => emit(state.copyWith(
            addCustomerstatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (_) => emit(
            state.copyWith(addCustomerstatus: FormzSubmissionStatus.success)));
  }

  void _deleteCustomerHandler(
      DeleteCustomerEvent event, Emitter<CustomersState> emit) async {
    emit(
        state.copyWith(deleteCustomerStatus: FormzSubmissionStatus.inProgress));
    final result = await _deleteCustomer(DeleteCustomerParams(id: event.id));
    result.fold(
        (failure) => emit(state.copyWith(
            deleteCustomerStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (r) => emit(state.copyWith(
            deleteCustomerStatus: FormzSubmissionStatus.success)));
  }

  Future<void> _getCustomersHandler(
      GetCustomersEvent event, Emitter<CustomersState> emit) async {
    emit(state.copyWith(getCustomerStatus: FormzSubmissionStatus.inProgress));

    final result = await _getCustomers();
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            getCustomerStatus: FormzSubmissionStatus.failure)),
        (customers) => emit(state.copyWith(
            getCustomerStatus: FormzSubmissionStatus.success,
            customers: customers,
            addCustomerstatus: FormzSubmissionStatus.initial,
            updateCustomerstatus: FormzSubmissionStatus.initial,
            deleteCustomerStatus: FormzSubmissionStatus.initial)));
  }

  Future<void> _updateCustomerHandler(
      UpdateCustomerEvent event, Emitter<CustomersState> emit) async {
    emit(
        state.copyWith(updateCustomerstatus: FormzSubmissionStatus.inProgress));
    final result = await _updateCustomer(UpdateCustomerParams(
        id: event.id, name: event.name, phoneNumber: event.phoneNumber));
    result.fold(
        (failure) => emit(state.copyWith(
            errorMessage: failure.errorMessage,
            updateCustomerstatus: FormzSubmissionStatus.failure)),
        (_) => emit(state.copyWith(
            updateCustomerstatus: FormzSubmissionStatus.success)));
  }
}
