import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/z_movies/bloc.dart';
import 'package:flutter_apis_pagination/features/z_movies/details/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/list.dart';
part 'compoents/grid.dart';
part 'compoents/details.dart';

class ZMoviesView extends StatelessWidget {
  const ZMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Movies app"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "PlayWrite Mexico" ),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ZMoviesListSection(),
              SizedBox(height: 24.h,),
              ZMoviesGridSection()
            ],
          ),
        ),
      ),
    );
  }
}
