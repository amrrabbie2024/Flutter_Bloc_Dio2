part of '../home_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250.w,
      backgroundColor: Colors.yellow.withOpacity(.5),
      shadowColor: Colors.orange,
      elevation: 32,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(45),bottomEnd: Radius.circular(25)),
        side: BorderSide(color: Theme.of(context).primaryColor,width: 3.r)
      ),
      child: Padding(
        padding:  EdgeInsetsDirectional.only(start: 16.w,end: 16.w,top: 36.h,bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 70,backgroundColor: Colors.orange,child: CircleAvatar(radius: 67,backgroundImage: AssetImage("assets/images/img2.jpg"),)),
            SizedBox(height: 16.h,),
            Text("Custom Drawer",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),),
            SizedBox(height: 16.h,),
            TextButton(onPressed: () {
              print("Text button");
            }, child: Text("Text button ...")),
            SizedBox(height: 16.h,),
            FilledButton(onPressed: () {
              print("Filled Button");
            }, child: Text("Filled Button ...")),
            SizedBox(height: 16.h,),
            OutlinedButton(onPressed: () {
              print("Outline Button");
            }, child: Text("Outline Button ...")),
            SizedBox(height: 16.h,),
            ElevatedButton(onPressed: () {
              print("Elevated button");
            }, child: Text("Elevated button ...")),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.access_alarm,color: Colors.orange,),
                Icon(Icons.account_circle_outlined,color: Colors.blue,),
                Icon(Icons.add_a_photo_outlined,color: Colors.green,),
                Icon(Icons.add_box_rounded,color: Colors.red,),
                Icon(Icons.add_card_rounded,color: Colors.yellow,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
