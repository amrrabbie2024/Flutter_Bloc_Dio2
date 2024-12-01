import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper10.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class TWeatherBloc extends Bloc<TWeatherEvents,TWeatherStates>{
  TWeatherBloc():super(TWeatherWelcomeState()){
    on<getTWeatherDataEvent>(_getWeatherData);
  }


  Future<void> _getWeatherData(getTWeatherDataEvent event, Emitter<TWeatherStates> emit) async {

    final response=await DioHelper10.get("forecast.json",data: {
      "key":"eb0315b46a6f4e00af9152404242407",
      "q":event.city,
      "days":1,
      "aqi":"no",
      "alerts":"no"
    });

    if(response.isSucess){
      final weather=TWeatherData.fromJson(response.data);



      if(weather.forecast.forecastday[0].day.avgtempC > 25){
        emit(TWeatherHotState());
      }else{
        emit(TWeatherNotHotState());
      }

      emit(TWeatherSuccessState(weatherData: weather));

    }else{
      print("Error:- ${response.msg}");
      emit(TWeatherFailedState(msg: response.msg));
    }
  }
}