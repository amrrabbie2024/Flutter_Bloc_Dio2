
part of '../view.dart';
class YMoviesListSection extends StatefulWidget {
  const YMoviesListSection({super.key});

  @override
  State<YMoviesListSection> createState() => _YMoviesListSectionState();
}



class _YMoviesListSectionState extends State<YMoviesListSection> {

  final kbloc=KiwiContainer().resolve<YMoviesBloc>()..add(GetYMoviesDataEvent());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: BlocConsumer(
        bloc: kbloc,
        listener: (context, state) {
          if(state is YMoviesFailedState)
            showMessage(state.msg);
          else if(state is YMoviesSuccessState)
            showMessage("Success",isSucess: true);
        },
        builder: (context, state) {
          if(state is YMoviesFailedState)
            return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
          else if(state is YMoviesSuccessState)
            return _list(state.moviesList);
          else
            return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,backgroundColor: Colors.red,strokeWidth: 8,));
        },
      ),
    );
  }

  Widget _list(List<YMovieModel> moviesList) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>  _listItem(moviesList[index]),
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 3,indent: 30.h,endIndent: 30.h,),
        itemCount: moviesList.length
    );
  }

  Widget _listItem(YMovieModel movie) {
    return InkWell(
      onTap: () {
        showMessage(movie.title,isSucess: true);
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(Constants.MoviesImageUrl+movie.posterPath,fit: BoxFit.cover,height: 160.h,width: 150.w,)),
          Positioned(
            top: 10.h,
              child: Padding(
                padding:  EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                child: Text(movie.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: 22),),
              )),
        ],
      ),
    );
  }
}
