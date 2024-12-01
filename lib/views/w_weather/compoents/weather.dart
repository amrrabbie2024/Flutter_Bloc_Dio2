part of '../view.dart';

class WeatherSection extends StatelessWidget {
  final WWeatherData data;
  const WeatherSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(data.name,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 8.h,),
        Image.network("http://openweathermap.org/img/w/" +data.weather[0].icon + ".png",width: 60.w,height: 60.h,fit: BoxFit.fill,),
        SizedBox(height: 8.h,),
        Text(data.weather[0].description,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text("Temp: " +data.main.temp.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text("Pressure: "+data.main.pressure.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text("Humdity: "+data.main.humidity.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text("Wind: "+data.wind.speed.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text("Clouds: "+data.clouds.all.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),),
        SizedBox(height: 16.h,),
      ],
    );
  }
}
