import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/views/audio_player/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAnimatedOpcity extends StatefulWidget {
  const MyAnimatedOpcity({super.key});

  @override
  State<MyAnimatedOpcity> createState() => _MyAnimatedOpcityState();
}

double opacity=1;

class _MyAnimatedOpcityState extends State<MyAnimatedOpcity> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          onEnd: () {
            setState(() {
              opacity=.9;
            });
          },
              opacity: opacity,
              duration: Duration(seconds: 4),
              curve: Curves.ease,
              child: ClipOval(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      opacity=.1;
                    });
                  },
                  child: Container(
                    width: 250.w,
                    height: 320.h,
                    color: Colors.yellow,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Hello flutter",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 22),),
                          SizedBox(height: 16.h,),
                          Icon(Icons.flutter_dash,size: 64,color: Colors.red,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ),
    );
  }
}
