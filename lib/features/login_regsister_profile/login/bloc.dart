import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper12.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class VLoginBloc extends Bloc<VLoginEvents,VLoginStates>{
  VLoginBloc():super(VLoginStates()){
    on<getVLoginDataEvent>(_getVLoginData);
  }


  Future<void> _getVLoginData(getVLoginDataEvent event, Emitter<VLoginStates> emit) async {
    emit(VLoginLoadingState());

    final response=await DioHelper12.send("user/signin",data: {
      "email":event.email,
      "password":event.password
    });

    if(response.isSucess){
      final model=VLoginData.fromJson(response.data);
      emit(VLoginSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(VLoginFailedState(msg: response.msg));
    }
  }
}