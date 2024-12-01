import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/features/movies/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class MoviesRadio extends StatefulWidget {
  const MoviesRadio({super.key});

  @override
  State<MoviesRadio> createState() => _MoviesRadioState();
}

final gbloc=GetIt.I<MoviesBloc>()..add(getMoviesDataEvent());
int? currentIndex;

class _MoviesRadioState extends State<MoviesRadio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies radio"),
      ),
      body: BlocBuilder(
        bloc: gbloc,
        builder: (context, state) {
          if(state is MoviesFailedState)
            return MyAppFailed(msg: state.msg);
          else if(state is MoviesSucessState)
            return Padding(
              padding:  EdgeInsets.all(16.r),
              child: Column(
                children: List.generate(state.movieModel.length, (index) =>
                Row(
                  children: [
                    Radio(
                      activeColor: Colors.orange,
                        value: index,
                        groupValue: currentIndex,
                        onChanged: (value) {
                          setState(() {
                            currentIndex=value!;
                            print(state.movieModel[currentIndex!].title );
                          });
                        },
                    ),
                    SizedBox(width: 4.w,),
                    Text(state.movieModel[index].title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),)
                  ],
                )
                ),
              ),
            );
          else
            return MyAppLoading();
        },
      ),
    );
  }
}
