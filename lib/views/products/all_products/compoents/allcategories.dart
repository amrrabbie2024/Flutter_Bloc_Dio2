//part of '../view.dart';

/*class AllCategoriesSection extends StatefulWidget {
  const AllCategoriesSection({super.key});

  @override
  State<AllCategoriesSection> createState() => _AllCategoriesSectionState();
}

class _AllCategoriesSectionState extends State<AllCategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: BlocBuilder(
        bloc: gbloc,
        builder: (context, state) {
          if(state is AllCategoriesFailedState)
           return MyAppFailed(msg: state.msg,);
          else if(state is AllCategoriesSuccessState)
            return _categoriesList(state.categories);
          else
            return MyAppLoading();
        },
      )
    );
  }

  Widget _categoriesList(List<String> categories) {
    return ListView.separated(
      scrollDirection:  Axis.horizontal,
        itemBuilder: (context, index) =>  _categoriesItem(categories[index],index),
        separatorBuilder: (context, index) => VerticalDivider(color: Theme.of(context).primaryColor,thickness: 2,indent: 30.h,endIndent: 30.h,),
        itemCount: categories.length
    );
  }

  Widget _categoriesItem(String categorie, int index) {
    return InkWell(
      onTap: () {
        //category=categorie;
       // kkbloc.add(getAllProductsByCategoryDataEvent(category_name: categorie));
      },
      child: Container(
        width: 150.w,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Theme.of(context).primaryColor)
        ),
        child: Text(categorie,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 19),),
      ),
    );
  }
}*/
