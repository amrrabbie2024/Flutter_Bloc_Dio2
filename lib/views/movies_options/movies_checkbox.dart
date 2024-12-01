import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/features/movies/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

class MoviesCheckBox extends StatefulWidget {
  const MoviesCheckBox({super.key});

  @override
  State<MoviesCheckBox> createState() => _MoviesCheckBoxState();
}

final kbloc=KiwiContainer().resolve<MoviesBloc>()..add(getMoviesDataEvent());
final List<bool>checks=[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,];

class _MoviesCheckBoxState extends State<MoviesCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies Check Box"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.r),
        child: BlocBuilder(
          bloc: kbloc,
          builder: (context, state) {
            if(state is MoviesFailedState)
              return MyAppFailed(msg: state.msg);
            else if(state is MoviesSucessState)
              return Column(
                children: [
                  ...List.generate(state.movieModel.length, (index) =>
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.orange,
                          checkColor: Colors.blue,
                          shape: CircleBorder(),
                          value: checks[index],
                          onChanged: (value) {
                           setState(() {
                             checks[index]=value!;
                             print(state.movieModel[index].title + " - " + checks[index].toString() );
                           });
                          },
                      ),
                      SizedBox(width: 4.w,),
                      Text(state.movieModel[index].title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),)
                    ],
                  )
                  )
                ],
              );
            else
              return MyAppLoading();
          },
        )
      ),
    );
  }
}
