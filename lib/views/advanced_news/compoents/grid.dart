part of '../view.dart';

class MyMoviesGrid extends StatefulWidget {
  const MyMoviesGrid({super.key});

  @override
  State<MyMoviesGrid> createState() => _MyMoviesGridState();
}

final gbloc=GetIt.I<AdMoviesBloc>();

class _MyMoviesGridState extends State<MyMoviesGrid> {
  @override
  void initState() {
    gbloc.add(getAdMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: gbloc,
      buildWhen: (previous, current) => current is AdMoviesSuccessState || current is AdMoviesFailedState || current is AdMoviesLoadingState,
      listener: (context, state) {
        if(state is AdMoviesFailedState)
          showMessage(state.msg);
        else if(state is AdMoviesPaginationState) {
          //showMessage(state.msg!, isSucess: true);
          _showProgressDialog(state.msg!);
        }
        else if(state is AdMoviesPaginationFinshedState)
          showMessage(state.msg!);
      },
      builder: (context, state) {
        if(state is AdMoviesFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
        else if(state is AdMoviesSuccessState)
          return _grid(state.movies);
        else
          return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,strokeWidth: 8,));
      },
    );
  }

  Widget _grid(List<AdMovies> movies) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(getAdMoviesDataEvent());
        }
        return true;
      },
      child: GridView.builder(
          //physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 24.h
          ),
          itemBuilder: (context, index) =>  _item(movies[index]),
        itemCount: movies.length,
      ),
    );
  }

  Widget _item(AdMovies movie) {
    return GestureDetector(
      onTap: () {
        print(movie.title);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(id: movie.id, title: movie.title),));
      },
      child: Card(
        color: Colors.yellow.withOpacity(.1),
        shadowColor: Colors.orange,
        elevation: 16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20.r),topEnd: Radius.circular(20.r)),
          side: BorderSide(color: Theme.of(context).primaryColor)
        ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 45.r,backgroundImage: NetworkImage("http://image.tmdb.org/t/p/w500/${movie.posterPath}"),),
              SizedBox(height: 12.h,),
              Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.bold),)),
              SizedBox(height: 12.h,),
              Directionality(textDirection: TextDirection.ltr,child: Text(movie.overview,maxLines: 4,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w500),)),
            ],
          ),

      ),
    );
  }

  void _showProgressDialog(String msg) {
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
                Text(msg, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}
