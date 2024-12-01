import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/products/add_product/bloc.dart';
import 'package:flutter_apis_pagination/features/products/all_categories/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

final keyForm=GlobalKey<FormState>();
final titleController=TextEditingController();
final priceController=TextEditingController();
final descController=TextEditingController();
final imageController=TextEditingController();

final gggbloc=GetIt.I<AllCategoriesBloc>()..add(getAllCategoriesDataEvent());

final kkkbloc=KiwiContainer().resolve<AddProductBloc>();

String? currentCategory;

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Add product",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding:   EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment:    CrossAxisAlignment.stretch,
            children: [
              _titleText(),
              SizedBox(height: 16.h,),
              _priceText(),
              SizedBox(height: 16.h,),
              _descText(),
              SizedBox(height: 16.h,),
              _imageText(),
              SizedBox(height: 16.h,),
              _categoriesDownList(),
              SizedBox(height: 24.h,),
              BlocConsumer(
                bloc: kkkbloc,
                listener: (context, state) {
                  if(state is AddProductFailedState)
                    showMessage(state.msg);
                  else if(state is AddProductSuccessState)
                    showMessage("Add product with id ${state.data.id} success",isSucess: true);
                },
                builder: (context, state) {
                  if(state is AddProductFailedState)
                    return MyAppFailed(msg: state.msg);
                  else if(state is AddProductSuccessState)
                    return _addProductButton();
                  else if(state is AddProductLoadingState)
                    return MyAppLoading();
                  else
                    return _addProductButton();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText(){
    return TextFormField(
      controller: titleController,
      validator: (value) {
        if(value!.isNotEmpty)
          return "Must enter product title";
        else
          return null;
      },
      keyboardType:  TextInputType.text,
      decoration:   InputDecoration(
        hintText: "Type here product name",
        labelText: "Product name",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
      ),
    );
  }

  Widget _priceText(){
    return TextFormField(
      controller: priceController,
      validator: (value) {
        if(value!.isNotEmpty)
          return "Must enter product price";
        /*else if(double.parse(value) <=0)
          return "Must enter valid price";*/
         else return null;
      },
      keyboardType:  TextInputType.number,
      decoration:   InputDecoration(
        hintText: "Type here product price",
        labelText: "Product price",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
      ),
    );
  }

  Widget _descText(){
    return TextFormField(
      controller: descController,
      maxLines: 3,
      validator: (value) {
        if(value!.isNotEmpty)
          return "Must enter product description";
        else return null;
      },
      keyboardType:  TextInputType.text,
      decoration:   InputDecoration(
        hintText: "Type here product description",
        labelText: "Product description",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
      ),
    );
  }

  Widget _imageText(){
    return TextFormField(
      controller: imageController,
      validator: (value) {
        if(value!.isNotEmpty)
          return "Must enter product image";
        else
          return null;
      },
      keyboardType:  TextInputType.text,
      decoration:   InputDecoration(
        hintText: "Type here product image",
        labelText: "Product image",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide:  BorderSide(color: Theme.of(context).primaryColor)
        ),
      ),
    );
  }

  Widget _categoriesDownList(){
    return BlocBuilder(
        bloc: gggbloc,
      builder: (context, state) {
        if(state is AllCategoriesFailedState)
          return MyAppFailed(msg: state.msg);
        else if(state is AllCategoriesSuccessState)
          return _itemCategory(state.categories);
        else
          return MyAppLoading();
      },
    );
  }

  Widget _itemCategory(List<String> categories) {
    return DropdownButton(
       borderRadius: BorderRadius.circular(20.r),
        underline: SizedBox(),
        isExpanded: true,
        value: currentCategory,
        items:  List.generate(categories.length, (index) =>
        DropdownMenuItem(child: Text(categories[index],style: TextStyle(color:  Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.w500),),value: categories[index],)),
        onChanged: (value) {
        setState(() {
          currentCategory=value;
        });
        },
    );
  }

  Widget _addProductButton(){
    return SizedBox(
      height: 50.h,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
              side: BorderSide(color: Theme.of(context).primaryColor)
            )
          ),
          onPressed: () {
        //if(keyForm.currentState!.validate()){
          kkkbloc.add(postAddProductEvent(title: titleController.text, description: descController.text, image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg", category: currentCategory!,price: priceController.text));
       // }
      }, child: Text("Add product ...",style: TextStyle(color:  Theme.of(context).primaryColor,fontSize: 21,fontWeight: FontWeight.w500),)),
    );
  }

}
