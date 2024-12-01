import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvents,MovieDetailsStates>{
  MovieDetailsBloc():super(MovieDetailsStates()){
    on<getMovieDetailsDataEvent>(_getMovieDetails);
  }
  

  Future<void> _getMovieDetails(getMovieDetailsDataEvent event, Emitter<MovieDetailsStates> emit) async {
    emit(MovieDetailsLoadingState());
    
    final response=await DioHelper2.get("movie/${event.movie_id}",data: {
      "api_key":"2001486a0f63e9e4ef9c4da157ef37cd"
    });

    if(response.isSucess){
      final model=MovieDetailsData.fromJson(response.data);
      emit(MovieDetailsSucessState(movieDetailsData: model));
    }else{
      print("Error:- ${response.msg}");
      emit(MovieDetailsFailedState(msg: response.msg));
    }
  }
}