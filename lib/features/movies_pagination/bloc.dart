import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class PMoviesBloc extends Bloc<PMoviesEvents,PMoviesStates>{
  PMoviesBloc():super(PMoviesStates()){
    on<pGetMoviesDataEvent>(_getMoviesData);
  }
  
  int currentPage=1;
  List<PMovieModel> _list=[];
  bool isFromPagination=false;
  bool isFirstTime=true;
  

  Future<void> _getMoviesData(pGetMoviesDataEvent event, Emitter<PMoviesStates> emit) async {
    if(isFromPagination){
      emit(PMoviesPaginationState());
    }else{
      if(isFirstTime) {
        emit(PMoviesLoadingState());
      }
    }
    
    final response=await DioHelper2.get("discover/movie",data: {
      "api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "page":currentPage
    });

    if(response.isSucess){
      final model=PMoviesData.fromJson(response.data);


        if(model.totalPages <= currentPage) {
          emit(PMoviesPaginationFinishedState());
        }else{
        isFromPagination=true;
        isFirstTime=false;
        currentPage++;
        _list.addAll(model.movies);
        emit(PMoviesSucessState(movieModel: _list));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(PMoviesFailedState(msg: response.msg));
    }
  }
}