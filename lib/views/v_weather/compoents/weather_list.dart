
part of '../view.dart';
class WeatherListView extends StatelessWidget {
  final List<Hour> hour;
  const WeatherListView( {super.key, required this.hour});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>  _item(hour[index],context),
        itemCount: hour.length,
      ),
    );
  }

  Widget _item(Hour hour, BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(.3),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: Theme.of(context).primaryColor)
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 8.w,vertical: 12.h),
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: [
            Text(hour.time.substring(11,16).toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
            SizedBox(height: 8.h,),
            Text(hour.tempC.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
            SizedBox(height: 8.h,),
            Text(hour.condition.text,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
            SizedBox(height: 8.h,),
            Image.network("http:"+hour.condition.icon,width: 50.w,height: 40.h,fit: BoxFit.fill,)
          ],
        ),
      ),
    );
  }
}
