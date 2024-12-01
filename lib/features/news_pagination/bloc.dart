import 'dart:async';

import 'package:flutter_apis_pagination/core/logic/dio_helper3.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';
part 'states.dart';
part 'events.dart';

class NewsBloc extends Bloc<NewsEvents,NewsStates>{
  NewsBloc():super(NewsStates()){
    on<getNewsDataEvent>(_getNews);
  }

  List<Articles> _list=[];
  int currentPage=1;
  bool isFromLoading=true;
  bool isFromPagination=false;

  Future<void> _getNews(getNewsDataEvent event, Emitter<NewsStates> emit) async {
    if(isFromLoading)
      emit(NewsLoadingState());
    else if(isFromPagination)
      emit(NewsPaginationState());

    final response=await DioHelper3.get("everything",data: {
      "q":event.q,
      "from":event.from,
      "to":event.to,
      "sortBy":"popularity",
      "apiKey":"391b96a593624603b2a0d9515bb4c269",
      "page":currentPage
    });

    if(response.isSucess){
      if(5 > currentPage) {
        final model = NewsData.fromJson(response.data);
        _list.addAll(model.articles);
        currentPage++;
        isFromLoading = false;
        isFromPagination = true;
        emit(NewsSucessState(articles: _list));
      }else{
        emit(NewsPaginationFinishedState(msg: "No additional data found!"));
      }
    }else{
      print("Error:- ${response.msg}");
      emit(NewsFailedState(msg: response.msg));
    }
  }
}