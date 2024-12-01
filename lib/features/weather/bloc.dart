import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper4.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class WeatherBloc extends Bloc<WeatherEvents,WeatherStates>{
  WeatherBloc():super(WeatherStates()){
    on<getWeatherDataEvent>(_getWeather);
  }
  

  Future<void> _getWeather(getWeatherDataEvent event, Emitter<WeatherStates> emit) async {
    emit(WeatherLoadingState());
    
    final response=await DioHelper4.get("weather",data: {
      "q":event.q,
      "appid":"509dc5d730ff2dd6003b22f30ae93313"
    });

    if(response.isSucess){
      final model=WeatherData.fromJson(response.data);
      emit(WeatherSuccessState(weatherData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(WeatherFailedState(msg: response.msg));
    }
  }
}