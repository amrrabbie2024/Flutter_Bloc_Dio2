import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySwitchView extends StatefulWidget {
  const MySwitchView({super.key});

  @override
  State<MySwitchView> createState() => _MySwitchViewState();
}

bool isTrue=false;

class _MySwitchViewState extends State<MySwitchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Switch(
              value: isTrue,
              onChanged: (bool value) {
                setState(() {
                  isTrue = value;
                });
              },
              activeColor: Colors.orange,
              activeTrackColor: Colors.blue,
              inactiveThumbColor: Colors.blue.withOpacity(.5),
            ),
            SizedBox(width: 8.w,),
            Text("Status:- $isTrue", style: TextStyle(color: Theme
                .of(context)
                .primaryColor, fontWeight: FontWeight.w600, fontSize: 24),)
          ],
        ),
      ),
    );
  }
}
