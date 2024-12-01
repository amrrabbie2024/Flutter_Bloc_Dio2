import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBannerView extends StatelessWidget {
  const MyBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Banner"),
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: Center(
          child: Banner(
            location: BannerLocation.topStart,
            message: "Sales 50%",
            color: Colors.orange,
            textStyle: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),
            child: ClipOval(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 180.h,
                color: Colors.yellow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
