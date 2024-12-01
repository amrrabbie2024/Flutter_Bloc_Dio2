
part of '../view.dart';
class GNewsSection extends StatefulWidget {
  final String category;
  const GNewsSection({super.key, required this.category});

  @override
  State<GNewsSection> createState() => _GNewsSectionState();
}

final gbloc=GetIt.I<GNewsBloc>();

class _GNewsSectionState extends State<GNewsSection> {
  @override
  void initState() {
    gbloc.add(getGNewsDataEvent(category: widget.category));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: gbloc,
      buildWhen: (previous, current) => current is GNewsFailedState || current is GNewsSuccessState || current is GNewsLoadingState,
      listener: (context, state) {
        if(state is GNewsFailedState)
          showMessage(state.msg);
        else if(state is GNewsPaginationState)
          _showProgressDialog(state.msg!);
        else if(state is GNewsPaginationFinishedState)
          showMessage(state.msg!,isSucess: true);
      },
      builder: (context, state) {
        if(state is GNewsFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),));
        else if(state is GNewsSuccessState)
          return  _news(state.data);
        else
         return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,backgroundColor: Colors.blue,strokeWidth: 8.r,));

      },
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

  Widget _news(List<GArticles> articles) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          gbloc.add(getGNewsDataEvent(category: widget.category));
        }
        return true;
      },
      child: ListView.separated(
          itemBuilder: (context, index) =>  _newsItem(articles[index]),
          separatorBuilder: (context, index) => Divider(color: Colors.grey,thickness: 4,indent: 35.w,endIndent: 35.w,),
          itemCount: articles.length
      ),
    );
  }

  Widget _newsItem(GArticles article) {
    return GestureDetector(
      onTap: () async {
        Uri _url = Uri.parse(article.url);
        if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
        }
      },
      child: Card(
        color: Colors.grey.withOpacity(.3),
        shadowColor: Colors.grey,
        elevation: 8,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.yellow)
        ),
        child: Padding(
          padding:  EdgeInsets.all(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network(article.image,width: double.infinity,height: 120.h,fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) => ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/notfoundimage.jpg",width: double.infinity,height: 120.h,fit: BoxFit.fill,)),)),
              SizedBox(height: 8.h,),
              Directionality(textDirection: TextDirection.rtl,child: Text(article.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600),)),
              SizedBox(height: 8.h,),
              Directionality(textDirection: TextDirection.rtl,child: Text(article.description,maxLines: 4,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.normal),)),
            ],
          ),
        ),
      ),
    );
  }
}
