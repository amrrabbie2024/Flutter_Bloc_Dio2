part of '../view.dart';

class MovieDetails extends StatefulWidget {
  final int id;
  final String title;
  const MovieDetails({super.key, required this.id, required this.title});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

final ggbloc=GetIt.I<AdMovieDetailsBloc>();

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    ggbloc.add(getAdMovieDetailsDataEvent(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Directionality(textDirection: TextDirection.ltr,child: Text(widget.title,style: TextStyle(color: Colors.blue,fontSize: 22,fontWeight: FontWeight.w600),maxLines: 1,overflow: TextOverflow.ellipsis,)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 36.h),
        child: BlocConsumer(
          bloc: ggbloc,
          listener: (context, state) {
            if(state is AdMoviesDetailsFailedState)
              showMessage(state.msg);
            else if(state is AdMoviesDetailsSuccessState)
              showMessage("Movie ${state.movie.title} data",isSucess: true);
          },
          builder: (context, state) {
            if(state is AdMoviesDetailsSuccessState)
              return Expanded(child: _details(state.movie));
            else if(state is AdMoviesDetailsFailedState)
              return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
            else
              return  Center(child: CupertinoActivityIndicator(radius: 35.r,color: Theme.of(context).primaryColor,));
          },
        )
      ),
    );
  }

  Widget _details(AdMovieDetailsData movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(child: Image.network("http://image.tmdb.org/t/p/w500/${movie.posterPath}",width: double.infinity,height: 200.h,fit: BoxFit.fill,)),
        SizedBox(height: 16.h,),
        Text(movie.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        SizedBox(height: 16.h,),
        Text(movie.overview,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 21),),
        SizedBox(height: 16.h,),
        Text(movie.releaseDate,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.voteAverage.toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
            SizedBox(width: 4.w,),
            Icon(Icons.star,color: Colors.amber,)
          ],
        ),
      ],
    );
  }
}
