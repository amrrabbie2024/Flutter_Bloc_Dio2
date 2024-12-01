import 'package:flutter/material.dart';

class MyRangerSliderView extends StatefulWidget {
  const MyRangerSliderView({super.key});

  @override
  State<MyRangerSliderView> createState() => _MyRangerSliderViewState();
}

 RangeValues selectedValues=RangeValues(0,16);

class _MyRangerSliderViewState extends State<MyRangerSliderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ranger Slider"),
      ),
      body: RangeSlider(
        values: selectedValues,
        onChanged: (value) {
        setState(() {
          selectedValues=RangeValues(value.start, value.end);
        });
      },
        min: 0,
        max: 100,
        divisions: 25,
        labels: RangeLabels(selectedValues.start.toString(), selectedValues.end.toString()),
        activeColor: Colors.red,
        inactiveColor: Colors.yellow,
      ),
    );
  }
}
