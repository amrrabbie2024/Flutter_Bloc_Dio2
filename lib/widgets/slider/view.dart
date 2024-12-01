import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/widgets/drop_button/view.dart';

class MySliderView extends StatefulWidget {
  const MySliderView({super.key});

  @override
  State<MySliderView> createState() => _MySliderViewState();
}

double selectedValue=0;

class _MySliderViewState extends State<MySliderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Slider(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue=value;
          });
        },
        min: 0,
        max: 100,
        divisions: 20,
        label: "$selectedValue",
        activeColor: Colors.orange,
        inactiveColor: Colors.yellow,
        thumbColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
