part of '../view.dart';
class MoviesHorizantalList extends StatefulWidget {
  const MoviesHorizantalList({super.key});

  @override
  State<MoviesHorizantalList> createState() => _MoviesHorizantalListState();
}

final kbloc=KiwiContainer().resolve<MoviesBloc>()..add(getMoviesDataEvent());

class _MoviesHorizantalListState extends State<MoviesHorizantalList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: BlocConsumer(
        bloc: kbloc,
        listener: (context, state) {
          if(state is MoviesFailedState)
            showMessage(state.msg);
          else if(state is MoviesSucessState)
            showMessage("Data Loading sucess ...",isSucess: true);
        },
        builder: (context, state) {
          if(state is MoviesFailedState)
            return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),));
          else if(state is MoviesLoadingState)
            return Center(child: CupertinoActivityIndicator(radius: 35.r, color: Theme.of(context).primaryColor,),);
          else if(state is MoviesSucessState)
            return _item(state.movieModel);
          else
            return Align(alignment: Alignment.topCenter,child: Text("No data exists",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24,)));
        },
      ),
    );
  }

  Widget _item(List<MovieModel> movies) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateTo(MovieDetails(movie_id: movies[index].id,movie_name: movies[index].title,));
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.network("http://image.tmdb.org/t/p/w500/${movies[index].posterPath}",width: 240.w,height: 220.h,fit: BoxFit.fill,)),
                Positioned(bottom: 15.h,child: Text(movies[index].title.length > 21?movies[index].title.substring(0,21)+" ...":movies[index].title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w900,fontSize: 22),))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => Padding(padding: EdgeInsetsDirectional.symmetric(horizontal: 4.w),child: VerticalDivider(thickness: 3,indent: 10.h,endIndent: 10.h,color: Theme.of(context).primaryColor,)),
        itemCount: movies.length
    );
  }
}
