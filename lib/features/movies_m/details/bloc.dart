import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper11.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class MovieMDetailsBloc extends Bloc<MovieMDetailsEvents,MovieMDetailsStates>{
  MovieMDetailsBloc():super(MovieMDetailsStates()){
    on<getMovieMDetailsDataEvent>(_getMovieMDetails);
  }
  

  Future<void> _getMovieMDetails(getMovieMDetailsDataEvent event, Emitter<MovieMDetailsStates> emit) async {
    emit(MovieMDetailsLoadingState());

    await Future.delayed(Duration(milliseconds: 500));

    final response=await DioHelper11.get("movie/${event.id}",data: {
      "api_key":Constants.MoviesMApiKey
    });

    if(response.isSucess){
      final model=MovieMDetailsData.fromJson(response.data);
      emit(MovieMDetailsSuccessState(details: model));
    }else{
      print("Error:- ${response.msg}");
      emit(MovieMDetailsFailedState(msg: response.msg));
    }
    



  }
}