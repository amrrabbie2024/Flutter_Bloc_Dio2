import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper18.dart';


part 'states.dart';
part 'events.dart';
part 'model.dart';

class ALoginBloc extends Bloc<ALoginEvents,ALoginStates>{
  ALoginBloc():super(ALoginStates()){
    on<PostALoginEvent>(_postALogin);
  }
  

  Future<void> _postALogin(PostALoginEvent event, Emitter<ALoginStates> emit) async {

    emit(ALoginLoadingState());

    final response=await DioHelper20.send("login",data: {
      "phone":event.phone,
      "password":event.password,
      "type":"android",
      "device_token":"test",
      "user_type":"client"
    });

    if(response.isSucess){
      final model=ALoginData.fromJson(response.data);
      emit(ALoginSuccessState(loginData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(ALoginFailedState(msg: response.msg));
    }
  }
}