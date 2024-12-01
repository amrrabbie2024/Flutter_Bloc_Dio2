part of '../view.dart';

class GCategorySection extends StatefulWidget {
  const GCategorySection({super.key});

  @override
  State<GCategorySection> createState() => _GCategorySectionState();
}

class _GCategorySectionState extends State<GCategorySection> {
  List<Category> categories=getCategories();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>  _categoryList(categories[index]),
          separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 4,indent: 15.h,endIndent: 15.h,),
          itemCount: categories.length
      ),
    );
  }

  Widget _categoryList(Category category) {
    return InkWell(
      onTap: () {
        gcategory=category.title;
        gbloc.add(getGNewsDataEvent(category: gcategory));
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(20.r),child: Image.network("assets/images/category/${category.image}",width: 150.w,height: 120.h,fit: BoxFit.fill,)),
          Positioned(bottom: 40.h,child: Directionality(textDirection: TextDirection.ltr,child: Text(category.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,)))
        ],
      ),
    );
  }
}
