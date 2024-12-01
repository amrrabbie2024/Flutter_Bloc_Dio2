import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper17.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

List<ZMovies> _list=[];
int currentPage=1;
bool isFromLoading=true;
bool isFromPagination=false;

class ZMoviesBloc extends Bloc<ZMoviesEvents,ZMoviesStates>{
  ZMoviesBloc():super(ZMoviesStates()){
    on<GetZMovieDataEvent>(_getZMoviesData);
  }


  Future<void> _getZMoviesData(GetZMovieDataEvent event, Emitter<ZMoviesStates> emit) async {
    if(isFromLoading){
      emit(ZMoviesLoadingState());
      isFromLoading=false;
      isFromPagination=true;
    }else{
      emit(ZMoviesPaginationState(msg: "More data is loading ..."));
    }

    final response=await DioHelper17.get("discover/movie",data: {
      "api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "page":currentPage
    });

    if(response.isSucess){
      final model=ZMoviesData.fromJson(response.data);

      //if(model.totalPages > currentPage){
      if(5 > currentPage){
        currentPage++;
        _list.addAll(model.movies);
        emit(ZMoviesSuccessState(moviesList: _list));
      }else{
        emit(ZMoviesPaginationFinishedState(msg: "No more data!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(ZMoviesFailedState(msg: response.msg));
    }
  }
}