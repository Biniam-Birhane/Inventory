import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsInitial()) {
    on<ItemsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

