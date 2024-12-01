import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/http_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class AddProductBloc extends Bloc<AddProductEvents,AddProductStates>{
  AddProductBloc():super(AddProductStates()){
    on<postAddProductEvent>(_addProduct);
  }
  

  Future<void> _addProduct(postAddProductEvent event, Emitter<AddProductStates> emit) async {
    emit(AddProductLoadingState());
    
    final response=await HttpHelper().post(url: "products",body: {
      "title":event.title,
      "price":event.price,
      "description":event.description,
      "image":event.image,
      "category":event.category
    });

    if(response!=null){
      final model=AddProductData.fromJson(response);
      emit(AddProductSuccessState(data: model));
    }else{
      emit(AddProductFailedState(msg: "There is an error ,try again"));
    }
  }
}