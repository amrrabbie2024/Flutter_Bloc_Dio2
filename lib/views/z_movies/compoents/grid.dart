part of '../view.dart';
class ZMoviesGridSection extends StatefulWidget {
  const ZMoviesGridSection({super.key});

  @override
  State<ZMoviesGridSection> createState() => _ZMoviesGridSectionState();
}

final gbloc=GetIt.I<ZMoviesBloc>();

class _ZMoviesGridSectionState extends State<ZMoviesGridSection> {
  @override
  void initState() {
    gbloc.add(GetZMovieDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer(
        bloc: gbloc,
        buildWhen: (previous, current) => current is ZMoviesSuccessState || current is ZMoviesFailedState || current is ZMoviesLoadingState,
        listener: (context, state) {
          if(state is ZMoviesFailedState)
            showMessage(state.msg);
          else if(state is ZMoviesSuccessState)
            showMessage("Items: ${state.moviesList.length}",isSucess: true);
          else if(state is ZMoviesPaginationState)
            _showProgressDialog(state.msg);
          else if(state is ZMoviesPaginationFinishedState)
            showMessage(state.msg!);
        },
        builder: (context, state) {
          if(state is ZMoviesFailedState)
            return MyAppFailed(msg: state.msg);
          else if(state is ZMoviesSuccessState)
            return _grid(state.moviesList);
          else
            return MyAppLoading();
        },
      ),
    );
  }



  Widget _grid(List<ZMovies> moviesList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(GetZMovieDataEvent());
        }
        return true;
      },
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: .6
          ),
          itemBuilder: (context, index) => _gridItem(moviesList[index],context),
        itemCount: moviesList.length,
      ),
    );
  }



  _gridItem(ZMovies movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMessage(movie.title,isSucess: true);
        navigateTo(ZMovieDetailsSection(id: movie.id, title: movie.title));
      },
      child: Card(
        //color: Colors.yellow.withOpacity(.1),
        shadowColor: Theme.of(context).primaryColor,
        elevation: 8,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
          borderSide: BorderSide(color: Theme.of(context).primaryColor)
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 60.r,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 57.r,backgroundImage: NetworkImage(Constants.MoviesImageUrl+movie.posterPath),)),
              SizedBox(height: 8.h,),
              Text(movie.title,overflow:TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),),
              SizedBox(height: 8.h,),
              Text(movie.releaseDate,overflow:TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),),
              SizedBox(height: 8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(movie.voteAverage.toString(),overflow:TextOverflow.ellipsis,maxLines:1,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 21),),
                  SizedBox(width: 4.w,),
                  Icon(Icons.star,color: Colors.amber,size: 32.r,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProgressDialog(String? msg) {
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
                Text(msg!, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}
