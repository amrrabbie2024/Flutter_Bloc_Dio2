import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper17.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class ZMovieDetailsBloc extends Bloc<ZMovieDetailsEvents,ZMovieDetailsStates>{
  ZMovieDetailsBloc():super(ZMovieDetailsLoadingState()){
    on<GetZMovieDetailsDataEvent>(_getZMovieDEtails);
  }
  

  Future<void> _getZMovieDEtails(GetZMovieDetailsDataEvent event, Emitter<ZMovieDetailsStates> emit) async {
    
    final response=await DioHelper17.get("movie/${event.id}",data: {
      "api_key":"2001486a0f63e9e4ef9c4da157ef37cd"
    });

    if(response.isSucess){
      final model=ZMovieDetailsData.fromJson(response.data);
      emit(ZMovieDetailsSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(ZMovieDetailsFailedState(msg: response.msg));
    }
  }
}