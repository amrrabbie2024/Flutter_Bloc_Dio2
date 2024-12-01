import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_input2.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login_regsister/regsister/bloc.dart';
import 'package:flutter_apis_pagination/views/login_regsister/login/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class ASignupView extends StatefulWidget {
  const ASignupView({super.key});

  @override
  State<ASignupView> createState() => _ASignupViewState();
}

final afnamecontroller=TextEditingController(text: "");
final aaphonecontroller=TextEditingController(text: "");
final apasswordcontroller=TextEditingController(text: "");
final arepasswordcontroller=TextEditingController(text: "");
bool isPassword=true;
bool isRePassword=true;

final kkeyForm=GlobalKey<FormState>();

final ggbloc=GetIt.I<ASignupBloc>();
class _ASignupViewState extends State<ASignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 24),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 16.h),
          child: Form(
            key: kkeyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h,),
                _fullnameInput(),
                SizedBox(height: 16.h,),
                _phoneInput(),
                SizedBox(height: 16.h,),
                _passwordInput(),
                SizedBox(height: 16.h,),
                _passwordAgianInput(),
                SizedBox(height: 24.h,),
                BlocConsumer(
                  bloc: ggbloc,
                  listener: (context, state) {
                    if(state is ASignupFailedState)
                      showMessage(state.msg);
                    else if(state is ASignupSuccessState)
                      showMessage("${state.signupData.message}",isSucess: true);
                  },
                  builder: (context, state) {
                    if(state is ASignupFailedState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _signUpButton(),
                          SizedBox(height: 8.h,),
                          MyAppFailed(msg: state.msg),
                        ],
                      );
                    else if(state is ASignupSuccessState)
                      return _signUpButton();
                    else if(state is ASignupLoadingState)
                      return MyAppLoading();
                    else
                      return _signUpButton();
                  },
                ),
                SizedBox(height: 16.h,),
                _login()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppInput2 _phoneInput() {
    return AppInput2(
              controller: aaphonecontroller,
              validator: (value) {
                if(value!.isEmpty)
                  return "Must enter phone number";
                else if(value.length < 11)
                  return "Invalid number";
                else return null;
              },
              keyboardType: TextInputType.number,
              prefix: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
              labelText: "Phone number",
              hintText: "Type here your phone number",
            );
  }

  AppInput2 _fullnameInput() {
    return AppInput2(
              controller: afnamecontroller,
              validator: (value) {
                if(value!.isEmpty)
                  return "Must enter your full name";
                else if(!value.contains(" "))
                  return "Must enter second name";
                else return null;
              },
              keyboardType: TextInputType.text,
              hintText: "Type here your full name",
              labelText: "Full name",
              prefix: Icon(Icons.person,color: Theme.of(context).primaryColor,),
            );
  }

  _passwordInput() {
    return AppInput2(
      controller: apasswordcontroller,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter your password";
        else if(value.length < 8)
          return "Password must be at least 8 characters";
        else return null;
      },
      keyboardType: TextInputType.text,
      hintText: "Type here your password",
      labelText: "Password",
      prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
      obscureText: isPassword,
      suffix: IconButton(onPressed: () {
        setState(() {
          isPassword=!isPassword;
        });
      }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
    );
  }

  _passwordAgianInput() {
    return AppInput2(
      controller: arepasswordcontroller,
      validator: (value) {
        if(value!.isEmpty)
          return "Must enter your password";
        else if(value.length < 8)
          return "Password must be at least 8 characters";
        else return null;
      },
      keyboardType: TextInputType.text,
      hintText: "Type here your password again",
      labelText: "Password again",
      prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
      obscureText: isRePassword,
      suffix: IconButton(onPressed: () {
        setState(() {
          isRePassword=!isRePassword;
        });
      }, icon: Icon(isRePassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
    );
  }

  _login() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Have an account",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18,fontWeight: FontWeight.w500),),
        SizedBox(width: 0.w,),
        TextButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ALoginView(),));
        }, child: Text("Sign in",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600),))
      ],
    );
  }

  _signUpButton() {
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
              if(kkeyForm.currentState!.validate())
          ggbloc.add(PostASignupEvent(fullname: afnamecontroller.text, password: apasswordController.text, password_confirmation: arepasswordcontroller.text, phone: aaphonecontroller.text));
        }, child: Text("Sign up",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),)));
  }
}
