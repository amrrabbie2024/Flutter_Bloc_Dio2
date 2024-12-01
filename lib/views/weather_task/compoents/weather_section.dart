
part of '../view.dart';
class WeatherSection extends StatelessWidget {
  final TWeatherData weatherData;
  const WeatherSection({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Text(weatherData.location.name,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight:  FontWeight.w500),)),
          SizedBox(height: 8.h,),
          Center(child: Text(weatherData.current.lastUpdated.substring(10),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight:  FontWeight.w500),)),
          SizedBox(height: 8.h,),
          Row(
            children: [
              Expanded(child: Align(alignment: AlignmentDirectional.centerStart,child: Image.network("https:"+weatherData.current.condition.icon,width: 45.w,height: 60.h,fit: BoxFit.fill,))),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Max temp: "+weatherData.forecast.forecastday[0].day.maxtempC.toString(),style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight:  FontWeight.w500),),
                  SizedBox(height: 8.h,),
                  Text("Min temp: "+weatherData.forecast.forecastday[0].day.mintempC.toString(),style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight:  FontWeight.w500),),
                  SizedBox(height: 8.h,),
                  Text("Ave temp: "+weatherData.forecast.forecastday[0].day.avgtempC.toString(),style: TextStyle(color: Colors.orange,fontSize: 20,fontWeight:  FontWeight.w500),),
                  SizedBox(height: 8.h,),
                ],
              )
              ),
            ],
          ),
          Center(child: Text(weatherData.current.condition.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight:  FontWeight.w500),)),
          SizedBox(height: 36.h,),
          WeatherHours(weatherData: weatherData,),
          SizedBox(height: 24.h,),
        ],
      ),
    );
  }
}
