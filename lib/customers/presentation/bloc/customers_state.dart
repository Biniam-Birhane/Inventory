part of 'customers_bloc.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();  

  @override
  List<Object> get props => [];
}
class CustomersInitial extends CustomersState {}
