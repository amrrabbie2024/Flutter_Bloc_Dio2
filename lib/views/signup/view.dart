import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_input.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/core/logic/input_validation.dart';
import 'package:flutter_apis_pagination/features/signup/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:kiwi/kiwi.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

final keyForm=GlobalKey<FormState>();
final fNameController=TextEditingController(text: "");
final phoneController=TextEditingController(text: "");
final emailController=TextEditingController(text: "");
final passwordController=TextEditingController(text: "");
final repasswordController=TextEditingController(text: "");

bool isPassword=true;
bool isRePassword=true;

final kbloc=KiwiContainer().resolve<RegsisterBloc>();
final gbloc=GetIt.I<RegsisterBloc>();

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipOval(child: SvgPicture.asset("assets/svg/logo.svg",width: 90.w,height: 60.h,fit: BoxFit.scaleDown,)),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: fNameController,
                  keyboardType: TextInputType.text,
                  prefix: Icon(Icons.person),
                  labelText: "Full name",
                  hintText: "Enter your full name",
                  validator: InputValidation.fname,
                ),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  prefix: Icon(Icons.phone),
                  labelText: "Phone number",
                  hintText: "Enter your phone number",
                  validator: InputValidation.phone,
                ),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefix: Icon(Icons.email),
                  labelText: "Email",
                  hintText: "Enter your email address",
                  validator: InputValidation.email,
                ),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  prefix: Icon(Icons.password),
                  suffix: IconButton(onPressed: () {
                    setState(() {
                      isPassword=!isPassword;
                    });
                  }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off)),
                  labelText: "Password",
                  hintText: "Enter your password",
                  validator: InputValidation.password,
                  obscureText: isPassword,
                ),
                SizedBox(height: 16.h,),
                MyAppInput(
                  controller: repasswordController,
                  keyboardType: TextInputType.text,
                  prefix: Icon(Icons.password),
                  suffix: IconButton(onPressed: () {
                    setState(() {
                      isRePassword=!isRePassword;
                    });
                  }, icon: Icon(isRePassword?Icons.visibility:Icons.visibility_off)),
                  labelText: "Re-enter Password",
                  hintText: "Enter your password again",
                  validator: InputValidation.password,
                  obscureText: isRePassword,
                ),
                SizedBox(height: 24.h,),
                BlocConsumer(
                  bloc: gbloc,
                  listener: (context, state) {
                    if(state is RegsisterFailedState)
                      showMessage(state.msg);
                    else if(state is RegsisterSuccessState)
                      showMessage(state.signupData.message,isSucess: true);
                  },
                  builder: (context, state) {
                    if(state is RegsisterLoadingState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MySignupButton(),
                          SizedBox(height: 16.h,),
                          MyAppLoading(),
                        ],
                      );
                    else if(state is RegsisterFailedState)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MySignupButton(),
                          SizedBox(height: 16.h,),
                          MyAppFailed(msg: state.msg),
                        ],
                      );
                    else if(state is RegsisterSuccessState)
                      return MySignupButton();
                    else
                      return MySignupButton();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget MySignupButton(){
    return SizedBox(
      height: 48.h,
      child: FilledButton(onPressed: () {
        if(keyForm.currentState!.validate()){
          if(passwordController.text == repasswordController.text){
            gbloc.add(GetRegsisterDataEvent(fullname: fNameController.text, password: passwordController.text, password_confirmation: repasswordController.text, phone: phoneController.text));
          }else{
            showMessage("Passwords not matches");
          }
        }
      }, child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.security),
          SizedBox(width: 4.w,),
          Text("Sign up")
        ],
      )),
    );
  }
}
