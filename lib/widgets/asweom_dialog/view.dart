import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAswomDialog extends StatelessWidget {
  const MyAswomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40.h,
                child: FilledButton(onPressed: () {
                  _showSucessDialog(context);
                }, child: Text("Sucess Dialog")),
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                height: 40.h,
                child: FilledButton(onPressed: () {
                  _showErrorDialog(context);
                }, child: Text("Error Dialog")),
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                height: 40.h,
                child: FilledButton(onPressed: () {
                  _showInfoDialog(context);
                }, child: Text("Info Dialog")),
              ),
              SizedBox(height: 16.h,),
              SizedBox(
                height: 40.h,
                child: FilledButton(onPressed: () {
                  _showAutohideDialog(context);
                }, child: Text("Auto hide Dialog")),
              ),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
      ),
    );
  }

   _showSucessDialog(BuildContext context){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Sucess',
        desc: 'Opertion Sucessed ...',
        btnCancelOnPress: () {},
    btnOkOnPress: () {},
    )..show();
  }

   _showErrorDialog(BuildContext context) {
     AwesomeDialog(
       context: context,
       dialogType: DialogType.error,
       animType: AnimType.rightSlide,
       title: 'Error',
       desc: 'Opertion Failed ...',
       btnCancelOnPress: () {},
       btnOkOnPress: () {},
     )..show();
   }

   _showInfoDialog(BuildContext context) {
     AwesomeDialog(
       context: context,
       dialogType: DialogType.info,
       animType: AnimType.rightSlide,
       title: 'Info',
       desc: 'Information about ...',
       btnCancelOnPress: () {},
       btnOkOnPress: () {},
     )..show();
   }

   _showAutohideDialog(BuildContext context) {
     AwesomeDialog(
       context: context,
       dialogType: DialogType.success,
       autoHide: Duration(seconds: 3),
       animType: AnimType.rightSlide,
       title: 'Auto hide',
       desc: 'Auto hide dialog ...',
      // btnCancelOnPress: () {},
      // btnOkOnPress: () {},
     )..show();
   }
}
