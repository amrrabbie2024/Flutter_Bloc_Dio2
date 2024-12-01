import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'compoents/app_bar.dart';
part 'compoents/app_drawer.dart';
part 'compoents/floating_button.dart';
part 'compoents/bottom_navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      floatingActionButton: MyFloatingButton(),
      bottomNavigationBar: MyBottomNavigationBar(),

      body: Center(
        child: Builder(builder: (context) {
          if(currentIndex == 0)
            return Text("Hello world");
          else if(currentIndex == 1)
          return  Icon(Icons.search,size: 64,);
          else if(currentIndex ==2)
            return FilledButton(onPressed: () {

            }, child: Text("Hello"));
          else return ElevatedButton(onPressed: () {

            }, child: Text("dfdsfgdsgdf"));

          setState(() {

          });
        },),
      ),
    );
  }
}
