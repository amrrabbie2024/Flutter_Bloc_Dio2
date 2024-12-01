import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/y_movies/movies/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/list.dart';
part 'compoents/grid.dart';

class YMoviesView extends StatelessWidget {
  const YMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies app"),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30,fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              YMoviesListSection(),
              SizedBox(height: 24.h,),
              YMoviesGridSection()
            ],
          ),
        ),
      ),
    );
  }
}
