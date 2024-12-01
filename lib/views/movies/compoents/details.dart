import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/constants.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/v_movies/details/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

class VMovieDetailsView extends StatefulWidget {

  final String movie_name;
  final int movie_id;
  const VMovieDetailsView({super.key, required this.movie_name, required this.movie_id});

  @override
  State<VMovieDetailsView> createState() => _VMovieDetailsViewState();
}

final kkbloc=KiwiContainer().resolve<VMovieDetailsBloc>();

class _VMovieDetailsViewState extends State<VMovieDetailsView> {

  @override
  void initState() {
    kkbloc.add(getVMovieDetailsDataEvent(id: widget.movie_id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie_name,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 28),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
          child: BlocConsumer(
            bloc: kkbloc,
            listener: (context, state) {
              if(state is VMovieDetailsFailedState)
                showMessage(state.msg);
              else if(state is VMovieDetailsSuccessState)
                showMessage("Success",isSucess: true);
            },
            builder: (context, state) {
              if(state is VMovieDetailsFailedState)
                return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
              else if(state is VMovieDetailsSuccessState)
                return _itemDetails(state.data);
              else
                return Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor,radius: 35.r,));
            },
          ),
        ),
      ),
    );
  }

  Widget _itemDetails(VMovieDetailsData movie) {
    return Card(
      //color: Colors.grey.withOpacity(.3),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide(color: Theme.of(context).primaryColor)
      ),
      shadowColor: Theme.of(context).primaryColor,
      elevation: 4,
      child: Padding(
        padding:  EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 90.r,backgroundImage: NetworkImage(Constants.MoviesImageUrl+movie.posterPath),),
            SizedBox(height: 16.h,),
            Directionality(textDirection: TextDirection.ltr, child: Text(movie.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),)),
            SizedBox(height: 16.h,),
            Directionality(textDirection: TextDirection.ltr, child: Text(movie.overview,maxLines: 7,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5),fontSize: 21,fontWeight: FontWeight.normal),)),
            SizedBox(height: 16.h,),
            Text(movie.releaseDate,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.bold),),
            SizedBox(height: 16.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(movie.voteAverage.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.bold),),
                SizedBox(width: 4.w,),
                Icon(Icons.star,color: Colors.amber,size: 48,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
