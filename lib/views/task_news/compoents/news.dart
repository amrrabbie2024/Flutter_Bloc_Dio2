part of '../view.dart';
class ANewsSection extends StatefulWidget {

  final String category;
  const ANewsSection({super.key, required this.category});

  @override
  State<ANewsSection> createState() => _ANewsSectionState();
}

final gbloc=GetIt.I<ANewsBloc>();

class _ANewsSectionState extends State<ANewsSection> {
  @override
  void initState() {
    gbloc.add(getANewsDataEvent(category: widget.category));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: gbloc,
      buildWhen: (previous, current) => current is AnewsLoadingState || current is AnewsSuccessState || current is AnewsFailedState,
      listener: (context, state) {
        if(state is AnewsFailedState)
          showMessage(state.msg);
        else if(state is AnewsSuccessState) {
          //showMessage("Success!",isSucess: true);
        }
        else if(state is AnewsPaginationState) {
          //showMessage(state.msg!, isSucess: true);
          _showProgressDialog(state.msg!);
        }
        else if(state is AnewsPaginationFinishedState)
          showMessage(state.msg!);
      },
      builder: (context, state) {
        if(state is AnewsFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
        else if(state is AnewsSuccessState)
          return _listItem(state.articles);
        else if(state is AnewsLoadingState)
          return Center(child: CircularProgressIndicator(color: Colors.green,backgroundColor: Colors.blue,strokeWidth: 6,));
        else
          return SizedBox.shrink();
      },
    );
  }

  Widget _listItem(List<AArticles> articles) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(getANewsDataEvent(category: widget.category));
        }
        return true;
      },
      child: ListView.separated(
          itemBuilder: (context, index) =>  _item(articles[index]),
          separatorBuilder: (context, index) => Padding(
            padding:  EdgeInsetsDirectional.symmetric(vertical: 8.h),
            child: Divider(color: Colors.grey,thickness: 4,indent: 24.w,endIndent: 24.w,),
          ),
          itemCount: articles.length
      ),
    );
  }

  Widget _item(AArticles article) {
    return Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(article: article,),));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(article.urlToImage!=null?article.urlToImage!:"",width: double.infinity,height: 160.h,fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) => ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/notfoundimage.jpg",width: double.infinity,height: 160.h,fit: BoxFit.fill,)),)),
            SizedBox(height: 4.h,),
            Directionality(textDirection: TextDirection.ltr,child: Text(article.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),maxLines: 2,overflow: TextOverflow.ellipsis)),
            SizedBox(height: 4.h,),
            Directionality(textDirection: TextDirection.ltr,child: Text(article.description,style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),maxLines: 3,overflow: TextOverflow.ellipsis,)),
            SizedBox(height: 4.h,),
          ],
        ),
      ),
    );
  }

  void _showProgressDialog(String msg) {
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
                Text(msg, style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }
}
