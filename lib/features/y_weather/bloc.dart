import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper24.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class YWeatherBloc extends Bloc<YweatherEvents,YWeatherStates>{
  YWeatherBloc():super(YWeatherInitialState("There is no data")){
    on<GetYWeatherDataEvent>(_getWeatherData);
  }


  Future<void> _getWeatherData(GetYWeatherDataEvent event, Emitter<YWeatherStates> emit) async {
    emit(YWeatherLoadingState());

    final response=await DioHelper24.get("forecast.json",data: {
      "key":Constants.YWeatherKey,
      "q":event.q,
      "days":event.days
    });

    if(response.isSucess){
      final model=YWeatherData.fromJson(response.data);

      if(model.current.tempC > 20){
        emit(YWeatherShinyState());
      }else{
        emit(YWeatherNotShinyState());
      }
      emit(YWeatherSuccessState(weatherData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(YWeatherFailedState(msg: response.msg));
    }
  }
}