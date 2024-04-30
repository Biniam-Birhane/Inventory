import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_inventory/login/domain/usecases/add_user.dart';
import 'package:simple_inventory/login/domain/usecases/login_usecase.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginUsecase loginUsecase,
    required AddUser addUser,
  })  : _loginUsecase = loginUsecase,
        _addUser = addUser,
        super(const LoginState()) {
    on<LoginRequestedEvent>(_loginHandler);
    on<AddUserEvent>(_addUserHandler);
    on<LogOutEvent>(_logOutHandler);
  }
  final LoginUsecase _loginUsecase;
  final AddUser _addUser;
  Future<void> _loginHandler(
      LoginRequestedEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: FormzSubmissionStatus.inProgress));
    final result = await _loginUsecase(
        LoginParams(username: event.username, password: event.password));

    result.fold((failure) {
      print(failure);
      emit(state.copyWith(
          loginStatus: FormzSubmissionStatus.failure,
          errorMessage: "Invalid user credentials"));
    },
        (token) => emit(state.copyWith(
            loginStatus: FormzSubmissionStatus.success,
            loggedInUsername: event.username,
            token: token,
            errorMessage: '')));
    // print("ghjk");
  }

  Future<void> _addUserHandler(
      AddUserEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(addUserStatus: FormzSubmissionStatus.inProgress));
    final result = await _addUser(
        AddUserParams(username: event.email, password: event.password));
    result.fold(
        (failure) => emit(state.copyWith(
            addUserStatus: FormzSubmissionStatus.failure,
            errorMessage: failure.errorMessage)),
        (_) => emit(state.copyWith(
            addUserStatus: FormzSubmissionStatus.success, errorMessage: '')));
  }

  Future<void> _logOutHandler(
      LogOutEvent event, Emitter<LoginState> emit) async {
    // emit(LoggingOut());
    emit(state.copyWith(
        logoutStatus: FormzSubmissionStatus.success,
        loginStatus: FormzSubmissionStatus.initial));
  }
}
