import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper14.dart';

import '../../core/logic/dio_helper15.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class VWeatherBloc extends Bloc<VWeatherEvents,VWeatherStates>{
  VWeatherBloc():super(VWeatherInitialState()){
    on<getVWeatherDataEvent>(_getVWeatherData);
  }


  Future<void> _getVWeatherData(getVWeatherDataEvent event, Emitter<VWeatherStates> emit) async {
    emit(VWeatherLoadingState());

    final response=await DioHelper15.get("forecast.json",data: {
      "key":Constants.VWeatherKey,
      "q":event.q,
      "days":1,
      "aqi":"no",
      "alerts":"no"
    });

    if(response.isSucess){
      final model=VWeatherData.fromJson(response.data);
      if(model.forecast.forecastday[0].day.avgtempC > 25){
        emit(VWeatherHotState());
      }else{
        emit(VWeatherNotHotState());
      }
      emit(VWeatherSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(VWeatherFailedState(msg: response.msg));
    }
  }
}