import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBadgeView extends StatelessWidget {
  const MyBadgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Badge"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 32.w),
        child: Center(
          child: Badge(
            alignment: AlignmentDirectional.topStart,
            label: Text("5"),
            backgroundColor: Colors.orange,
            textStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),
            child: Container(
              width: double.infinity,
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.yellow,
                border: Border.all(color: Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
