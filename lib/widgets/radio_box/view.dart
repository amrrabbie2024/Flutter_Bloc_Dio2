import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRadioBox extends StatefulWidget {
  const MyRadioBox({super.key});

  @override
  State<MyRadioBox> createState() => _MyRadioBoxState();
}

final List<String> languages=["Dart","Kotlin","Swift","Java","Objective c"];
int currentValue=0;

class _MyRadioBoxState extends State<MyRadioBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio box"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Column(
          children: List.generate(languages.length, (index) =>
          Row(
            children: [
              Radio(
                activeColor: Colors.orange,
                value: index,
                groupValue: currentValue,
                onChanged: (value) {
                setState(() {
                  currentValue=value!;
                  print(languages[currentValue]);
                });
              },),
              SizedBox(width: 8.w,),
              Text(languages[index],style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),)
            ],
          )
          ),
        ),
      ),
    );
  }
}
