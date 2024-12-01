import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/w_weather/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/weather.dart';

class WWeatherView extends StatefulWidget {
  const WWeatherView({super.key});

  @override
  State<WWeatherView> createState() => _WWeatherViewState();
}

final cityController=TextEditingController(text: "");

final kbloc=KiwiContainer().resolve<WWeatherBloc>();
bool isVisible=false;

class _WWeatherViewState extends State<WWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Weather app"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 28),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(Icons.search_sharp,color: Theme.of(context).primaryColor,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                visible: isVisible,
                child: SizedBox(
                  height: 60.h,
                  child: TextField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "City name",
                      labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      hintText: "type here city name",
                      hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                      suffix: IconButton(onPressed: () {
                        if(cityController.text.isNotEmpty){
                          kbloc.add(getWWeatherDataEvent(q: cityController.text));
                        }else{
                          showMessage("Must enter city name");
                        }
                      }, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,size: 32.r,)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide(color: Theme.of(context).primaryColor)
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: isVisible?16.h:0,),
              Expanded(
                child: BlocConsumer(
                  bloc: kbloc,
                  listener: (context, state) {
                    if(state is WWeatherFailedState)
                      showMessage(state.msg);
                    else if(state is WWeatherSuccessState)
                      showMessage("Success",isSucess: true);
                  },
                  builder: (context, state) {
                    if(state is WWeatherFailedState)
                      return Center(child: Text(state.msg,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 28,fontWeight: FontWeight.bold),));
                    else if(state is WWeatherSuccessState)
                      return WeatherSection(data: state.data,);
                    else if(state is WWeatherLoadingState)
                      return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,strokeWidth: 8,));
                   /* else if(state is WWeatherInitalState)
                      return Center(child: Text(state.msg!,style: TextStyle(color: Colors.orange,fontSize: 28,fontWeight: FontWeight.bold),));*/
                    else
                      return Center(child: Text("There is no weather data,\nplease search with your city",style: TextStyle(color: Colors.orange,fontSize: 28,fontWeight: FontWeight.bold),));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
