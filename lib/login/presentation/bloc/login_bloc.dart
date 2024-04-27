import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_inventory/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUsecase loginUsecase,
  })  : _loginUsecase = loginUsecase,
        super(LoginInitial()) {
    on<LoginRequestedEvent>(_loginHandler);
    on<LogOut>(_logOutHandler);
  }
  final LoginUsecase _loginUsecase;
  Future<void> _loginHandler(
      LoginRequestedEvent event, Emitter<LoginState> emit) async {
    emit(LoginRequesting());
    final result = await _loginUsecase(
        LoginParams(username: event.username, password: event.password));

    result.fold((failure) {
      print(failure);
      emit(const LoginError(errorMessage: "Invalid user credentials"));
    }, (token) => emit(LoggedIn(username: event.username, token: token)));
    // print("ghjk");
  }

  Future<void> _logOutHandler(LogOut event, Emitter<LoginState> emit) async {
    // emit(LoggingOut());
    emit(LoggedOut());
  }
}
