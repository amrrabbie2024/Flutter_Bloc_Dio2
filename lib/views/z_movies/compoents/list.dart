part of '../view.dart';

class ZMoviesListSection extends StatefulWidget {
  const ZMoviesListSection({super.key});

  @override
  State<ZMoviesListSection> createState() => _ZMoviesListSectionState();
}

final kbloc=KiwiContainer().resolve<ZMoviesBloc>()..add(GetZMovieDataEvent());

class _ZMoviesListSectionState extends State<ZMoviesListSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: BlocConsumer(
        bloc: kbloc,
        listener: (context, state) {
          if(state is ZMoviesFailedState)
            showMessage(state.msg);
          else if(state is ZMoviesSuccessState)
            showMessage("Success",isSucess: true);
        },
        builder: (context, state) {
          if(state is ZMoviesFailedState)
            return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
          else if(state is ZMoviesSuccessState)
            return _list(state.moviesList);
          else
            return Center(child: CupertinoActivityIndicator(radius: 25.r,color: Theme.of(context).primaryColor,));
        },
      ),
    );
  }

  Widget _list(List<ZMovies> moviesList) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _listItem(moviesList[index],context), 
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 3,indent: 25.h,endIndent: 25.h,), 
        itemCount: moviesList.length
    );
  }

  _listItem(ZMovies movie, BuildContext context) {
    return InkWell(
      onTap: () {
        showMessage(movie.title,isSucess: true);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ZMovieDetailsSection(id: movie.id, title: movie.title),));
        navigateTo(ZMovieDetailsSection(id: movie.id, title: movie.title));
      },
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          ClipRRect(
           borderRadius: BorderRadius.circular(20.r)
          ,child: Image.network(Constants.MoviesImageUrl+ movie.posterPath,width: 180.w,height: 150.h,fit: BoxFit.fill,)),
          Positioned(
              right: 10,
              left: 10,
              child: Directionality(
                textDirection: TextDirection.ltr,
                  child: Center(child: Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 23),)))),
        ],
      ),
    );
  }
}
