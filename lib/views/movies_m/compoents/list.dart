part of '../view.dart';

class MoviesMList extends StatefulWidget {
  const MoviesMList({super.key});

  @override
  State<MoviesMList> createState() => _MoviesMListState();
}

final kbloc=KiwiContainer().resolve<MoviesMBloc>()..add(getMoviesMDataEvent());

class _MoviesMListState extends State<MoviesMList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: BlocBuilder(
        bloc: kbloc,
        builder: (context, state) {
          if(state is MoviesMFailedState)
            return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
          else if(state is MoviesMSuccessState)
            return _list(state.moviesList);
          else
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,backgroundColor: Colors.yellow,strokeWidth: 12,));
        },
      ),
    );
  }

  Widget _list(List<MovieM> movies) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (context, index) =>  _itemList(movies[index]),
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 4,indent: 30.h,endIndent: 30.h,),
        itemCount: movies.length
    );
  }

  Widget _itemList(MovieM movie) {
    return GestureDetector(
      onTap: () {
        print(movie.title);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieMDetailsView(id: movie.id,title: movie.title,),));
      },
      child: Container(
        alignment: AlignmentDirectional.bottomCenter,
        height: 120.h,
        width: 150.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage("http://image.tmdb.org/t/p/w500/${movie.posterPath}"),
                  fit: BoxFit.fill
          )
        ),
        child: Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
      ),
    );
  }
}
