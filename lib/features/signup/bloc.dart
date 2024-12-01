import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class RegsisterBloc extends Bloc<RegisiterEvents,RegsisterStates>{
  RegsisterBloc():super(RegsisterStates()){
    on<GetRegsisterDataEvent>(_getRegsister);
  }
  

  Future<void> _getRegsister(GetRegsisterDataEvent event, Emitter<RegsisterStates> emit) async {
    emit(RegsisterLoadingState());
    
    final response=await DioHelper.send("client_register",data: {
      "fullname":event.fullname,
      "password":event.password,
      "password_confirmation":event.password_confirmation,
      "phone":event.phone,
      "country_id":1,
      "city_1":7
    });
    
    if(response.isSucess){
      final model=SignupData.fromJson(response.data);
      emit(RegsisterSuccessState(signupData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(RegsisterFailedState(msg: response.msg));
    }
  }
}