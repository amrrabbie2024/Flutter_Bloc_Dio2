import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/widgets/badge/view.dart';
import 'package:flutter_apis_pagination/widgets/banner/view.dart';
import 'package:flutter_apis_pagination/widgets/ranger_slider/view.dart';
import 'package:flutter_apis_pagination/widgets/slider/view.dart';

class MyPagesView extends StatefulWidget {
  const MyPagesView({super.key});

  @override
  State<MyPagesView> createState() => _MyPagesViewState();
}

class _MyPagesViewState extends State<MyPagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pages view"),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        reverse: true,
        children: [
          MyBadgeView(),
          MySliderView(),
          MyBannerView(),
          MyRangerSliderView()
        ],
      ),
    );
  }
}
