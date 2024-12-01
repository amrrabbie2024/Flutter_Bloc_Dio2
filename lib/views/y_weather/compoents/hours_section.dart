
part of '../view.dart';
class HoursSection extends StatelessWidget {

  final YWeatherData weatherData;
  const HoursSection({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final hours=weatherData.forecast.forecastday[0].hour;
    return SizedBox(
      height: 180.h,
      child: ListView.builder(
         itemCount: hours.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _hoursItem(hours[index],context),
      ),
    );
  }

  _hoursItem(Hour hour, BuildContext context) {
    return Card(
      //color: Colors.grey.withOpacity(.5),
      shadowColor: Theme.of(context).primaryColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20.r),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6.h,),
            Text(hour.time.substring(10),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
            SizedBox(height: 6.h,),
            Text(hour.tempC.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
            SizedBox(height: 6.h,),
            Image.network("Http:"+hour.condition.icon,width: 50.w,height: 50.h,fit: BoxFit.fill,),
            SizedBox(height: 6.h,),
            Text(hour.condition.text,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600) ),
            SizedBox(height: 6.h,),
          ],
        ),
      ),
    );
  }
}
