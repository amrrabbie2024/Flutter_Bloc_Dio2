import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDismissibleView extends StatefulWidget {
  const MyDismissibleView({super.key});

  @override
  State<MyDismissibleView> createState() => _MyDismissibleViewState();
}

final colorsList=[Colors.blue,Colors.red,Colors.green,Colors.orange,Colors.grey,Colors.yellow];
int selectedIndex=0;

class _MyDismissibleViewState extends State<MyDismissibleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dismissible"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(colorsList.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex=index;
                  });
                },
                child: Dismissible(
                  key: Key('$selectedIndex'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    width: double.infinity,
                    height: 120.h,
                    margin: EdgeInsetsDirectional.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        color: colorsList[index],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: selectedIndex==index?Colors.black:Colors.transparent)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete,color: Colors.black,size: 32,),
                        SizedBox(height: 8.h,),
                        Text("Delete",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    margin: EdgeInsetsDirectional.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: colorsList[index],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: selectedIndex==index?Colors.black:Colors.transparent)
                    ),
                  ),
                ),
              );
            }
            )
          ],
        ),
      ),
    );
  }
}
