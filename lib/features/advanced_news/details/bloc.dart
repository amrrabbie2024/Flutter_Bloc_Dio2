import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper6.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class AdMovieDetailsBloc extends Bloc<AdMovieDetailsEvents,AdMovieDetailsStates>{
  AdMovieDetailsBloc():super(AdMovieDetailsStates()){
    on<getAdMovieDetailsDataEvent>(_getMovieDetails);
  }
  

  Future<void> _getMovieDetails(getAdMovieDetailsDataEvent event, Emitter<AdMovieDetailsStates> emit) async {

    emit(AdMoviesDetailsLoadingState());



    final response=await DioHelper6.get("movie/${event.id}",data: {
      //"api_key":"2001486a0f63e9e4ef9c4da157ef37cd"
      "api_key":Constants.MoviesApiKey,
    });

    if(response.isSucess){
      Timer(Duration(seconds: 2,),() {

      },);
      final movie=AdMovieDetailsData.fromJson(response.data);
      emit(AdMoviesDetailsSuccessState(movie: movie));
    }else{
      print("Error:- ${response.msg}");
      emit(AdMoviesDetailsFailedState(msg: response.msg));
    }




  }

}