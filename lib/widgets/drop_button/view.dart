import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropDownButton extends StatefulWidget {
  const MyDropDownButton({super.key});

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

int selectedIndex=0;
final List<String> languages=["Dart","Kotlin","Swift","Java","Objective c"];

class _MyDropDownButtonState extends State<MyDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop down button"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
        child: Center(
          child: DropdownButton(
              borderRadius: BorderRadius.circular(16.r),
              focusColor: Colors.yellow.withOpacity(.5),
              autofocus: true,
              underline: SizedBox(),
              value: selectedIndex,
              isExpanded: true,
              dropdownColor: Colors.green.withOpacity(.5),
              style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 21),
              icon: Icon(Icons.ac_unit),
              iconEnabledColor: Colors.blue,
              iconDisabledColor: Colors.orange,
              padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
              items: List.generate(languages.length, (index) =>
              DropdownMenuItem(child: Text(languages[index]),value: index,)
              ),
              onChanged: (value) {
                setState(() {
                  selectedIndex=value!;
                  print(languages[selectedIndex]);
                });
              },
          ),
        ),
      ),
    );
  }
}
