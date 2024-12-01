import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/http_helper.dart';
import 'package:flutter_apis_pagination/features/products/all_products/bloc.dart';

class ProductsByCategoryBloc  extends Bloc<AllProductsEvents,AllProductsStates>{
  ProductsByCategoryBloc():super(AllProductsStates()){
    on<getAllProductsByCategoryDataEvent>(_getProductsByCategory);
  }


  Future<void> _getProductsByCategory(getAllProductsByCategoryDataEvent event, Emitter<AllProductsStates> emit) async {
    emit(ALlProductsLoadingState());
    
    List<dynamic> response=await  HttpHelper().get(url: "products/category/${event.category_name}");

    if(response.isNotEmpty) {
      List<AllProductsModel> products = [];
      for (int i = 0; i < response.length; i++) {
        products.add(AllProductsModel.fromJson(response[i]));
      }
      emit(ALlProductsSuccessState(data: products));
    }else{
      emit(ALlProductsFailedState(msg: "there is an error"));
    }
  }
}