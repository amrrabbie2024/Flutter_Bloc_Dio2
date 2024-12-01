part of '../view.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});

  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

List<Category> categories=[];
String m_category="general";

class _NewsCategoriesState extends State<NewsCategories> {
  @override
  Widget build(BuildContext context) {
    categories=getCategories();
    return SizedBox(
      height: 110.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
          itemBuilder: (context, index) => _categoryItem(categories[index]),),
    );
  }

 Widget _categoryItem(Category category) {
    return Padding(
      padding:  EdgeInsetsDirectional.only(end: 16.w),
      child: GestureDetector(
        onTap: () {
          setState(() {
            m_category=category.title;
            gbloc.add(getANewsDataEvent(category: m_category));
          });
        },
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          width: 140.w,
          height: 110.h,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/category/${category.image}"),fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(20.r)
          ),
          child: Text(category.title,style: TextStyle(color: Colors.green,fontSize: 22,fontWeight: FontWeight.bold),),
        ),
      ),
    );
 }
}
