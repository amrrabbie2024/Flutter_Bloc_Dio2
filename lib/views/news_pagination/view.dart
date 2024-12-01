import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/news_pagination/bloc.dart';
import 'package:flutter_apis_pagination/views/dialogs_sheets/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

class NewsPaginationView extends StatefulWidget {
  const NewsPaginationView({super.key});

  @override
  State<NewsPaginationView> createState() => _NewsPaginationViewState();
}

final keyForm=GlobalKey<FormState>();

final qController=TextEditingController(text: "");
final fromController=TextEditingController(text: "");
final toController=TextEditingController(text: "");
DateTime? datefrom,dateto;

final kbloc=KiwiContainer().resolve<NewsBloc>();
final gbloc=GetIt.I<NewsBloc>();

class _NewsPaginationViewState extends State<NewsPaginationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Pagination"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 16.w, vertical: 24.h),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: qController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Must type word to search with it";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  labelText: "Q word",
                  labelStyle: TextStyle(color: Colors.orange),
                  hintText: "Enter q word",
                  suffix: Icon(Icons.abc, color: Colors.orange,),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                ),
              ),
              SizedBox(height: 16.h,),
              TextFormField(
                onTap: () async {
                  datefrom = await showDatePicker(context: context,
                      firstDate: DateTime.now().add(Duration(days: -5)),
                      lastDate: DateTime.now().add(Duration(days: 5)),
                      initialDate: datefrom != null ? datefrom : DateTime
                          .now());
                  fromController.text = datefrom
                      .toString()
                      .split(" ")
                      .first;
                },
                controller: fromController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Must select date from";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  labelText: "from",
                  labelStyle: TextStyle(color: Colors.orange),
                  hintText: "Select date from",
                  suffix: Icon(
                    Icons.calendar_today_outlined, color: Colors.orange,),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                ),
              ),
              SizedBox(height: 16.h,),
              TextFormField(
                onTap: () async {
                  dateto = await showDatePicker(context: context,
                      firstDate: DateTime.now().add(Duration(days: -5)),
                      lastDate: DateTime.now().add(Duration(days: 5)),
                      initialDate: dateto != null ? dateto : DateTime.now()
                  );
                  toController.text = dateto
                      .toString()
                      .split(" ")
                      .first;
                },
                controller: toController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Must select date to";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  labelText: "to",
                  labelStyle: TextStyle(color: Colors.orange),
                  hintText: "Select date to",
                  suffix: Icon(
                    Icons.calendar_today_outlined, color: Colors.orange,),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))
                  ),
                ),
              ),
              SizedBox(height: 16.h,),
              BlocConsumer(
                buildWhen: (previous, current) =>
                current is NewsFailedState || current is NewsLoadingState ||
                    current is NewsSucessState,
                bloc: kbloc,
                listener: (context, state) {
                  if (state is NewsFailedState)
                    showMessage(state.msg);
                  else if (state is NewsSucessState)
                    showMessage("Items:- " + state.articles.length.toString(),
                        isSucess: true);
                  else if (state is NewsPaginationFinishedState)
                    showMessage(state.msg!);
                  else if (state is NewsPaginationState)
                    _showProgressDialog();
                },
                builder: (context, state) {
                  if(state is NewsFailedState)
                    return Column(
                      children: [
                         _SearchButton(),
                        SizedBox(height: 16.h,),
                        MyAppFailed(msg: state.msg),
                      ],
                    );
                  else if(state is NewsLoadingState)
                    return Column(
                      children: [
                        _SearchButton(),
                        SizedBox(height: 16.h,),
                        MyAlertDialog(),
                      ],
                    );
                  else if(state is NewsSucessState)
                    return  Column(
                      mainAxisSize: MainAxisSize.max,
                    children: [
                      _SearchButton(),
                      SizedBox(height: 16.h,),
                      _item(state.articles),
                    ],
                  );
                  else
                    return _SearchButton();
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _showProgressDialog() {
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
                Text("Data loading ...", style: TextStyle(color: Theme
                    .of(context)
                    .primaryColor, fontWeight: FontWeight.bold, fontSize: 21),),
              ],
            ),
          );
        });
  }

  Widget _SearchButton() {
    return SizedBox(
      height: 45.h,
      child: FilledButton.icon(onPressed: () {
        if(keyForm.currentState!.validate()){
          kbloc.add(getNewsDataEvent(q: qController.text, from: fromController.text, to: toController.text));
        }
      }, label: Text("Search ..."),icon: Icon(Icons.search),),
    );
  }


 Widget _item(List<Articles> articles) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if(notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
          kbloc.add(getNewsDataEvent(q: qController.text, from: fromController.text, to: toController.text));
        }
        return true;
      },
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.yellow.withOpacity(.3),
              shadowColor: Colors.orange,
              elevation: 4,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomRight: Radius.circular(16)),
                borderSide: BorderSide(color: Theme.of(context).primaryColor)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8.h,),
                  Text(articles[index].title,style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),),
                  SizedBox(height: 16.h,),
                  Text(articles[index].description.toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 21),),
                  SizedBox(height: 8.h,),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Padding(
            padding:  EdgeInsetsDirectional.symmetric(horizontal: 32.w,vertical: 8.h),
            child: Divider(color: Theme.of(context).primaryColor,thickness: 2,),
          ),
          itemCount: articles.length
      ),
    );
  }

}




