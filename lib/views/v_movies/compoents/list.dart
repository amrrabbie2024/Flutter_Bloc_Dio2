part of '../view.dart';
class _MoviesList extends StatefulWidget {
  const _MoviesList({super.key});

  @override
  State<_MoviesList> createState() => _MoviesListState();
}

final kbloc=KiwiContainer().resolve<VMoviesBloc>()..add(getVMoviesDataEvent());

class _MoviesListState extends State<_MoviesList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: BlocConsumer(
        bloc: kbloc,
        listener: (context, state) {
          if(state is VMoviesFailedState) {
            //showMessage(state.msg);
          }
          else if(state is VMoviesSuccessState) {
            //showMessage("Success",isSucess: true);
          }
        },
        builder: (context, state) {
          if(state is VMoviesFailedState)
            return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
          else if(state is VMoviesSuccessState)
            return _list(state.moviesList);
          else
            return Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor,radius: 35.r,));
        },
      ),
    );
  }

  Widget _list(List<VMovieModel> movies) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>  _itemList(movies[index]),
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 3,indent: 20.h,endIndent: 20.h,),
        itemCount: movies.length
    );
  }

  Widget _itemList(VMovieModel movie) {
    return InkWell(
      onTap: () {
        showMessage(movie.title,isSucess: true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => VMovieDetailsView(movie_name: movie.title, movie_id: movie.id),));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(Constants.MoviesImageUrl+movie.posterPath,width: 150.w,height: 120.h,fit: BoxFit.fill,)),
          Positioned(
            bottom: 15.h,
              child: Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 19,fontWeight: FontWeight.w500),)))
        ],
      ),
    );
  }
}
