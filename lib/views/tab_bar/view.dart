import 'package:flutter/material.dart';

class MyTabBarView extends StatefulWidget {
  const MyTabBarView({super.key});

  @override
  State<MyTabBarView> createState() => _MyTabBarViewState();
}

class _MyTabBarViewState extends State<MyTabBarView> with TickerProviderStateMixin {

  int seletedTab=0;
  late  TabController tabController;

  @override
  void initState() {

    super.initState();
    tabController=TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBar(
        controller: tabController,
        tabs: [
          Container(

            padding: EdgeInsets.all( 8),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(16)
            ),
            child: Text("Tab 1",style: TextStyle(color: Colors.orange),),
          ),
          Container(

            padding: EdgeInsets.all( 8),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Text("Tab 2",style: TextStyle(color: Colors.orange),),
          ),
          Container(

            padding: EdgeInsets.all( 8),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(16)
            ),
            child: Text("Tab 3",style: TextStyle(color: Colors.orange),),
          ),
        ],
        indicatorSize: TabBarIndicatorSize.tab,
        //indicatorColor: Colors.blue,
        onTap: (value) {
          seletedTab=value;
          setState(() {

          });
        },
      ),
    );
  }
}
