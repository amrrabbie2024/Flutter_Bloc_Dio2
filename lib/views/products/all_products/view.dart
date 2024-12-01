import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/products/all_categories/bloc.dart';
import 'package:flutter_apis_pagination/features/products/all_products/bloc.dart';
import 'package:flutter_apis_pagination/features/products/products_by_category/bloc.dart';
import 'package:flutter_apis_pagination/views/products/all_products/update_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

import 'add_product.dart';
import 'details.dart';

//part 'compoents/allproducts.dart';
//part 'compoents/allcategories.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

final kbloc=KiwiContainer().resolve<AllProductsBloc>()..add(getAllProductsDataEvent());
final gbloc=GetIt.I<AllCategoriesBloc>()..add(getAllCategoriesDataEvent());

final kkbloc=KiwiContainer().resolve<ProductsByCategoryBloc>();

String? category;

bool isVisible=false;

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Products"),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight:  FontWeight.bold,fontSize: 26),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            navigateTo(AddProductView(),withHistory: true);
          }, icon: Icon(FontAwesomeIcons.add,color: Theme.of(context).primaryColor,)),
          SizedBox(width: 8.w,),
          IconButton(onPressed: () {
            setState(() {
              isVisible=!isVisible;
            });
          }, icon: Icon(FontAwesomeIcons.filter,color: Theme.of(context).primaryColor,))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(visible: isVisible,child:  AllCategoriesSection()),
              SizedBox(height: isVisible?16.h:0,),
              AllProductsSection(),
            ],
          ),
        ),
      ),
    );
  }


 Widget AllProductsSection() {
    return BlocConsumer(
      bloc: category==null?kbloc:kkbloc,
      listener: (context, state) {
        /*if(state is ALlProductsFailedState){
          showMessage(state.msg);
        }else if(state is ALlProductsSuccessState){
          showMessage("items coint:- ${state.data.length}",isSucess: true);
        }*/
      },
      builder: (context, state) {
        if(state is ALlProductsFailedState)
          return Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),));
        else if(state is ALlProductsSuccessState)
          return _grid(state.data);
        else
          return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,backgroundColor: Colors.blue,strokeWidth: 8,));
      },
    );
  }

  Widget _grid(List<AllProductsModel> data) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 60.h,
            crossAxisSpacing: 16.w,
            childAspectRatio: 1
        ),
        itemBuilder: (context, index) =>  _itemGrid(data[index]),
        itemCount: data.length,
      ),
    );
  }

  Widget _itemGrid(AllProductsModel data) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsView(data: data),));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: AlignmentDirectional.bottomStart,
            width: MediaQuery.of(context).size.width/2,
            height: MediaQuery.of(context).size.height/5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Theme.of(context).primaryColor)
              //color: Colors.black
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45.h,),
                Center(child: Directionality(textDirection: TextDirection.ltr,child: Text(data.title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,))),
                //SizedBox(height: 2.h,),
                //Center(child: Text(data.price.toString() + " \$",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),)),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.rating.rate.toString(),style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500) ,),
                    SizedBox(width: 4.w,),
                    Icon(Icons.star,color: Colors.amber,size: 32,),
                    SizedBox(width: 4.w,),
                    Text("(${data.rating.count})",style:TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500) ,),
                  ],
                ),
                // SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProductView(data: data),));
                    }, icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                    Text(data.price.toString() + " \$",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.favorite_border,color: Theme.of(context).primaryColor,))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              right: 10,
              top: -50,
              child: Image.network(data.image,width: 90.w,height: 90.h,fit: BoxFit.fill,)),
        ],
      ),
    );
  }

  Widget AllCategoriesSection() {
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
        setState(() {
          category=categorie;
        });
         kkbloc.add(getAllProductsByCategoryDataEvent(category_name: categorie));
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


}
