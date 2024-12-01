import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper11.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class MoviesMBloc extends Bloc<MoviesMEvents,MoviesMStates>{
  MoviesMBloc():super(MoviesMStates()){
    on<getMoviesMDataEvent>(_getMoviesMData);
  }

  List<MovieM> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;
  int currentPage=2;


  Future<void> _getMoviesMData(getMoviesMDataEvent event, Emitter<MoviesMStates> emit) async {
    if(isFromLoading){
      isFromLoading=false;
      isFromPagination=true;
      emit(MoviesMLoadingState());
    }else if(isFromPagination){
      emit(MoviesMPaginationState(msg: "More data loading ..."));
    }

    final response=await DioHelper11.get("discover/movie",data: {
      "api_key": Constants.MoviesMApiKey,
      "page":currentPage
    });

    if(response.isSucess){
      final movies=MoviesMData.fromJson(response.data);

      //if(movies.totalPages > currentPage){
      if(10 > currentPage){
        currentPage ++;
        _list.addAll(movies.movies);
        emit(MoviesMSuccessState(moviesList: _list));
      }else{
        emit(MoviesMPaginationFinsihedState(msg: "No more data!"));
      }
    }else{
      log(response.msg);
      emit(MoviesMFailedState(msg: response.msg));
    }
  }
}