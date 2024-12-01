import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/features/new_weather/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';
part 'compoents/weather.dart';

class MWeather extends StatefulWidget {
  const MWeather({super.key});

  @override
  State<MWeather> createState() => _MWeatherState();
}

class _MWeatherState extends State<MWeather> {
  bool isVisible=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather",style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.w600),),
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(
              visible: isVisible,
              child: TextFormField(
                onFieldSubmitted: (value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MWeatherSection(q: value),));
                },
                decoration: InputDecoration(
                  suffix: Icon(Icons.search,color: Colors.orange,),
                  labelText: "City",
                  hintText: "Enter city name",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: Colors.orange)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.orange)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.orange)
                  ),
                ),
              ),
            ),
            Spacer(),
            Text("There is no aviable weather data , please enter your city to display weather data",style: TextStyle(color: Colors.orange,fontSize: 22,fontWeight: FontWeight.w600),),
            Spacer()
          ],
        ),
      ),
    );
  }
}
