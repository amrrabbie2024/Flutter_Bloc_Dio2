part of '../view.dart';

class _MoviesGrid extends StatefulWidget {
  const _MoviesGrid({super.key});

  @override
  State<_MoviesGrid> createState() => _MoviesGridState();
}

final gbloc=GetIt.I<VMoviesBloc>();

class _MoviesGridState extends State<_MoviesGrid> {

  @override
  void initState() {
    gbloc.add(getVMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer(
        bloc: gbloc,
        buildWhen: (previous, current) => current is VMoviesSuccessState || current is VMoviesFailedState || current is VMoviesLoadingState,
          listener: (context, state) {
            if(state is VMoviesFailedState)
              showMessage(state.msg);
            else if(state is VMoviesSuccessState)
              showMessage("items count:- ${state.moviesList.length}",isSucess: true);
            else if(state is VMoviesPaginationState)
              showMessage(state.msg!,isSucess: true);
            else if(state is VMoviesPaginationFinishedState)
              showMessage(state.msg!);
          },
        builder: (context, state) {
          if(state is VMoviesFailedState)
            return MyAppFailed(msg: state.msg);
          else if(state is VMoviesSuccessState)
            return _grid(state.moviesList);
          else
            return MyAppLoading();
        },
      ),
    );
  }

  Widget _grid(List<VMovieModel> movies) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(getVMoviesDataEvent());
        }
        return true;
      },
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: .45
          ),
          itemBuilder: (context, index) =>  _itemGrid(movies[index]),
        itemCount: movies.length,
      ),
    );
  }

  Widget _itemGrid(VMovieModel movie) {
    return GestureDetector(
      onTap: () {
        showMessage(movie.title,isSucess: true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => VMovieDetailsView(movie_name: movie.title, movie_id: movie.id),));
      },
      child: Card(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 4.w,vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.MoviesImageUrl+movie.posterPath,width: double.infinity,height: 180.h,fit: BoxFit.fill,)),
              SizedBox(height: 8.h,),
              Center(child: Text(movie.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 19,fontWeight: FontWeight.w600),)),
              SizedBox(height: 8.h,),
              Text(movie.releaseDate,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 19,fontWeight: FontWeight.w600),),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(movie.voteAverage.toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 19,fontWeight: FontWeight.w600),),
                  Icon(Icons.star,color: Colors.amber,size: 32,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
