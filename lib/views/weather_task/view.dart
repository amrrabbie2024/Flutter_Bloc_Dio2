import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/features/weather_task/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/search_section.dart';
part 'compoents/weather_section.dart';
part 'compoents/weather_hours.dart';

class WeatherTaskView extends StatefulWidget {
  const WeatherTaskView({super.key});

  @override
  State<WeatherTaskView> createState() => _WeatherTaskViewState();
}

bool isVisible=false;
Color? color;

class _WeatherTaskViewState extends State<WeatherTaskView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color!=null?color:Colors.white,
      appBar: AppBar(
        backgroundColor: color!=null?color:Colors.white,
        title: Text("Weather app",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,)),
          SizedBox(width: 10.w,),
        ],
      ),
      body:  Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(visible: isVisible,child: SearchSection()),
            Visibility(visible: isVisible,child: SizedBox(height: 16.h,)),
            Expanded(
              child: BlocConsumer(
                bloc: kbloc,
                buildWhen: (previous, current) => current is TWeatherFailedState || current is TWeatherSuccessState || current is TWeatherWelcomeState,
                listener: (context, state) {
                  if(state is TWeatherHotState) {
                      setState(() {
                        color=Colors.yellow;
                      });
                    }else if(state is TWeatherNotHotState){
                    setState(() {
                      color=Colors.grey;
                    });
                  }
                },
                builder: (context, state) {
                  if(state is TWeatherFailedState)
                    return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
                  else if(state is TWeatherSuccessState)
                    return WeatherSection(weatherData: state.weatherData,);
                  else
                    return Center(child: Text("There is no weather data till now",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
