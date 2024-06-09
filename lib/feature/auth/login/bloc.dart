import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/logic/dio_helper.dart';
import '../../../core/logic/helper_methods.dart';
import '../../../core/unit/app_strings.dart';

part 'events.dart';

part 'states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginStates()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());

    final response = await DioHelper().sendData(
      endPoint: 'auth/login',
      data: event.data,
    );
    //42687539510

    if (response.isSuccess) {
      emit(LoginSuccessState(
        message: response.message,
      ));
    } else {
      emit(LoginFailedState(
        msg: DataString.noAccount,
      ));

    }
  }
}
