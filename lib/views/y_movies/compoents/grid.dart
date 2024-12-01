part of '../view.dart';
class YMoviesGridSection extends StatefulWidget {
  const YMoviesGridSection({super.key});

  @override
  State<YMoviesGridSection> createState() => _YMoviesGridSectionState();
}

class _YMoviesGridSectionState extends State<YMoviesGridSection> {

  final gbloc=GetIt.I<YMoviesBloc>();

  @override
  void initState() {
    gbloc.add(GetYMoviesDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer(
        bloc: gbloc,
        buildWhen: (previous, current) => current is YMoviesFailedState || current is YMoviesSuccessState || current is YMoviesLoadingState,
        listener: (context, state) {
          if(state is YMoviesFailedState)
            showMessage(state.msg);
          else if(state is YMoviesSuccessState)
            showMessage("Movies count:- ${state.moviesList.length}",isSucess: true);
          else if(state is YMoviesPaginationState)
            _showProgressDialog(state.msg);
          else if(state is YMoviesPaginationFinishedState)
            showMessage(state.msg!);
        },
        builder: (context, state) {
          if(state is YMoviesFailedState)
            return MyAppFailed(msg: state.msg);
          else if(state is YMoviesSuccessState)
            return _grid(state.moviesList);
          else
            return MyAppLoading();
        },
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

  Widget _grid(List<YMovieModel> moviesList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(GetYMoviesDataEvent());
        }
        return true;
      },
      child: GridView.builder(
          //physics: NeverScrollableScrollPhysics(),
          //shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8.h,
            crossAxisSpacing: 4.w,
            childAspectRatio: .8
          ),
          itemBuilder: (context, index) =>  _gridItem(moviesList[index]),
        itemCount: moviesList.length,
      ),
    );
  }

  Widget _gridItem(YMovieModel movie) {
    return GestureDetector(
      onTap: () {
        showMessage(movie.title,isSucess: true);
      },
        child: ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.MoviesImageUrl+movie.posterPath,fit: BoxFit.cover,height: 150.h,)));
  }
}
