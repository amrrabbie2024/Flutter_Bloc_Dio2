import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/views/login/view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyIntroView extends StatefulWidget {
  const MyIntroView({super.key});

  @override
  State<MyIntroView> createState() => _MyIntroViewState();
}

final List<String> images=["img1.jpg","img2.jpg","img3.jpg"];
final List<String> titles=["Title One 1","Title Two 2","Title Three 3"];
final List<String> descs=["Description One 1","Description Two 2","Description Three 3"];
int currentIndex=0;

class _MyIntroViewState extends State<MyIntroView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
            bottom: 120,
              child: Image.asset("assets/images/${images[currentIndex]}",width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,fit: BoxFit.fill,)),
          Positioned(
            top: 16,right: 16,
            child: TextButton(onPressed: () {
              CashHelper.saveIntroStatus(true);
              navigateTo(LoginView(),withHistory: false);
            }, child: Text("Skip")),
          ),
          Positioned(
            bottom: 180,
              child: Text(titles[currentIndex],style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 28),)),
          Positioned(
            bottom: 140,
              child: Text(descs[currentIndex],style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5),fontWeight: FontWeight.w500,fontSize: 22),)),
          Positioned(
            bottom: 45,right: 24,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if(images.length > currentIndex + 1){
                      currentIndex++;
                    }else{
                      CashHelper.saveIntroStatus(true);
                      navigateTo(LoginView(),withHistory: false);
                    }
                  });
                },
                  child: CircleAvatar(radius: 22.r,child: Icon(Icons.arrow_forward,color: Theme.of(context).primaryColor,),))),
          Positioned(
              bottom: 45,left: 24,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      if(currentIndex != 0){
                        currentIndex --;
                      }
                    });
                  },
                  child: CircleAvatar(radius: 22.r,child: Icon(Icons.arrow_back,color: Colors.grey,),))),
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(images.length, (index) =>
                CircleAvatar(
                  radius: 12,backgroundColor: currentIndex==index?Colors.orange:Colors.transparent,
                    child: CircleAvatar(radius: 10,backgroundColor: currentIndex==index?Theme.of(context).primaryColor:Colors.grey,))
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
