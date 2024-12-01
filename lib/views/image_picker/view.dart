import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

XFile? image;

class _MyImagePickerState extends State<MyImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 48.h,),
            image!=null?CircleAvatar(radius: 75.r,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 70.r,backgroundImage: FileImage(File(image!.path)),)):SizedBox.shrink(),
            SizedBox(height: image!=null?32.h:0,),
            TextButton(onPressed: () async {
              image=await ImagePicker().pickImage(source: ImageSource.camera);
              setState(() {});
            }, child: Text("From Camera")),
            SizedBox(height: 24.h,),
            TextButton(onPressed: () async {
              image=await ImagePicker().pickImage(source: ImageSource.gallery);
              setState(() {});
            }, child: Text("From gallery"))
          ],
        ),
      ),
    );
  }
}
