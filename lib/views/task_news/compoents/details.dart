part of '../view.dart';

class NewsDetails extends StatelessWidget {
  final AArticles article;
  const NewsDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("News details",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 36.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(textDirection: TextDirection.ltr,child: Text(article.title,style: TextStyle(fontSize: 24 ,fontWeight: FontWeight.w600),maxLines: 3,overflow: TextOverflow.ellipsis,)),
              SizedBox(height: 8.h,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(article.urlToImage!=null?article.urlToImage!:"",width: MediaQuery.of(context).size.width,height: 180.h,fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) => ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset("assets/images/notfoundimage.jpg",width: MediaQuery.of(context).size.width,height: 180.h,fit: BoxFit.fill,)),),
              ),
              SizedBox(height: 8.h,),
              Directionality( textDirection: TextDirection.ltr,child: Text(article.description,style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w500),maxLines: 6,overflow: TextOverflow.ellipsis,)),
              SizedBox(height: 8.h,),
              Text(article.source.name,style: TextStyle(fontSize: 21,fontWeight: FontWeight.normal),),
              SizedBox(height: 8.h,),
              Text(article.publishedAt.split("T").first,style: TextStyle(fontSize: 21,fontWeight: FontWeight.normal),),
              SizedBox(height: 8.h,),
              Text(article.author!=null?article.author!:"",style: TextStyle(fontSize: 21,fontWeight: FontWeight.normal),),
            ],
          ),
        ),
      ),
    );
  }
}
