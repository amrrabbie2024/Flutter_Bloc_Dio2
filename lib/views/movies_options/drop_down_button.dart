import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/features/movies/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class MoviesDropButton extends StatefulWidget {
  const MoviesDropButton({super.key});

  @override
  State<MoviesDropButton> createState() => _MoviesDropButtonState();
}

final gbloc=GetIt.I<MoviesBloc>()..add(getMoviesDataEvent());
int? currentIndex;

class _MoviesDropButtonState extends State<MoviesDropButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moview Drop Button"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 16.w,end: 16.w,top: 24.h),
        child: BlocBuilder(
          bloc: gbloc,
          builder: (context, state) {
            if(state is MoviesFailedState)
              return MyAppFailed(msg: state.msg);
            else if(state is MoviesSucessState)
              return DropdownButton(
                isExpanded: true,
                  underline: SizedBox(),
                  style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),
                  borderRadius: BorderRadius.circular(25),
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  dropdownColor: Colors.yellow.withOpacity(.5),
                  focusColor: Colors.blue.withOpacity(.5),
                  autofocus: true,
                  icon: Icon(Icons.add_alert,color: Colors.orange,),
                  value: currentIndex,
                  items: List.generate(state.movieModel.length, (index) => 
                  DropdownMenuItem(child: Text(state.movieModel[index].title),value: state.movieModel[index].id,)
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentIndex=value!;
                    });
                  },
              );
            else
              return 
                  MyAppLoading();
          },
        ),
      ),
    );
  }
}
