part of 'customers_bloc.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class AddingCustomer extends CustomersState {}

class GettingCustomers extends CustomersState {}

class CustomerAdded extends CustomersState {}

class DeletingCustomer extends CustomersState {}

class CustomerDeleted extends CustomersState {}

class CustomersLoaded extends CustomersState {
  const CustomersLoaded({required this.customers});
  final List<CustomerEntity> customers;
  @override
  List<Object> get props => [customers];
}

class CustomerError extends CustomersState {
  const CustomerError({required this.errorMessage, required this.statusCode});
  final String errorMessage;
  final int statusCode;

  @override
  List<Object> get props => [errorMessage, statusCode];
}
