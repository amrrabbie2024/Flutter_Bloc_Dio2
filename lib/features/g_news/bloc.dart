import 'dart:async';

import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper8.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class GNewsBloc extends Bloc<GNewsEvents,GNewsStates>{
  GNewsBloc():super(GNewsStates()){
    on<getGNewsDataEvent>(_getGNewsData);
  }

  List<GArticles> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;
  int cuurentPage=1;
  String category="general";


  Future<void> _getGNewsData(getGNewsDataEvent event, Emitter<GNewsStates> emit) async {

    if(event.category != category) {
      isFromLoading=true;
      isFromPagination=false;
      cuurentPage=1;
      category=event.category;
    }



    if(isFromLoading){
      isFromLoading=false;
      isFromPagination=true;
      emit(GNewsLoadingState());
    }else if(isFromPagination){
      emit(GNewsPaginationState(msg: "More data loading ..."));
    }

    final response=await DioHelper8.get("top-headlines",data: {
      "category":event.category,
      "lang":"ar",
      "country":"eg",
      "max":20,
      "apikey":Constants.GNewsApiKey,
      "page":cuurentPage
    });

    if(response.isSucess){
      final model=GNewsData.fromJson(response.data);

      if(model.totalArticles/20.ceil() > cuurentPage){
        cuurentPage ++;
        _list.addAll(model.articles);
        emit(GNewsSuccessState(data: _list));
      }else{
        emit(GNewsPaginationFinishedState(msg: "No more data!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(GNewsFailedState(msg: response.msg));
    }



  }
}