import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_image.dart';
import 'package:flutter_apis_pagination/core/design/app_input.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/core/logic/input_validation.dart';
import 'package:flutter_apis_pagination/features/login/bloc.dart';
import 'package:flutter_apis_pagination/views/home/view.dart';
import 'package:flutter_apis_pagination/views/signup/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/design/app_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

final keyForm=GlobalKey<FormState>();
final phoneController=TextEditingController(text: "966132847241864");
final passwordController=TextEditingController(text: "123456789");

bool isPassword=true;

final kbloc=KiwiContainer().resolve<LoginBloc>();
final gbloc=GetIt.I<LoginBloc>();

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 36.h),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Center(child: ClipOval(child: MyAppImage(url: "login.jpg",width: 120.w,height: 90.h,))),
                CircleAvatar(radius: 55,backgroundColor: Theme.of(context).primaryColor,child: CircleAvatar(radius: 52,backgroundImage: AssetImage("assets/images/login.jpg"),)),
                SizedBox(height: 36.h,),
                MyAppInput(
                  controller: phoneController,
                  validator: InputValidation.phone,
                  labelText: "Phone number",
                  hintText: "Enter phone number",
                  keyboardType: TextInputType.phone,
                  prefix: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
                ),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: passwordController,
                  validator: InputValidation.password,
                  labelText: "Password",
                  hintText: "Enter password",
                  keyboardType: TextInputType.text,
                  prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
                  obscureText: isPassword,
                  suffix: IconButton(onPressed: () {
                    setState(() {
                      isPassword=!isPassword;
                    });
                  }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
                ),
                SizedBox(height: 24.h,),
                BlocConsumer(
                  bloc: kbloc,
                  listener: (context, state) {
                    if(state is LoginFailedState)
                      showMessage(state.msg);
                    else if(state is LoginSuccessState) {
                      CashHelper.saveUserData(state.loginModel);
                      showMessage("Login sucess,welcome ${state.loginModel.fullname}", isSucess: true);
                      navigateTo(MyHomeView(),withHistory: false);
                    }
                  },
                  builder: (context, state) {
                    if(state is LoginLoadingState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MyLoginButton(),
                          SizedBox(height: 16.h,),
                          MyAppLoading(),
                        ],
                      );
                    else if(state is LoginFailedState)
                      return  Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MyLoginButton(),
                          SizedBox(height: 16.h,),
                          MyAppFailed(msg: state.msg),
                        ],
                      );
                    else if(state is LoginSuccessState)
                      return MyLoginButton();
                    else
                      return MyLoginButton();
                  },
                ),
                SizedBox(height: 24.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not have account?",style: TextStyle(fontSize: 24),),
                    SizedBox(width: 4.w,),
                    TextButton(onPressed: () {
                      navigateTo(SignupView());
                    }, child: Text("Signup"))
                  ],
                ),
                SizedBox(height: 16.h,),
                MyAppButton(iconData: Icons.facebook,text: "Login with facebook",onTap: () {
                  print("Facebook");
                },),
                SizedBox(height: 16.h,),
                MyAppButton(iconData: Icons.email,text: "Login with email"),
                SizedBox(height: 16.h,),
                MyAppButton(iconData: Icons.g_mobiledata_rounded,text: "Login with gmail"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MyLoginButton(){
   return SizedBox(
      height: 48.h,
      child: FilledButton(onPressed: () {
        if(keyForm.currentState!.validate()){
          kbloc.add(GetLoginDataEvent(phone: phoneController.text, password: passwordController.text));
          gbloc.add(GetLoginDataEvent(phone: phoneController.text, password: passwordController.text));
        }
      }, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.security,color: Theme.of(context).primaryColor,),
          SizedBox(width: 4.w,),
          Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),),
        ],
      )),
    );
  }
}
