import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper12.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/logic/helper_methods.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class VRegsisterBloc extends Bloc<VRegsisterEvents,VRegsisterStates>{
  VRegsisterBloc():super(VRegsisterStates()){
    on<getVRegsisterDataEvent>(_getVRegsisterData);
  }
  

  Future<void> _getVRegsisterData(getVRegsisterDataEvent event, Emitter<VRegsisterStates> emit) async {
    emit(VRegsisterLoadingState());
    
    final response=await DioHelper12.send("user/signup",data: {
      "name":event.name,
      "phone":event.phone,
      "email":event.email,
      "password":event.password,
      "confirmPassword":event.confirmPassword,
      "location":'{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
      "profilePic": uploadImageToApi(event.profilePic)
    });

    if(response.isSucess){
      final model=VRegsisterData.fromJson(response.data);
      emit(VRegsisterSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(VRegsisterFailedState(msg: response.msg));
    }


  }
}