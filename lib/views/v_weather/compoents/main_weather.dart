
part of '../view.dart';
class MainWeatherSection extends StatelessWidget {
  final VWeatherData data;
  const MainWeatherSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(data.location.name,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),)),
            SizedBox(height: 8.h,),
            Center(child: Text(data.current.condition.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),)),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Align(alignment: AlignmentDirectional.centerStart,child: Image.network("http:"+data.current.condition.icon,width: 90.w,height: 60.h,fit: BoxFit.fill,))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 8.h,),
                      Text("Temp  "+data.current.tempC.toString(),style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.w600),),
                      SizedBox(height: 8.h,),
                      Text("Max Temp  "+data.forecast.forecastday[0].day.maxtempC.toString(),style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.w600),),
                      SizedBox(height: 8.h,),
                      Text("Min Temp  "+data.forecast.forecastday[0].day.mintempC.toString(),style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.w600),),
                      SizedBox(height: 8.h,),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h,),
            WeatherListView(hour:data.forecast.forecastday[0].hour),
            SizedBox(height: 8.h,)
          ],
        ));
  }
}
