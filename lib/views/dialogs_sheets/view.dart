import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'compoents/alert_dialog.dart';
part 'compoents/simple_dialog.dart';
part 'compoents/bottom_sheet.dart';

class MyDialogsSheets extends StatefulWidget {
  const MyDialogsSheets({super.key});

  @override
  State<MyDialogsSheets> createState() => _MyDialogsSheetsState();
}

String? name;

class _MyDialogsSheetsState extends State<MyDialogsSheets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert & Simple Dialogs - Bottom Sheet"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(name!=null?name!:"",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),)),
            SizedBox(height: name!=null?32.h:0,),
            SizedBox(
              height: 45.h,
              child: FilledButton(onPressed: () async {
                name=await showDialog(context: context, builder: (context) => MyAlertDialog(),);
                setState(() {

                });
              }, child: Text("Alert Dialog")),
            ),
            SizedBox(height: 24.h,),
            SizedBox(
              height: 45.h,
              child: OutlinedButton(onPressed: () async {
                name=await showDialog(context: context, builder: (context) => MySimpleDialog(),);
                setState(() {});
              }, child: Text("Simple Dialog")),
            ),
            SizedBox(height: 24.h,),
            SizedBox(
              height: 45.h,
              child: ElevatedButton(onPressed: () async {
                name=await showModalBottomSheet(context: context, builder: (context) => MyBottomSheet(),);
                setState(() {});
              }, child: Text("Bottom Sheet")),
            )
          ],
        ),
      ),
    );
  }
}
