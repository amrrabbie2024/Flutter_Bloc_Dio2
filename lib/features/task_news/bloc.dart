import 'dart:async';

import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/dio_helper5.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class ANewsBloc extends Bloc<ANewsEvents,ANewsStates>{
  ANewsBloc():super(ANewsStates()){
    on<getANewsDataEvent>(_getANewsData);
  }

  List<AArticles> _list=[];
  bool isFromLoading=true;
  bool isFromPagination=false;
  int currentPage=1;

  String previousCategory="general";
  

  Future<void> _getANewsData(getANewsDataEvent event, Emitter<ANewsStates> emit) async {


    if(previousCategory != event.category){
      currentPage=1;
      _list.clear();
      isFromLoading=true;
      isFromPagination=false;
      previousCategory=event.category;
    }


    if(isFromLoading){
      emit(AnewsLoadingState());
    }else if(isFromPagination){
      emit(AnewsPaginationState(msg: "More data loading ..."));
    }

    
    final response=await DioHelper5.get("top-headlines",data: {
      "country":event.country,
      //"apiKey":"391b96a593624603b2a0d9515bb4c269",
      "apiKey":Constants.NewsApiKey,
      "category":event.category,
      "page":currentPage
    });


    if(response.isSucess){
      final model=ANewsData.fromJson(response.data);

      if((model.totalResults / 20).ceil() >= currentPage){
        isFromLoading=false;
        isFromPagination=true;
        currentPage++;
        _list.addAll(model.articles);
        emit(AnewsSuccessState(articles: _list));
      }else{
        emit(AnewsPaginationFinishedState(msg: "No more data exists ..."));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(AnewsFailedState(msg: response.msg));
    }
  }
}