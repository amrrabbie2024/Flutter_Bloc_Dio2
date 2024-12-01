import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper14.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper16.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class WWeatherBloc extends Bloc<WWatherEvents,WWeatherStates>{
  WWeatherBloc():super(WWeatherStates()){
    on<getWWeatherDataEvent>(_getWeatherData);
  }


  Future<void> _getWeatherData(getWWeatherDataEvent event, Emitter<WWeatherStates> emit) async {

    emit(WWeatherLoadingState());

    final response=await DioHelper16.get("weather",data: {
      "q":event.q,
      "appid":Constants.WWeatherApiKey
    });

    if(response.isSucess){
      final model=WWeatherData.fromJson(response.data);
      emit(WWeatherSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(WWeatherFailedState(msg: response.msg));
    }
  }
}