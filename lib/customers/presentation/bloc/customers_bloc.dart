import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc() : super(CustomersInitial()) {
    on<AddCustomerEvent>(_addCustomer);
  }

  Future<void> _addCustomer(
      AddCustomerEvent event, Emitter<CustomersState> emit) async {
    try {
      print('xxxxxx');
    } catch (error) {
      print('error');
    }
  }
}
