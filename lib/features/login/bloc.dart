import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class LoginBloc extends Bloc<LoginEvents,LoginStates>{
  LoginBloc():super(LoginStates()){
    on<GetLoginDataEvent>(_getLogin);
  }


  Future<void> _getLogin(GetLoginDataEvent event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());

    final response=await DioHelper.send("login",data: {
      "phone":event.phone,
      "password":event.password,
      "type":"android",
      "device_token":"test",
      "user_type":"client"
    });

    if(response.isSucess){
      final loginModel=LoginData.fromJson(response.data);
      emit(LoginSuccessState(loginModel: loginModel.model));
    }else{
      print("Error:- ${response.msg}");
      emit(LoginFailedState(msg: response.msg));
    }
  }
}