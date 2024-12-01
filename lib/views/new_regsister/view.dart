import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/features/new_regsister/bloc.dart';
import 'package:flutter_apis_pagination/views/new_login/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../core/design/new_app_button.dart';
import '../../core/design/new_app_input.dart';
import '../../core/logic/helper_methods.dart';

class NewSignUpView extends StatefulWidget {
  const NewSignUpView({super.key});

  @override
  State<NewSignUpView> createState() => _NewSignUpViewState();
}

final emailController=TextEditingController(text: "");
final passwordController=TextEditingController(text: "123456789");
final confirmPasswordController=TextEditingController(text: "123456789");
final firstController=TextEditingController(text: "Amr");
final secondController=TextEditingController(text: "Ahmed");
final phoneController=TextEditingController(text: "96613284724776");
final keyForm=GlobalKey<FormState>();
bool isPassword=true;
bool confirmIsPassword=true;

final gbloc=GetIt.I<NRegsisterBloc>();

class _NewSignUpViewState extends State<NewSignUpView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeb39),
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(
            top: 42.h, bottom: 52.h, start: 16.w, end: 16.w),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset(
                "assets/images/restranut.jpg", width: 160.w,
                height: 120.h,
                fit: BoxFit.fill,)),
              SizedBox(height: 24.h,),
              Text("Welcome back, Sign up",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
              SizedBox(height: 4.h,),
              Text("join now for the application", style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffbea84a)),),
              SizedBox(height: 24.h,),
              Row(
                children: [
                  Expanded(child: _firstName()),
                  SizedBox(width: 4.w,),
                  Expanded(child: _secondName())
                ],
              ),
              SizedBox(height: 16.h,),
              //_email(),
              _phone(),
              SizedBox(height: 16.h,),
              _password(),
              SizedBox(height: 16.h,),
              _confirmPassword(),
              SizedBox(height: 32.h,),
              BlocConsumer(
                bloc: gbloc,
                listener: (context, state) {
                  if(state is NRegsisterFailedState)
                    showMessage(state.msg);
                  else if(state is NRegsisterSuccessState) {
                    showMessage(state.regsisterData.message, isSucess: true);
                    navigateTo(NewLogin());
                  }
                },
                builder: (context, state) {
                  if(state is NRegsisterFailedState)
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _loginButton(),
                        SizedBox(height: 16.h,),
                        MyAppFailed(msg: state.msg)
                      ],
                    );
                  else if(state is NRegsisterSuccessState)
                    return _loginButton();
                  else if(state is NRegsisterLoadingState)
                    return MyAppLoading();
                  else
                    return _loginButton();
                },
              ),
              SizedBox(height: 32.h,),
              Row(
                children: [
                  Text("Already have an account?",style: TextStyle(color: Color(0xff825d47),fontSize: 18,fontWeight: FontWeight.normal),),
                  SizedBox(width: 2.w,),
                  TextButton(onPressed: () {
                    navigateTo(NewLogin() );
                  }, child: Text("Sign in",style: TextStyle(color:Color(0xff825d47),fontSize: 18,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstName(){
    return  MyNewInput(
      controller: firstController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter first name";
        else return null;
      },
      keyboardType: TextInputType.text,
      hintText: "write here",
      labelText: "First name",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Icon(Icons.person,color: Color(0xff4d454a),),
      ),
    );
  }

  Widget _secondName(){
    return  MyNewInput(
      controller: secondController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter last name";
        else return null;
      },
      keyboardType: TextInputType.text,
      hintText: "write here",
      labelText: "Last name",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Icon(Icons.person,color: Color(0xff4d454a),),
      ),
    );
  }

  Widget _phone(){
    return  MyNewInput(
      controller: phoneController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter phone number";
        else if(value.length < 8)
          return "Invalid phone";
        else return null;
      },
      keyboardType: TextInputType.phone,
      hintText: "Phone number",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Icon(Icons.phone,color: Color(0xff4d454a),),
      ),
    );
  }

  Widget _email(){
    return  MyNewInput(
      controller: emailController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter email address";
        else if(!value.contains("@"))
          return "Invalid email";
        else if(!value.contains("."))
          return "Invalid email";
        else return null;
      },
      keyboardType: TextInputType.emailAddress,
      hintText: "Email Address",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Icon(Icons.email,color: Color(0xff4d454a),),
      ),
    );
  }

  Widget _password(){
    return MyNewInput(
      controller: passwordController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter password";
        else if(value.length < 8)
          return "Password must be at least 8 characters";
        else return null;
      },
      keyboardType: TextInputType.text,
      obscureText: isPassword,
      hintText: "Password",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Opacity(opacity: .7,child: Image.asset("assets/images/closed.png",width: 16.w,height: 16.h,fit: BoxFit.fill,)),
      ),
      suffix: IconButton(onPressed: () {
        setState(() {
          isPassword=!isPassword;
        });
      },icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Color(0xff4d454a),),),
    );
  }

  Widget _confirmPassword(){
    return MyNewInput(
      controller: confirmPasswordController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter confirm password";
        else if(value.length < 8)
          return "confirm password must be at least 8 characters";
        else return null;
      },
      keyboardType: TextInputType.text,
      obscureText: confirmIsPassword,
      hintText: "Confirm password",
      prefix: Padding(
        padding:  EdgeInsetsDirectional.only(end: 8.w),
        child: Opacity(opacity: .7,child: Image.asset("assets/images/closed.png",width: 16.w,height: 16.h,fit: BoxFit.fill,)),
      ),
      suffix: IconButton(onPressed: () {
        setState(() {
          confirmIsPassword=!confirmIsPassword;
        });
      },icon: Icon(confirmIsPassword?Icons.visibility:Icons.visibility_off,color: Color(0xff4d454a),),),
    );
  }

  Widget _loginButton(){
    return   Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 32.w),
      child: MyNewButton(text: "Sign up",onPressed: () {
        if(keyForm.currentState!.validate()) {
          if (passwordController.text == confirmPasswordController.text) {
            gbloc.add(getNRegsisterDataEvent(fullname: firstController.text + " " + secondController.text, password: passwordController.text, password_confirmation: confirmPasswordController.text, phone: phoneController.text));
          } else {
            showMessage("Password not matchs");
          }
        }
      },),
    );
  }
}
