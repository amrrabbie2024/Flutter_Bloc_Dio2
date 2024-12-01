import 'dart:async';

import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper6.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class AdMoviesBloc extends Bloc<AdMoviesEvents,AdMoviesStates>{
  AdMoviesBloc():super(AdMoviesStates()){
    on<getAdMoviesDataEvent>(_getMoviesData);
  }

  List<AdMovies> _list=[];
  int currentPage=1;
  bool isFromLoading=true;
  bool isFromPagination=false;
  

  Future<void> _getMoviesData(getAdMoviesDataEvent event, Emitter<AdMoviesStates> emit) async {
    if(isFromLoading){
      emit(AdMoviesPaginationState());
      isFromLoading=false;
      isFromPagination=true;
    }else if(isFromPagination){
      emit(AdMoviesPaginationState(msg: "More data loading ..."));
    }
    
    final response=await DioHelper6.get("discover/movie",data: {
      //"api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "api_key":Constants.MoviesApiKey,
      "page":currentPage
    });

    if(response.isSucess){
      final model=AdMoviesData.fromJson(response.data);
      //if(model.totalPages > currentPage) {
      if(5 > currentPage) {
        currentPage ++;
        _list.addAll(model.movies);
        emit(AdMoviesSuccessState(movies: _list));
      }else{
        emit(AdMoviesPaginationFinshedState(msg: "No more exists ..."));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(AdMoviesFailedState(msg: response.msg));
    }

  }

}