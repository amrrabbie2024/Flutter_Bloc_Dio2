part of '../view.dart';

class MWeatherSection extends StatefulWidget {
  final String q;
  const MWeatherSection({super.key,required this.q});

  @override
  State<MWeatherSection> createState() => _MWeatherSectionState();
}

final kbloc=KiwiContainer().resolve<MWeatherBloc>();

class _MWeatherSectionState extends State<MWeatherSection> {
  @override
  void initState() {
    kbloc.add(getMWeatherDataEvent(q: widget.q));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: kbloc,
      listener: (context, state) {

      },
      builder: (context, state) {
        if(state is MWeatherFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w600),));
        else if(state is MWeatherSuccessState)
          return _item(state.mWeatherData);
        else
          return Center(child: CircularProgressIndicator(color: Colors.orange,backgroundColor: Colors.yellow,strokeWidth: 8,));
      },
    );
  }

  Widget _item(MWeatherData mWeatherData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 64.h,),
        Center(child: Text(mWeatherData.location.name,style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.w600),)),
        SizedBox(height: 16.h,),
        Center(child: Text(mWeatherData.current.lastUpdated,style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.w600),)),
        SizedBox(height: 48.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 32.w,),
            Image.network(mWeatherData.current.condition.icon,width: 90.w,height: 120.h,fit: BoxFit.fill,),
            Spacer(),
            Text(mWeatherData.forecast.forecastday[0].day.avgtempC.toString(),style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(width: 32.w,),
          ],
        ),
        SizedBox(height: 16.h,),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 52.w,),
            Text(mWeatherData.current.condition.text,style: TextStyle(color: Colors.green,fontSize: 24,fontWeight: FontWeight.bold)),
            Spacer(),
            Text(mWeatherData.forecast.forecastday[0].day.maxtempC.toString(),style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(width: 32.w,),
          ],
        ),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 32.w,),
            Text("",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
            Spacer(),
            Text(mWeatherData.forecast.forecastday[0].day.mintempC.toString(),style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold)),
            SizedBox(width: 32.w,),
          ],
        ),
        SizedBox(height: 16.h,),
        Center(child: Text(mWeatherData.current.windKph.toString(),style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold))),
        SizedBox(height: 16.h,),
        Center(child: Text(mWeatherData.current.humidity.toString(),style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold))),
        SizedBox(height: 16.h,),
        Center(child: Text(mWeatherData.current.pressureIn.toString(),style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold))),
      ],
    );
  }
}
