import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyListTile_Check extends StatefulWidget {
  const MyListTile_Check({super.key});

  @override
  State<MyListTile_Check> createState() => _MyListTile_CheckState();
}

bool isChecked=false;

class _MyListTile_CheckState extends State<MyListTile_Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Tile -Check"),
      ),
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            ListTile(
              onTap: () {
                print("List Tile");
              },
              focusColor: Colors.green,
              autofocus: true,
              hoverColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.black,width: 4)
              ),
              leading: CircleAvatar(radius: 35.r,backgroundImage: AssetImage("assets/images/img1.jpg"),),
              title: Text("List tile title"),
              subtitle: Text("List tile sub title"),
              trailing: IconButton(onPressed: () {
                print("Edit");
              }, icon: Icon(Icons.edit,color: Colors.red,)),
            ),
            Spacer(),
            CheckboxListTile(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked=value!;
                  });
                },
              title: Text("Check List Tile Title"),
              subtitle: Text("Check List Tile Sub Title"),
              secondary: CircleAvatar(radius: 35.r,backgroundImage: AssetImage("assets/images/img2.jpg"),),
              activeColor: Colors.blue,
              checkboxShape: CircleBorder(),
              hoverColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.black)
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
