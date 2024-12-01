import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/y_weather/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/hours_section.dart';

class YWeatherView extends StatefulWidget {
  const YWeatherView({super.key});

  @override
  State<YWeatherView> createState() => _YWeatherViewState();
}

final kbloc=KiwiContainer().resolve<YWeatherBloc>();
final gbloc=GetIt.I<YWeatherBloc>();
bool isVisible=false;
Color? bgColor;


class _YWeatherViewState extends State<YWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor!=null?bgColor:Colors.white,
      appBar: AppBar(
        title: Text("Weather app"),
        centerTitle: true,
        backgroundColor: bgColor!=null?bgColor:Colors.white,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,size: 32,))
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _searchInput(),
            SizedBox(height: 16.h,),
            BlocConsumer(
              bloc: kbloc,
              buildWhen: (previous, current) => current is YWeatherLoadingState || current is YWeatherFailedState || current is YWeatherSuccessState,
              listener: (context, state) {
                if(state is YWeatherFailedState)
                  showMessage(state.msg);
                else if(state is YWeatherSuccessState)
                  showMessage(state.weatherData.location.name + " weather data loading ...",isSucess: true);
                else if(state is YWeatherShinyState) {
                  setState(() {
                    isVisible=false;
                    bgColor = Colors.yellow;
                  });
                }
                else if(state is YWeatherNotShinyState) {
                  setState(() {
                    isVisible=false;
                    bgColor = Colors.grey;
                  });
                }
              },
              builder: (context, state) {
                if(state is YWeatherLoadingState)
                  return CupertinoActivityIndicator(radius: 35.r,color: Theme.of(context).primaryColor,);
                else if(state is YWeatherFailedState)
                  return Center(child: Text(state.msg,style: TextStyle(color: Color(0xfffe39a2),fontWeight: FontWeight.bold,fontSize: 30),));
                else if(state is YWeatherSuccessState)
                  return _weatherSection(state.weatherData);
                else
                  return Expanded(
                    child: Container(
                      color: Colors.yellow.withOpacity(.3),
                      child: Center(child: Text("There is no data , first search with city name",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 35,fontWeight: FontWeight.bold),)),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchInput() {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        height: 60.h,
        child: TextField(
          keyboardType: TextInputType.text,
          onSubmitted: (value) {
            kbloc.add(GetYWeatherDataEvent(q: value, days: 1));
            //gbloc.add(GetYWeatherDataEvent(q: value, days: 3));
          },
          decoration: InputDecoration(
            labelText: "Cityname",
            hintText: "Type here your city name",
            suffix: Icon(Icons.search,color: Theme.of(context).primaryColor,),
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
    );

  }

  Widget _weatherSection(YWeatherData weatherData) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text(weatherData.location.name,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),)),
          SizedBox(height: 12.h,),
          Center(child: Text(weatherData.current.tempC.toString(),style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.w600),)),
          SizedBox(height: 12.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network("http:"+weatherData.current.condition.icon,width: 50.w,height: 45.h,fit: BoxFit.fill,),
                  SizedBox(height: 12.h,),
                  Text(weatherData.current.condition.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Avg temp: "+weatherData.forecast.forecastday[0].day.avgtempC.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                  SizedBox(height: 8.h,),
                  Text("Max temp: "+weatherData.forecast.forecastday[0].day.maxtempC.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                  SizedBox(height: 8.h,),
                  Text("Min temp: "+weatherData.forecast.forecastday[0].day.mintempC.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                  SizedBox(height: 8.h,),
                  Text("Presure: "+weatherData.current.pressureIn.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                  SizedBox(height: 8.h,),
                  Text("Humdity: "+weatherData.current.humidity.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
                  SizedBox(height: 8.h,),
                ],
              )
            ],
          ),
          SizedBox(height: 16.h,),
          HoursSection(weatherData: weatherData)
        ],
      ),
    );
  }
}
