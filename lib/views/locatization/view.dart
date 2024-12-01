import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyLocatizationView extends StatefulWidget {
  const MyLocatizationView({super.key});

  @override
  State<MyLocatizationView> createState() => _MyLocatizationViewState();
}

String? lng;

class _MyLocatizationViewState extends State<MyLocatizationView> {
  @override
  Widget build(BuildContext context) {
    lng=CashHelper.getLanguage();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: () {

              context.setLocale(Locale(lng!));

             if(lng == 'en')
               lng='fr';
               else if(lng == "fr")
               lng='ar';
              else if(lng == "ar")
               lng='en';

              CashHelper.saveLanguage(lng!);
              context.setLocale(Locale(lng!));

            }, icon: Icon(Icons.translate_rounded,color: Theme.of(context).primaryColor,size: 48.r,)),
            SizedBox(height: 16.h,),
            Text("welcome_flutter".tr(),style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
