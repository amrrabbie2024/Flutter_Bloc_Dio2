import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/features/products/all_products/bloc.dart';
import 'package:flutter_apis_pagination/views/products/all_products/update_product.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsView extends StatelessWidget {
  final AllProductsModel data;
  const ProductDetailsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(data.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight:  FontWeight.bold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Card(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          child: Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: AlignmentDirectional.topEnd,child: Image.network(data.image,width: 150.w,height: 180.h,fit: BoxFit.fill,)),
                SizedBox(height: 12.h,),
                Text(data.title,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600)),
                SizedBox(height: 8.h,),
                Text(data.description,style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 16,fontWeight: FontWeight.normal)),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data.rating.rate.toString(),style:TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.w600) ,),
                    SizedBox(width: 4.w,),
                    Icon(Icons.star,color: Colors.amber,size: 32,),
                    SizedBox(width: 4.w,),
                    Text("(${data.rating.count})",style:TextStyle(color: Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.w600) ,),
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProductView(data: data),));
                    }, icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,)),
                    Text(data.price.toString() + " \$",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),),
                    IconButton(onPressed: () {

                    }, icon: Icon(Icons.favorite_border,color: Theme.of(context).primaryColor,))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
