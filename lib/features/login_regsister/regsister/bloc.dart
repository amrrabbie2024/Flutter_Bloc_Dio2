import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper18.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';


class ASignupBloc extends Bloc<ASignupEvents,ASignupStates>{
  ASignupBloc():super(ASignupStates()){
    on<PostASignupEvent>(_postASignup);
  }
  

  Future<void> _postASignup(PostASignupEvent event, Emitter<ASignupStates> emit) async {
    emit(ASignupLoadingState());
    
    final response=await DioHelper20.send("client_register",data: {
      "fullname":event.fullname,
      "password":event.password,
      "password_confirmation":event.password_confirmation,
      "phone":event.phone,
      "country_id":1,
      "city_1":7
    });

    if(response.isSucess){
      final model=ASignupData.fromJson(response.data);
      emit(ASignupSuccessState(signupData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(ASignupFailedState(msg: response.msg));
    }
  }
}