import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/movies_m/bloc.dart';
import 'package:flutter_apis_pagination/features/movies_m/details/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/list.dart';
part 'compoents/grid.dart';
part 'compoents/details.dart';

class MoviesMView extends StatelessWidget {
  const MoviesMView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movies app"),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MoviesMList(),
              SizedBox(height: 16.h,),
              MoviesMGrid()
            ],
          ),
        ),
      ),
    );
  }
}
