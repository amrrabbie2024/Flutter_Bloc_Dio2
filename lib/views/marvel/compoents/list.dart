
part of '../view.dart';
class MarvelList extends StatefulWidget {
  const MarvelList({super.key});

  @override
  State<MarvelList> createState() => _MarvelListState();
}

final kbloc=KiwiContainer().resolve<MarvelBloc>();

class _MarvelListState extends State<MarvelList> {
  @override
  void initState() {
    kbloc.add(GetMarvelDataEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: kbloc,
      buildWhen: (previous, current) => current is MarvelSuccessState || current is MarvelFailedState || current is MarvelLoadingState,
      listener: (context, state) {
        if(state is MarvelFailedState)
          showMessage(state.msg);
        else if(state is MarvelSuccessState)
          showMessage("Items ${state.marvelsList.length}",isSucess: true);
        else if(state is MarvelPaginationState)
          _showProgressDialog(state.msg!);
          else if(state is MarvelPaginationFinishedState)
            showMessage(state.msg!);
      },
      builder: (context, state) {
        if(state is MarvelFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
        else if(state is MarvelSuccessState)
          return _list(state.marvelsList);
        else
          return Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor,radius: 35.r,));
      },
    );
  }

  Widget _list(List<MarvelModel> marvelsList) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          kbloc.add(GetMarvelDataEvent());
        }
        return true;
      },
      child: ListView.separated(
        //physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        //scrollDirection: Axis.vertical,
        itemCount: marvelsList.length,
          itemBuilder: (context, index) =>  _itemList(marvelsList[index]),
        separatorBuilder: (context, index) => SizedBox(height: 10.h,),
      ),
    );
  }

  Widget _itemList(MarvelModel marvel) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
            child: Image.network(marvel.thumbnail.path+"."+marvel.thumbnail.extension,fit: BoxFit.fill,width: double.infinity,height: 180.h,)),
        Directionality(
          textDirection: TextDirection.ltr,
            child: Text(marvel.name,maxLines:1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w900,fontSize: 26),))
      ],
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
