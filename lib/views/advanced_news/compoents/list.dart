part of '../view.dart';

class MyMoviesList extends StatefulWidget {
  const MyMoviesList({super.key});

  @override
  State<MyMoviesList> createState() => _MyMoviesListState();
}

final kbloc=KiwiContainer().resolve<AdMoviesBloc>()..add(getAdMoviesDataEvent());

class _MyMoviesListState extends State<MyMoviesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: BlocConsumer(
        bloc: kbloc,
        listener: (context, state) {
          if(state is AdMoviesFailedState)
            showMessage(state.msg);
          else if(state is AdMoviesSuccessState)
            showMessage("Suceess,List data ...",isSucess: true);
        },
        builder: (context, state) {
          if(state is AdMoviesFailedState)
            return MyAppFailed(msg: state.msg);
          else if(state is AdMoviesSuccessState)
            return _list(state.movies);
          else
            return MyAppLoading();
        },
      ),
    );
  }

  Widget _list(List<AdMovies> movies) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>  _item(movies[index]),
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 2,indent: 25.h,endIndent: 25.h,),
        itemCount: movies.length
    );
  }

  Widget _item(AdMovies movie) {
    return InkWell(
      onTap: () {
        print(movie.title);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(id: movie.id, title: movie.title),));
      },
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        width: 120.w,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Theme.of(context).primaryColor) ,
          image: DecorationImage(
              image: NetworkImage("http://image.tmdb.org/t/p/w500/${movie.posterPath}"),fit: BoxFit.fill
          ),
        ),
        child: Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),)),
      ),
    );
  }
}
