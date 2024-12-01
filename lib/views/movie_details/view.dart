import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_image.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/movie_details/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

class MovieDetails extends StatefulWidget {
  final  int movie_id;
  final String movie_name;

  const MovieDetails({super.key, required this.movie_id, required this.movie_name});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

final kbloc=KiwiContainer().resolve<MovieDetailsBloc>();

class _MovieDetailsState extends State<MovieDetails> {
  
  @override
  void initState() {
    kbloc.add(getMovieDetailsDataEvent(movie_id: widget.movie_id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie_name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: BlocConsumer(
          bloc: kbloc,
          listener: (context, state) {
            if(state is MovieDetailsFailedState)
              showMessage(state.msg);
            else if(state is MovieDetailsSucessState)
              showMessage(state.movieDetailsData.title,isSucess: true);
          },
          builder: (context, state) {
            if(state is MovieDetailsFailedState)
             return MyAppFailed(msg: state.msg,);
            else if(state is MovieDetailsSucessState)
              return Column(
                children: [
                  Center(child: ClipRRect(borderRadius: BorderRadius.circular(25),child: MyAppImage(url: "http://image.tmdb.org/t/p/w500/${state.movieDetailsData.posterPath}",width: 240.w,height: 220.h,fit: BoxFit.fill,))),
                  SizedBox(height: 16.h,),
                  Center(child: Text(state.movieDetailsData.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.bold),)),
                  SizedBox(height: 16.h,),
                  Center(child: Text(state.movieDetailsData.overview,style: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 18,fontWeight: FontWeight.normal),)),
                  SizedBox(height: 16.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.movieDetailsData.voteAverage.toString(),style: TextStyle(color: Colors.red,fontSize: 21,fontWeight: FontWeight.bold),),
                      SizedBox(width: 4.w,),
                      Icon(Icons.star,color: Colors.amber,)
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  Center(child: Text(state.movieDetailsData.releaseDate,style: TextStyle(color: Colors.blue,fontSize: 21,fontWeight: FontWeight.bold),)),
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
