import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_apis_pagination/core/logic/http_helper.dart';

part 'states.dart';
part 'events.dart';
part 'model.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvents,UpdateProductStates>{
  UpdateProductBloc():super(UpdateProductStates()){
    on<putUpdateProductEvent>(_updateProduct);
  }
  

  Future<void> _updateProduct(putUpdateProductEvent event, Emitter<UpdateProductStates> emit) async {
    emit(UpdateProductLoadingState());
    
    final response=await HttpHelper().put(url: "products/${event.id}",body: {
      "title":event.title,
      "price":event.price,
      "description":event.description,
      "image":event.image,
      "category":event.category
    });

    if(response!= null){
      final model=UpdateProductData.fromJson(response);
      emit(UpdateProductSuccessState(data: model));
    }else{
      emit(UpdateProductFailedState(msg: "There is an error ,try again"));
    }
  }
}