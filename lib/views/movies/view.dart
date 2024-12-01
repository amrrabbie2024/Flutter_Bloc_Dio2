import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_image.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/movies/bloc.dart';
import 'package:flutter_apis_pagination/views/movie_details/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

part 'compoents/horizantal_list.dart';
part 'compoents/grid.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5.r)
        ,child: CircleAvatar(radius: 16.r,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 14.r,backgroundImage: AssetImage("assets/images/login.jpg"),))),
        title: Text("Movies List And Grid"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Theme.of(context).primaryColor,)),
          SizedBox(width: 4.w,),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings,color: Theme.of(context).primaryColor,)),
          SizedBox(width: 4.w,),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MoviesHorizantalList(),
              SizedBox(height: 24.h,),
              MoviesGrid()
            ],
          ),
        ),
      ),
    );
  }
}
