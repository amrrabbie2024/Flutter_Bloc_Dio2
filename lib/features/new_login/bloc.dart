import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper9.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class NLoginBloc extends Bloc<NLoginEvents,NLoginStates>{
  NLoginBloc():super(NLoginStates()){
    on<getNLoginDataEvent>(_getNLoginData);
  }


  Future<void> _getNLoginData(getNLoginDataEvent event, Emitter<NLoginStates> emit) async {
    emit(NLoginLoadingState());

    final response=await DioHelper9.send("login",data: {
      "phone":event.phone,
      "password":event.password,
      "type":"android",
      "device_token":"test",
      "user_type":"client"
    });

    if(response.isSucess){
      final model=NLoginData.fromJson(response.data);
      emit(NLoginSuccessState(loginModel: model.data));
    }else{
      print("Error:- ${response.msg}");
      emit(NLoginFailedState(msg: response.msg));
    }
  }
}