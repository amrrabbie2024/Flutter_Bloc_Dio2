part of '../view.dart';
class MovieMDetailsView extends StatefulWidget {
  final int id;
  final String title;
  const MovieMDetailsView({super.key, required this.id, required this.title});

  @override
  State<MovieMDetailsView> createState() => _MovieMDetailsViewState();
}

final ggbloc=GetIt.I<MovieMDetailsBloc>();

class _MovieMDetailsViewState extends State<MovieMDetailsView> {
  @override
  void initState() {
    ggbloc.add(getMovieMDetailsDataEvent(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(top: 24.h,start: 16.w,end: 16.w,bottom: 16.h),
        child: BlocConsumer(
          bloc: ggbloc,
          listener: (context, state) {

          },
          builder: (context, state) {
            if(state is MovieMDetailsFailedState)
              return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
            else if(state is MovieMDetailsSuccessState)
              return _item(state.details);
            else
              return Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor,radius: 30.r,));
          },
        ),
      ),
    );
  }

  Widget _item(MovieMDetailsData movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(24),child: Image.network("http://image.tmdb.org/t/p/w500/${movie.posterPath}",width: double.infinity,height: 260.h,fit: BoxFit.fill,)),
        SizedBox(height: 16.h,),
        Text(movie.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
        SizedBox(height: 16.h,),
        Text(movie.overview,style: TextStyle(color: Colors.white.withOpacity(.4),fontWeight: FontWeight.normal,fontSize: 21),),
        SizedBox(height: 16.h,),
        Text(movie.releaseDate,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.voteAverage.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
            SizedBox(width: 4.w,),
            Icon(Icons.star,color: Colors.amber,size: 32,)
          ],
        ),
      ],
    );
  }
}
