import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomeView extends StatelessWidget {
  const MyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(radius: 55,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 52,backgroundImage: NetworkImage(CashHelper.getImage()),)),
              SizedBox(height: 16.h,),
              Text(CashHelper.getFullname(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w500),),
              SizedBox(height: 16.h,),
              Text(CashHelper.getToken(),style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.w500),),
            ],
          ),
        ),
      ),
    );
  }
}
