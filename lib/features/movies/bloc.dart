import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

int currentPage=1;

class MoviesBloc extends Bloc<MoviesEvents,MoviesStates>{
  MoviesBloc():super(MoviesStates()){
    on<getMoviesDataEvent>(_getMoviesData);
  }


  Future<void> _getMoviesData(getMoviesDataEvent event, Emitter<MoviesStates> emit) async {
    emit(MoviesLoadingState());

    final response=await DioHelper2.get("discover/movie",data: {
      "api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "page":currentPage
    });

    if(response.isSucess){
      final model=MoviesData.fromJson(response.data);
      emit(MoviesSucessState(movieModel: model.movies));
    }else{
      print("Error:- ${response.msg}");
      emit(MoviesFailedState(msg: response.msg));
    }
  }
}