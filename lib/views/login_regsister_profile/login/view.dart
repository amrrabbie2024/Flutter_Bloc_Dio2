import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/cash_helper.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login_regsister_profile/login/bloc.dart';
import 'package:flutter_apis_pagination/views/login_regsister_profile/profile/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kiwi/kiwi.dart';

import '../regsister/view.dart';

class VLoginView extends StatefulWidget {
  const VLoginView({super.key});

  @override
  State<VLoginView> createState() => _VLoginViewState();
}

final keyForm=GlobalKey<FormState>();
final emailController=TextEditingController(text:"" );
final passwordController=TextEditingController(text:"" );
bool isPassword=true;
final kbloc=KiwiContainer().resolve<VLoginBloc>();

class _VLoginViewState extends State<VLoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 24),),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _email(),
                SizedBox(height: 16.h,),
                _password(),
                SizedBox(height: 24.h,),
                BlocConsumer(
                  bloc: kbloc,
                  listener: (context, state) {
                    if(state is VLoginFailedState)
                      showMessage(state.msg);
                    else if(state is VLoginSuccessState){
                      CashHelper.saveLoginToken(state.data.token);
                      Map<String, dynamic> decodedToken = JwtDecoder.decode(state.data.token);
                      CashHelper.saveLoginId(decodedToken['id']);
                      print("Token ${state.data.token}");
                      print("Id ${decodedToken['id']}");
                      navigateTo(VProfileView());
                      showMessage(state.data.message,isSucess: true);
                    }
                  },
                  builder: (context, state) {
                    if(state is VLoginFailedState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _loginButton(),
                          SizedBox(height: 16.h,),
                          Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontSize: 30,fontWeight: FontWeight.bold),)),
                        ],
                      );
                    else if(state is VLoginSuccessState)
                      return _loginButton();
                    else if(state is VLoginLoadingState)
                      return Column(
                        crossAxisAlignment:  CrossAxisAlignment.center,
                        children: [
                          _loginButton(),
                          SizedBox(height: 16.h,),
                          Center(child: CupertinoActivityIndicator(radius: 35.r,color: Theme.of(context).primaryColor,)),
                        ],
                      );
                    else
                      return _loginButton();
                  },
                ),
                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Do not have account?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    TextButton(onPressed: () {
                      navigateTo(VRegsisterView());
                    }, child: Text("Sign up!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _email(){
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your email";
          else if(!value.contains("@"))
            return "Invalid email";
          else if(!value.contains("."))
            return "Invalid email";
          else return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "enter your email here",
          labelText: "Email",
          prefix: Icon(Icons.email,color: Theme.of(context).primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _password(){
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your password";
          else if(value.length <8)
            return "password must be at least 8 characters";
          else return null;
        },
        keyboardType: TextInputType.text,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: "enter your password here",
          labelText: "Password",
          prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isPassword=!isPassword;
            });
          }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _loginButton(){
    return SizedBox(
      height: 60.h,
      width: 180.w,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(color: Theme.of(context).primaryColor)
          )
        ),
          onPressed: () {
        if(keyForm.currentState!.validate()){
          kbloc.add(getVLoginDataEvent(email: emailController.text, password: passwordController.text));
        }
      }, child: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600),)),
    );
  }
}
