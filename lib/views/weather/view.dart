import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/weather/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

final qController=TextEditingController(text: "");
final keyForm=GlobalKey<FormState>();
final gbloc=GetIt.I<WeatherBloc>();

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w, vertical: 24.h),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: qController,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Must enter city name";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "City",
                  hintText: "Type  city name",
                  alignLabelWithHint: true,
                  prefix: Icon(Icons.search, color: Colors.blue,),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(25)
                  ),
                ),
              ),
              SizedBox(height: 24.h,),
              BlocConsumer(
                bloc: gbloc,
                listener: (context, state) {
                  if(state is WeatherFailedState)
                    showMessage(state.msg);
                  else if(state is WeatherSuccessState)
                    showMessage("Weather data Loading ...",isSucess: true);
                },
                builder: (context, state) {
                  if(state is WeatherFailedState)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _searchButton(),
                        SizedBox(height: 24.h,),
                        Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),))
                      ],
                    );
                  else if(state is WeatherLoadingState)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _searchButton(),
                        SizedBox(height: 24.h,),
                        Center(child: CupertinoActivityIndicator(color: Colors.orange,radius: 35,))
                      ],
                    );
                  else if(state is WeatherSuccessState)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _searchButton(),
                        SizedBox(height: 24.h,),
                         _item(state.weatherData)
                      ],
                    );
                  else
                    return _searchButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchButton() {
    return SizedBox(
      height: 45.h,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            backgroundColor: Colors.yellow.withOpacity(.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.orange, width: 2)
            )
        ),
        onPressed: () {
          if (keyForm.currentState!.validate()) {
            gbloc.add(getWeatherDataEvent(q: qController.text));
          }
        },
        label: Text("Search ...", style: TextStyle(color: Colors.orange),),
        icon: Icon(Icons.search, color: Colors.orange,),
      ),
    );
  }

  Widget _item(WeatherData weatherData) {
    return Card(
      color: Colors.yellow.withOpacity(.1),
      shadowColor: Colors.orange,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),bottomRight: Radius.circular(16)),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(weatherData.name,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            Text(weatherData.main.temp.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            ClipOval(child: Image.network("http://openweathermap.org/img/w/${weatherData.weather[0].icon}.png",width: 45.w,height: 45.h,fit: BoxFit.fill,)),
            SizedBox(height: 16.h,),
            Text(weatherData.weather[0].description,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            Text(weatherData.main.humidity.toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            Text(weatherData.main.pressure.toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            Text(weatherData.wind.speed.toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
            Text(weatherData.visibility.toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 16.h,),
          ],
        ),
      ),
    );
  }


}
