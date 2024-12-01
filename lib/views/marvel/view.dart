import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/marvel/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/list.dart';

class MarvelView extends StatelessWidget {
  const MarvelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel app"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24.r),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.list_alt,color: Theme.of(context).primaryColor,size: 28.r,)),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,size: 28.r,)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
          child: MarvelList(),
        ),
      ),
    );
  }
}
