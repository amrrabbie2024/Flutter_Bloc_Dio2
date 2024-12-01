import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper12.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class VProfileBloc extends Bloc<VProfileEvents,VProfileStates>{
  VProfileBloc():super(VProfileStates()){
    on<getVProfileDataevent>(_getVProfileData);
  }


  Future<void> _getVProfileData(getVProfileDataevent event, Emitter<VProfileStates> emit) async {
    emit(VProfileLoadingState());

    final response=await DioHelper12.get("user/get-user/${event.id}",data: {

    });

    if(response.isSucess){
      final model=VProfileData.fromJson(response.data);
      emit(VProfileSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(VProfileFailedState(msg: response.msg));
    }
  }
}