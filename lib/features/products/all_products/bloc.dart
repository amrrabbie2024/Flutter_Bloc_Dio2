

import 'package:bloc/bloc.dart';
//import 'package:flutter_apis_pagination/core/logic/dio_helper14.dart';
import 'package:flutter_apis_pagination/core/logic/http_helper.dart';



part 'states.dart';
part 'events.dart';
part 'model.dart';

class AllProductsBloc extends Bloc<AllProductsEvents,AllProductsStates>{
  AllProductsBloc():super(AllProductsStates()){
    on<getAllProductsDataEvent>(_getAllProductsData);
  }
  

  Future<dynamic> _getAllProductsData(getAllProductsDataEvent event, Emitter<AllProductsStates> emit) async {
    emit(ALlProductsLoadingState());
    


    List<dynamic> response=await HttpHelper().get(url: "products");

    if(response.isNotEmpty) {
      List<AllProductsModel> products=[];
      for(int i=0;i<response.length;i++){
        products.add(AllProductsModel.fromJson(response[i]));
      }
      emit(ALlProductsSuccessState(data: products));
    }else{
      //print("Error:- ${response.msg}");
      emit(ALlProductsFailedState(msg: "there is an error,try again"));
    }


  }
}