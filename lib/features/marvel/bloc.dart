import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper25.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class MarvelBloc extends Bloc<MarvelEvents,MarvelStates>{
  MarvelBloc():super(MarvelStates()){
    on<GetMarvelDataEvent>(_getMarvelData);
  }

  List<MarvelModel> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;
  int limit =10;


  Future<void> _getMarvelData(GetMarvelDataEvent event, Emitter<MarvelStates> emit) async {

    if(isFromLoading){
      isFromLoading=false;
      isFromPagination=true;
      emit(MarvelLoadingState());
    }else if(isFromPagination){
      emit(MarvelPaginationState(msg: "More data loading ..."));
    }

    final response=await DioHelper25.get("characters",data: {
      "apikey":"ff99b2451d5cd421f8e1d63b593e50d6",
      "hash":"47b2c7d86a52d3663db5c0e996d4a887",
      "ts":1,
      "limit":limit
    });

    if(response.isSucess){
      final model=MarvelData.fromJson(response.data);

      if(limit < 100){
        limit+=10;
        _list.addAll(model.data.marvels);
        emit(MarvelSuccessState(marvelsList: _list));
      }else{
        emit(MarvelPaginationFinishedState(msg: "No more data avaiable !"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(MarvelFailedState(msg: response.msg));
    }
  }
}