part of 'customers_bloc.dart';

abstract class CustomersEvent extends Equatable {
  const CustomersEvent();

  @override
  List<Object> get props => [];
}

class AddCustomerEvent extends CustomersEvent {
  const AddCustomerEvent({
    required this.name,
    required this.phoneNumber,
  });

  final String name;
  final String phoneNumber;

  @override
  List<Object> get props => [];
}

class GetCustomersEvent extends CustomersEvent {}

class UpdateCustomerEvent extends CustomersEvent {
  const UpdateCustomerEvent(
      {required this.id, required this.name, required this.phoneNumber});
  final String id;
  final String name;
  final String phoneNumber;

  @override
  List<Object> get props => [];
}

class DeleteCustomerEvent extends CustomersEvent {
  const DeleteCustomerEvent({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}
