import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login_regsister/login/bloc.dart';
import 'package:flutter_apis_pagination/views/login_regsister/regsister/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

class ALoginView extends StatefulWidget {
  const ALoginView({super.key});

  @override
  State<ALoginView> createState() => _ALoginViewState();
}

final keyForm=GlobalKey<FormState>();
final amobileController=TextEditingController(text: "966132847241864");
final apasswordController=TextEditingController(text: "123456789");
bool isPassword=true;

final kabloc=KiwiContainer().resolve<ALoginBloc>();

class _ALoginViewState extends State<ALoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontSize: 24,fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 12.h),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 64.h,),
                _mobileInput(),
                SizedBox(height: 16.h,),
                _passwordInput(),
                SizedBox(height: 24.h,),
                BlocConsumer(
                  bloc: kabloc,
                  listener: (context, state) {
                    if(state is ALoginFailedState)
                      showMessage(state.msg);
                    else if(state is ALoginSuccessState)
                      showMessage("Success, Welcome agian ${state.loginData.data.fullname}",isSucess: true);
                  },
                  builder: (context, state) {
                    if(state is ALoginFailedState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _loginButton(),
                          SizedBox(height: 16.h,),
                          Center(child: Text(state.msg,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 30),)),
                        ],
                      );
                    else if(state is ALoginSuccessState)
                      return _loginButton();
                    else if(state is ALoginLoadingState)
                      return Center(child: CupertinoActivityIndicator(radius: 35.r,color: Theme.of(context).primaryColor,));
                    else
                      return _loginButton();
                  },
                ),
                SizedBox(height: 24.h,),
                _remenberPassword(),
                SizedBox(height: 8.h,),
                _signUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _mobileInput() {
    return TextFormField(
      controller: amobileController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter your mobile number";
       // else if(value.startsWith("966"))
          //return "Mobile number must start with 966";
        else if(value.length < 11)
          return "Invalid mobile number";
        else return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "type your mobile here",
        labelText: "Mobile number",
        alignLabelWithHint: true,
        prefix: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20.r)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
      ),
    );
  }

  _passwordInput() {
    return TextFormField(
      controller: apasswordController,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter your password";
        else if(value.length < 8)
          return "Password must be at least 8 characters";
        else return null;
      },
      keyboardType: TextInputType.number,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: "type your password here",
        labelText: "Password",
        alignLabelWithHint: true,
        prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
        suffix: IconButton(onPressed: () {
          setState(() {
            isPassword=!isPassword;
          });
        }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(20.r)
        ),
      ),
    );
  }

  _loginButton() {
    return SizedBox(
      height: 55.h,
      child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r)
            )
          ),
          onPressed: () {
        if(keyForm.currentState!.validate()){
          kabloc.add(PostALoginEvent(phone: amobileController.text, password: apasswordController.text));
        }
      }, child: Text("Login")),
    );
  }

  _remenberPassword() {
    return Center(child: InkWell(
        onTap: () {

        },
        child: Text("Do not remeber password!",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontWeight: FontWeight.w500,decoration: TextDecoration.underline),)));
  }

  _signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Do not have account",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(width: 0.w,),
        TextButton(onPressed: () {
          navigateTo(ASignupView());
        }, child: Text("Sign up",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),))
      ],
    );
  }
}
