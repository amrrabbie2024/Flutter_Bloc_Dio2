import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MySlidableView extends StatefulWidget {
  const MySlidableView({super.key});

  @override
  State<MySlidableView> createState() => _MySlidableViewState();
}

final colorsList=[Colors.blue,Colors.red,Colors.green,Colors.orange,Colors.grey,Colors.yellow];
int selectedIndex=0;

class _MySlidableViewState extends State<MySlidableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Slidable"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(colorsList.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Slidable(
                  key: Key('$selectedIndex'),
                  endActionPane: ActionPane(
                    // motion: const ScrollMotion(),
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(

                        onPressed: (context) {
                          colorsList.removeAt(index);
                          setState(() {

                          });
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        flex: 2,
                        spacing: 32,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      SlidableAction(

                        onPressed: (context) {

                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Share',
                        borderRadius: BorderRadius.circular(25),
                        flex: 3,
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    margin: EdgeInsetsDirectional.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        color: colorsList[index],
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: selectedIndex == index
                            ? Colors.black
                            : Colors.transparent)
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
