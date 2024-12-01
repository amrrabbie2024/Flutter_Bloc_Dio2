import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper9.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class NRegsisterBloc extends Bloc<NRegsisterEvents,NRegsisterStates>{
  NRegsisterBloc():super(NRegsisterStates()){
    on<getNRegsisterDataEvent>(_getNRegsisterData);
  }


  Future<void> _getNRegsisterData(getNRegsisterDataEvent event, Emitter<NRegsisterStates> emit) async {
    emit(NRegsisterLoadingState());

    final response=await DioHelper9.send("client_register",data: {
      "fullname":event.fullname,
      "password":event.password,
      "password_confirmation":event.password_confirmation,
      "phone":event.phone,
      "country_id":1,
      "city_1":7
    });

    if(response.isSucess){
      final model=NRegsisterData.fromJson(response.data);
      emit(NRegsisterSuccessState(regsisterData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(NRegsisterFailedState(msg: response.msg));
    }
  }
}