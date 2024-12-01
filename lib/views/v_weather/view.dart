

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/v_weather/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

part 'compoents/initial_view.dart';
part 'compoents/main_weather.dart';
part 'compoents/weather_list.dart';

class VWeatherView extends StatefulWidget {
  const VWeatherView({super.key});

  @override
  State<VWeatherView> createState() => _VWeatherViewState();
}

bool isVisible=false;
final gbloc=GetIt.I<VWeatherBloc>();
Color color=Colors.white;

class _VWeatherViewState extends State<VWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        title: Text("Weather app",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.w),
            child: IconButton(onPressed: () {
              setState(() {
                isVisible=!isVisible;
              });
            }, icon: Icon(Icons.search_sharp,color: Theme.of(context).primaryColor,)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 16.h),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(visible: isVisible,child: TextFormField(
                onFieldSubmitted: (value) {
                  if(value!=null)
                  gbloc.add(getVWeatherDataEvent(q: value));
                  else
                    showMessage("Must enter city name");
                },
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  prefix: Icon(Icons.search_sharp,color: Theme.of(context).primaryColor,),
                  alignLabelWithHint: true,
                  hintText: "type here city name",
                  labelText: "City name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: Theme.of(context).primaryColor)
                  ),
                  enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.blue)
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.orange)
                  ),
                ),
              )),
              SizedBox(height: isVisible?12.h:0,),
              BlocConsumer(
                bloc: gbloc,
                buildWhen: (previous, current) => current is! VWeatherHotState || current is! VWeatherNotHotState,
                listener: (context, state) {
                  if(state is VWeatherFailedState) {
                    showMessage(state.msg);
                    color=Colors.black;
                    isVisible=false;
                    setState(() {});
                  }
                  else if(state is VWeatherSuccessState) {
                    showMessage("Success", isSucess: true);
                    isVisible=false;
                    setState(() {});
                  }
                  else if(state is VWeatherHotState){
                    color=Colors.yellow;
                    setState(() {});
                  }else if(state is VWeatherNotHotState){
                    color=Colors.grey;
                    setState(() {});
                  }

                },
                builder: (context, state) {
                  if(state is VWeatherFailedState)
                    return Expanded(child: Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),)));
                  else if(state is VWeatherSuccessState)
                    return MainWeatherSection(data: state.data,);
                  else if(state is VWeatherLoadingState)
                    return Expanded(child: Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor,radius: 35.r,)));
                  else
                    return InitialView();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
