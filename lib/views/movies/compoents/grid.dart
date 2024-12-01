part of '../view.dart';
class MoviesGrid extends StatefulWidget {
  const MoviesGrid({super.key});

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

final gbloc=GetIt.I<MoviesBloc>()..add(getMoviesDataEvent());

class _MoviesGridState extends State<MoviesGrid> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: gbloc,
      listener: (context, state) {
        if(state is MoviesFailedState)
          showMessage(state.msg);
        else if(state is MoviesSucessState)
          showMessage("Data loading sucess ...",isSucess: true);
      },
      builder: (context, state) {
        if(state is MoviesFailedState)
          return MyAppFailed(msg: state.msg);
        else if(state is MoviesLoadingState)
          return MyAppLoading();
        else if(state is MoviesSucessState)
          return _item(state.movieModel);
        else
          return MyAppFailed(msg: "No data exists");
      },
    );
  }

  Widget _item(List<MovieModel> movies) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: (MediaQuery.of(context).size.width/2)/280.h
        ),
        itemBuilder: (context, index) =>  _gridItem(movies[index]),
        itemCount: movies.length ,
    );
  }

  Widget _gridItem(MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movie_id: movie.id, movie_name: movie.title,),));
      },
      child: Card(
        color: Colors.yellow.withOpacity(.3),
        shadowColor: Colors.orange,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(25),topEnd: Radius.circular(16)),
          side: BorderSide(color: Theme.of(context).primaryColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8.h,),
            ClipOval(child: MyAppImage(url: "http://image.tmdb.org/t/p/w500/${movie.posterPath}",width: 150.w,height: 120.h,fit: BoxFit.scaleDown,)),
            SizedBox(height: 8.h,),
            Text(movie.title.length>18?movie.title.substring(0,18)+" ...":movie.title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 20),),
            SizedBox(height: 8.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(movie.voteAverage.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.w600,fontSize: 20),),
                SizedBox(width: 4.w,),
                Icon(Icons.star,color: Colors.amber,)
              ],
            ),
            SizedBox(height: 8.h,),
            Text(movie.releaseDate,style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 20),),
          ],
        ),
      ),
    );
  }
}
