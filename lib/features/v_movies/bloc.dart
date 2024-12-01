import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper13.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

List<VMovieModel> _list=[];
int currentPage=1;
bool isFromLoading =true;
bool isFromPagination=false;

class VMoviesBloc extends Bloc<VMoviesEvents,VMoviesStates>{
  VMoviesBloc():super(VMoviesStates()){
    on<getVMoviesDataEvent>(_getVMoviesData);
  }
  

  Future<void> _getVMoviesData(getVMoviesDataEvent event, Emitter<VMoviesStates> emit) async {
    if(isFromLoading){
      emit(VMoviesLoadingState());
      isFromLoading=false;
      isFromPagination=true;
    }else if(isFromPagination){
      emit(VMoviesPaginationState("More data loading ..."));
    }
    
    final response=await DioHelper13.get("discover/movie",data: {
      "api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "page":currentPage
    });

    if(response.isSucess){
      final model=VMoviesData.fromJson(response.data);

      //if(model.totalPages > currentPage){
      if(5 > currentPage){
        currentPage ++;
        _list.addAll(model.movies);
        emit(VMoviesSuccessState(moviesList: _list));
      }else{
        emit(VMoviesPaginationFinishedState("No more data!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(VMoviesFailedState(msg: response.msg));
    }
  }
}