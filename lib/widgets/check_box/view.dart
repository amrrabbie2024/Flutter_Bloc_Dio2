import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}


final List<String> languages=["Dart","Kotlin","Swift","Java","Objective c"];
final List<bool> checks=[true,true,false,true,false];

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check box"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              ...List.generate(languages.length, (index) =>
              Row(

                children: [
                  Checkbox(
                      activeColor: Colors.blue,
                      checkColor: Colors.orange,
                      shape: CircleBorder(),
                      value: checks[index],
                      onChanged: (value) {
                        setState(() {
                          checks[index]=value!;
                          print(languages[index] + " - " + checks[index].toString());
                        });
                      },
                  ),
                  SizedBox(width: 8.w,),
                  Text(languages[index],style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 22),)
                ],
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
