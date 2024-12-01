import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/new_app_button.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login/bloc.dart';
import 'package:flutter_apis_pagination/features/new_login/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/design/new_app_input.dart';
import '../home/view.dart';
import '../new_home/view.dart';
import '../new_regsister/view.dart';

class NewLogin extends StatefulWidget {
  const NewLogin({super.key});

  @override
  State<NewLogin> createState() => _NewLoginState();
}

final emailController=TextEditingController(text: "");
final passwordController=TextEditingController(text: "123456789");
final phoneController=TextEditingController(text: "966132847241864");
final keyForm=GlobalKey<FormState>();
bool isPassword=true;

final kbloc=KiwiContainer().resolve<NLoginBloc>();

class _NewLoginState extends State<NewLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeb39),
      body: SingleChildScrollView(
        padding:  EdgeInsetsDirectional.only(top: 42.h,bottom: 52.h,start: 16.w,end: 16.w),
        child: Form(
          key: keyForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset("assets/images/restranut.jpg",width: 160.w,height: 120.h,fit: BoxFit.fill,)),
              SizedBox(height: 24.h,),
              Text("Welcome . Sign in",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
              SizedBox(height: 4.h,),
              Text("Login now for the application",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Color(0xffbea84a)),),
              SizedBox(height: 16.h,),
             // _email(),
              _phone(),
              SizedBox(height: 16.h,),
              _password(),
              SizedBox(height: 16.h,),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(onPressed:  () {

                }, child: Text("Forgot Password?",style: TextStyle(color:Color(0xff825d47)),)),
              ),
              SizedBox(height: 32.h,),
              BlocConsumer(
                bloc: kbloc,
                listener: (context, state) {
                  if(state is NLoginFailedState)
                    showMessage(state.msg);
                  else if(state is NLoginSuccessState) {
                    showMessage("Login succssed!, Welcome ${state.loginModel.fullname}", isSucess: true);
                    navigateTo(MyNHomeView(fullname: state.loginModel.fullname,));
                  }
                },
                builder:  (context, state) {
                  if(state is NLoginFailedState)
                    return Column(
                      crossAxisAlignment:  CrossAxisAlignment.stretch,
                      children: [
                        _loginButton(),
                        SizedBox(height: 16.h,),
                        Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.w600),))
                      ],
                    );
                  else if(state is NLoginSuccessState)
                    return _loginButton();
                  else if(state is NLoginLoadingState)
                   return Center(child: CircularProgressIndicator(color: Color(0xff825d47),strokeWidth: 8,));
                  else
                   return _loginButton();
                },
              ),
              SizedBox(height: 32.h,),
              _divider(),
              SizedBox(height: 32.h,),
              Row(
                children: [
                  Text("if you do not have an account?",style: TextStyle(color: Color(0xff825d47),fontSize: 18,fontWeight: FontWeight.normal),),
                  SizedBox(width: 2.w,),
                  TextButton(onPressed: () {
                    navigateTo(NewSignUpView() );
                  }, child: Text("Sign up",style: TextStyle(color:Color(0xff825d47),fontSize: 18,fontWeight: FontWeight.w600,decoration: TextDecoration.underline),))
                ],
              )
            ],
          ),
        ),
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
      keyboardType: TextInputType.emailAddress,
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

  Widget _loginButton(){
    return   Padding(
      padding:  EdgeInsetsDirectional.symmetric(horizontal: 32.w),
      child: MyNewButton(text: "Login",onPressed: () {
        if(keyForm.currentState!.validate()){
          kbloc.add(getNLoginDataEvent(phone: phoneController.text, password: passwordController.text));
        }
      },),
    );
  }

  Widget _divider(){
    return Row(
      children: [
        SizedBox(width: 48.w,),
        Expanded(
          child: DottedLine(
            lineThickness: 3,
            dashLength: 6,
          ),
        ),
        SizedBox(width: 8.w,),
        Text("OR",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        SizedBox(width: 8.w,),
        Expanded(
          child: DottedLine(
            lineThickness: 3,
            dashLength: 6,
          ),
        ),
        SizedBox(width: 48.w,),
      ],
    );
  }
}
