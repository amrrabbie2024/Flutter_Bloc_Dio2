import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/views/login/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/logic/cash_helper.dart';
import '../intro/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () {
        bool introStatus = CashHelper.getIntroStatus();
        if (introStatus) {
          navigateTo(LoginView(), withHistory: false);
        } else {
          navigateTo(MyIntroView(), withHistory: false);
        }
      }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInDownBig(
        duration: Duration(seconds: 2),
        delay: Duration(milliseconds: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(child: SvgPicture.asset("assets/svg/logo.svg",width: 250.w,height: 180.h,fit: BoxFit.fill,)),
            SizedBox(height: 16.h,),
            Text("Splash Page",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 22),)
          ],
        ),
      ),
    );
  }
}
