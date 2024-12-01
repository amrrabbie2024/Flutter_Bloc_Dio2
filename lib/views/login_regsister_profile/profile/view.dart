import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login_regsister_profile/profile/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class VProfileView extends StatefulWidget {
  const VProfileView({super.key});

  @override
  State<VProfileView> createState() => _VProfileViewState();
}

final gbloc=GetIt.I<VProfileBloc>()..add(getVProfileDataevent(id: CashHelper.getLoginId()));

class _VProfileViewState extends State<VProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 24),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: BlocConsumer(
            bloc: gbloc,
            builder: (context, state) {
              if(state is VProfileFailedState)
                return MyAppFailed(msg: state.msg);
              else if(state is VProfileSuccessState)
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Name:- ${state.data.user.name}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),),
                    SizedBox(height: 16.h,),
                    Text("Phone:- ${state.data.user.phone}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),),
                    SizedBox(height: 16.h,),
                    Text("Email:- ${state.data.user.email}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),),
                    SizedBox(height: 16.h,),
                    Text("Created at:- ${state.data.user.createdAt.toString().split("T").first}",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.w600),),
                    SizedBox(height: 16.h,),
                  ],
                );
              else
                return MyAppLoading();
            },
            listener: (context, state) {
              if(state is VProfileFailedState)
                showMessage(state.msg);
              else if(state is VProfileSuccessState)
                showMessage("Success",isSucess: true);
            },
          ),
        ),
      ),
    );
  }
}
