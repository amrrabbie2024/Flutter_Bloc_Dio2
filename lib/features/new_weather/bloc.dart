import 'dart:async';

import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper7.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class MWeatherBloc extends Bloc<MWeatherEvents,MWeatherStates>{
  MWeatherBloc():super(MWeatherStates()){
    on<getMWeatherDataEvent>(_getWeatherData);
  }
  

  Future<void> _getWeatherData(getMWeatherDataEvent event, Emitter<MWeatherStates> emit) async {
    emit(MWeatherLoadingState());
    
    final response=await DioHelper7.get("forecast.json",data: {
      "key":Constants.MWeatherKey,
      "q":event.q,
      "days":1,
      "aqi":"no",
      "alerts":"no"
    });

    if(response.isSucess){
      final model=MWeatherData.fromJson(response.data);
      emit(MWeatherSuccessState(mWeatherData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(MWeatherFailedState(msg: response.msg));
    }
  }
}