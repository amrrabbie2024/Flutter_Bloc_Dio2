import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper13.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';


class VMovieDetailsBloc extends Bloc<VMovieDetailsEvents,VMovieDetailsStates>{
  VMovieDetailsBloc():super(VMovieDetailsLoadingState()){
    on<getVMovieDetailsDataEvent>(_getVMovieDetailsData);
  }
  

  Future<void> _getVMovieDetailsData(getVMovieDetailsDataEvent event, Emitter<VMovieDetailsStates> emit) async {

    Future.delayed(Duration(milliseconds: 1500),() {

    },);

    Timer(
      Duration(seconds: 1),() {

      },
    );
    
    final response=await DioHelper13.get("movie/${event.id}",data: {
      "api_key":"2001486a0f63e9e4ef9c4da157ef37cd"
    });

    if(response.isSucess){
      final model=VMovieDetailsData.fromJson(response.data);
      emit(VMovieDetailsSuccessState(data: model));
    }else{
      print("Error:- ${response.msg}");
      emit(VMovieDetailsFailedState(msg: response.msg));
    }
  }
}