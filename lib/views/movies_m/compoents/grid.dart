 part of '../view.dart';
class MoviesMGrid extends StatefulWidget {
  const MoviesMGrid({super.key});

  @override
  State<MoviesMGrid> createState() => _MoviesMGridState();
}

final gbloc=GetIt.I<MoviesMBloc>();

class _MoviesMGridState extends State<MoviesMGrid> {
 @override
  void initState() {
    gbloc.add(getMoviesMDataEvent());
    super.initState();
  }
 @override
 Widget build(BuildContext context) {
  return Expanded(
    child: BlocConsumer(
     bloc: gbloc,
     buildWhen: (previous, current) =>
     current is MoviesMSuccessState || current is MoviesMFailedState ||
         current is MoviesMLoadingState,
     listener: (context, state) {
      if (state is MoviesMPaginationState)
       _showProgressDialog(state.msg);
      else if (state is MoviesMPaginationFinsihedState)
       showMessage(state.msg!, isSucess: true);
     },
     builder: (context, state) {
      if (state is MoviesMFailedState)
       return MyAppFailed(msg: state.msg,);
      else if (state is MoviesMSuccessState)
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

 Widget _grid(List<MovieM> movies) {
  return NotificationListener<ScrollNotification>(
   onNotification: (notification) {
     if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
      gbloc.add(getMoviesMDataEvent());
     }
     return true;
   },
    child: GridView.builder(
     //shrinkWrap: true,
     //physics: NeverScrollableScrollPhysics(),
     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         mainAxisSpacing: 16.h,
         crossAxisSpacing: 8.w,
         childAspectRatio: .9
     ),
     itemBuilder: (context, index) => _itemGrid(movies[index]),
     itemCount: movies.length,
    ),
  );
 }

 Widget _itemGrid(MovieM movie) {
  return InkWell(
   onTap: () {
     print(movie.title);
     Navigator.push(context, MaterialPageRoute(builder:  (context) => MovieMDetailsView(id: movie.id, title: movie.title),));
   },
    child: Card(
     color: Theme.of(context).primaryColor.withOpacity(.1),
     shadowColor: Theme.of(context).primaryColor,
     elevation: 8,
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
      side: BorderSide(color: Theme.of(context).primaryColor)
     ),
     child: Padding(
       padding:  EdgeInsets.all(8.r),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         SizedBox(height: 8.h,),
         CircleAvatar(radius: 60,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 58,backgroundImage: NetworkImage("http://image.tmdb.org/t/p/w500/${movie.posterPath}"),)),
         SizedBox(height: 8.h,),
         Center(child: Directionality(textDirection: TextDirection.ltr,child: Text(movie.title,maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),))),
        ],
       ),
     ),
    ),
  );
 }
}
