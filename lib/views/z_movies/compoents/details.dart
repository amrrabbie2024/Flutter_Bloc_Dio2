part of '../view.dart';

class ZMovieDetailsSection extends StatefulWidget {
  final int id;
  final String title;
  const ZMovieDetailsSection({super.key, required this.id, required this.title});

  @override
  State<ZMovieDetailsSection> createState() => _ZMovieDetailsSectionState();
}

final ggbloc=GetIt.I<ZMovieDetailsBloc>();

class _ZMovieDetailsSectionState extends State<ZMovieDetailsSection> {

  @override
  void initState() {
    ggbloc.add(GetZMovieDetailsDataEvent(id: widget.id));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 36.w,vertical: 24.h),
          child: BlocConsumer(
            bloc: ggbloc,
            listener: (context, state) {
              if(state is ZMovieDetailsFailedState)
                showMessage(state.msg);
              else if(state is ZMovieDetailsSuccessState)
                showMessage("Sucesss",isSucess: true);
            },
            builder: (context, state) {
              if(state is ZMovieDetailsFailedState)
                return MyAppFailed(msg: state.msg);
              else if(state is ZMovieDetailsSuccessState)
                return _details(state.data);
              else
                return MyAppLoading();
            },
          ),
        ),
      ),
    );
  }

  Widget _details(ZMovieDetailsData movie) {
    return Column(
      crossAxisAlignment:  CrossAxisAlignment.center,
      children: [
        Text(movie.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 16.h,),
        ClipOval(child: Image.network(Constants.MoviesImageUrl + movie.posterPath,width: double.infinity,height: 280.h,fit: BoxFit.fill,)),
        SizedBox(height: 16.h,),
        Text(movie.overview,style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5),fontSize: 18,fontWeight: FontWeight.normal),),
        SizedBox(height: 16.h,),
        Text(movie.releaseDate,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        SizedBox(height: 16.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(movie.voteAverage.toString() + " ( " + movie.voteCount.toString() + " ) ",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
            SizedBox(width: 8.w,),
            Icon(Icons.star,color: Colors.amber,size: 48.r,),
          ],
        ),
      ],
    );
  }
}
