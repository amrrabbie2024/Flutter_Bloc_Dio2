part of '../view.dart';
class WeatherHours extends StatelessWidget {
  final TWeatherData weatherData;
  const WeatherHours({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    var hours=weatherData.forecast.forecastday[0].hour;
    return SizedBox(
      height: 160.h,
      child: ListView.separated(
         scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>  _item(hours[index]),
          separatorBuilder:  (context, index) => SizedBox(width: 8.w,),
          itemCount: hours.length
      ),
    );
  }

  Widget _item(Hour hour) {
    return Card(
      color: Colors.grey.withOpacity(.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r)
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.w,vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(hour.time.substring(10),style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w600),),
            SizedBox(height: 8.h,),
            Text(hour.tempC.toString(),style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w600),),
            SizedBox(height: 8.h,),
            Image.network("http:"+hour.condition.icon,width: 45.w,height: 45.h,fit: BoxFit.fill,),
            SizedBox(height: 8.h,),
            Text(hour.condition.text,style: TextStyle(color: Colors.orange,fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
