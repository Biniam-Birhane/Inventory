import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reports_event.dart';
part 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  ReportsBloc() : super(ReportsInitial()) {
    on<ReportsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
