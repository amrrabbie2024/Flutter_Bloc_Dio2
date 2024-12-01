import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/http_helper.dart';
import 'package:flutter_apis_pagination/features/products/all_products/bloc.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class AllCategoriesBloc extends Bloc<AllCategoriesEvents,AllCategoriesStates>{
  AllCategoriesBloc():super(AllCategoriesLoadingState()){
    on<getAllCategoriesDataEvent>(_getAllCategoriesData);
  }
  

  Future<void> _getAllCategoriesData(getAllCategoriesDataEvent event, Emitter<AllCategoriesStates> emit) async {
    
    List<dynamic> response=await HttpHelper().get(url: "products/categories");


    if(response.isNotEmpty){
      List<String> categoriesList = List<String>.from(response as List);
      emit(AllCategoriesSuccessState(categories: categoriesList));
    }else{
      emit(AllCategoriesFailedState(msg: "There is an error"));
    }

  }
}