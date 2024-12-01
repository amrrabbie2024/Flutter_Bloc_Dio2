import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/g_news/bloc.dart';
import 'package:flutter_apis_pagination/views/g_news/model/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

part 'compoents/category.dart';
part 'compoents/news.dart';

class GnewsView extends StatefulWidget {
  const GnewsView({super.key});

  @override
  State<GnewsView> createState() => _GnewsViewState();
}

bool isVisible=true;
String gcategory="general";

class _GnewsViewState extends State<GnewsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(.1),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(.3),
        title: Text("Gnews App"),
        titleTextStyle: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 26),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(Icons.category,color: Colors.orange,)),
          SizedBox(width: 16.w,)
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Visibility(visible: isVisible,child: GCategorySection()),
            Visibility(visible: isVisible,child: SizedBox(height: 24.h,)),
            Expanded(child: GNewsSection(category: gcategory,))
          ],
        ),
      ),
    );
  }
}
