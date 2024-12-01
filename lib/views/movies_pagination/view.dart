import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/movies_pagination/bloc.dart';
import 'package:flutter_apis_pagination/views/movie_details/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class MoviesWithPagination extends StatefulWidget {
  const MoviesWithPagination({super.key});

  @override
  State<MoviesWithPagination> createState() => _MoviesWithPaginationState();
}

final gbloc=GetIt.I<PMoviesBloc>();

class _MoviesWithPaginationState extends State<MoviesWithPagination> {
  @override
  void initState() {
    gbloc.add(pGetMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies list with pagination"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: BlocConsumer(
          bloc: gbloc,
          buildWhen: (previous, current) => current is PMoviesSucessState || current is PMoviesFailedState || current is PMoviesLoadingState,
          listener: (context, state) {
            if(state is PMoviesFailedState)
              showMessage(state.msg);
            else if(state is PMoviesSucessState)
              showMessage(state.movieModel.length.toString(),isSucess: true);
            else if(state is PMoviesPaginationFinishedState)
              showMessage("No data found");
            else if(state is PMoviesPaginationState)
              //showMessage("Data loading ...",isSucess: true);

              showDialog(
                  context: context,
                  builder: (context) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      Navigator.of(context).pop(true);
                    });
                    return AlertDialog(
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 8.h,),
                          Text("Data loading ...",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 21),),
                        ],
                      ),
                    );
                  });
          },
          builder: (context, state) {
            if(state is PMoviesFailedState)
              return MyAppFailed(msg: state.msg);
            else if(state is PMoviesSucessState)
              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
                    gbloc.add(pGetMoviesDataEvent());
                  }
                  return true;
                },
                child: ListView.separated(
                    itemBuilder: (context, index) =>  _item(state.movieModel[index],context),
                    separatorBuilder: (context, index) => Divider(thickness: 4,color: Theme.of(context).primaryColor,indent: 25,endIndent: 25,),
                    itemCount: state.movieModel.length
                ),
              );
            else
              return MyAppLoading();
          },
        ),
      ),
    );
  }
}

Widget _item(PMovieModel movie, BuildContext context) {
  return Card(
    color: Colors.yellow.withOpacity(.3),
    shadowColor: Colors.orange,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(25),bottomEnd: Radius.circular(16)),
      side: BorderSide(color: Theme.of(context).primaryColor)
    ),
    child: Padding(
      padding:  EdgeInsets.all(8.r),
      child: ListTile(
        leading: CircleAvatar(radius: 65,backgroundImage: NetworkImage("http://image.tmdb.org/t/p/w500/${movie.posterPath}"),),
        title: Text(movie.title),
        subtitle: Row(
          children: [
            Text(movie.voteAverage.toString()),
            SizedBox(width: 4.w,),
            Icon(Icons.star,color: Colors.amber,)
          ],
        ),
        trailing: IconButton(onPressed: () {
          navigateTo(MovieDetails(movie_id: movie.id, movie_name: movie.title));
        }, icon: Icon(Icons.edit)),
      ),
    ),
  );
}
