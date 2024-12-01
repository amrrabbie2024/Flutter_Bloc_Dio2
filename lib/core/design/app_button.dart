import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppButton extends StatelessWidget {

  final IconData iconData;
  final String text;
  final void Function()? onTap;
  const MyAppButton({super.key, required this.iconData, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange)
        ),
        child: Row(

          children: [
            SizedBox(width: 48.w,),
            Icon(iconData,color: Theme.of(context).primaryColor,),
            SizedBox(width: 24.w,),
            Text(text,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 22),)
          ],
        ),
      ),
    );
  }
}
