import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vertical Divider"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 28),),
            SizedBox(width: 8.w,),
            VerticalDivider(color: Colors.orange,thickness: 4.r,indent: 120,endIndent: 120,),
            SizedBox(width: 8.w,),
            Text("World",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600,fontSize: 28),),
          ],
        ),
      ),
    );
  }
}
