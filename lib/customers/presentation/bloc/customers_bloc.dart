import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customers_event.dart';
part 'customers_state.dart';

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  CustomersBloc() : super(CustomersInitial()) {
    on<CustomersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
