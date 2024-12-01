import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper21.dart';


part 'states.dart';
part 'events.dart';
part 'model.dart';

class YMoviesBloc extends Bloc<YMoviesEvents,YMoviesStates>{
  YMoviesBloc():super(YMoviesStates()){
    on<GetYMoviesDataEvent>(_getMoviesData);
  }

  int currentPage=1;
  List<YMovieModel> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;


  Future<void> _getMoviesData(GetYMoviesDataEvent event, Emitter<YMoviesStates> emit) async {
    if(isFromLoading){
      isFromLoading=false;
      isFromPagination=true;
      emit(YMoviesLoadingState());
    }else if(isFromPagination){
      emit(YMoviesPaginationState(msg: "More data loading ..."));
    }

    final response=await DioHelper21.get("discover/movie",data: {
      "api_key":"57e0a42fc4766f9d273c03090ff54a67",
      "page":currentPage
    });

    if(response.isSucess){
      final model=YMoviesData.fromJson(response.data);

      //if(currentPage < model.totalPages){
      if(currentPage < 5){
        currentPage++;
        _list.addAll(model.movies);
        emit(YMoviesSuccessState(moviesList: _list));
      }else{
        emit(YMoviesPaginationFinishedState(msg: "No more data!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(YMoviesFailedState(msg: response.msg));
    }
  }
}