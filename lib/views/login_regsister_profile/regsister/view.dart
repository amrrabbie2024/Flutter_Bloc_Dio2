import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_apis_pagination/core/design/app_failed.dart';
import 'package:flutter_apis_pagination/core/design/app_loading.dart';
import 'package:flutter_apis_pagination/core/logic/helper_methods.dart';
import 'package:flutter_apis_pagination/features/login_regsister_profile/regsister/bloc.dart';
import 'package:flutter_apis_pagination/views/login_regsister_profile/login/view.dart';
import 'package:flutter_apis_pagination/views/new_regsister/view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class VRegsisterView extends StatefulWidget {
  const VRegsisterView({super.key});

  @override
  State<VRegsisterView> createState() => _VRegsisterViewState();
}

final gbloc=GetIt.I<VRegsisterBloc>();
final keyForm=GlobalKey<FormState>();
final nameController=TextEditingController(text: "");
final phoneController=TextEditingController(text: "");
final emailController=TextEditingController(text: "");
final passwordController=TextEditingController(text: "");
final confirmpasswordController=TextEditingController(text: "");
XFile? profilePic;

bool isPassword=true;
bool isConfirmPassword=true;

class _VRegsisterViewState extends State<VRegsisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Sign up"),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 22),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16.w,vertical: 24.h),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                _profileImage(),
                SizedBox(height: 16.h,),
                _name(),
                SizedBox(height: 16.h,),
                _phone(),
                SizedBox(height: 16.h,),
                _email(),
                SizedBox(height: 16.h,),
                _password(),
                SizedBox(height: 16.h,),
                _confirmpassword(),
                SizedBox(height: 24.h,),
                BlocConsumer(
                    bloc: gbloc,
                  listener: (context, state) {
                      if(state is VRegsisterFailedState)
                        showMessage(state.msg);
                      else if(state is VRegsisterSuccessState) {
                        navigateTo(VLoginView());
                        showMessage(state.data.message, isSucess: true);
                      }
                  },
                  builder: (context, state) {
                    if(state is VRegsisterFailedState)
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _signupButton(),
                          SizedBox(height: 16.h,),
                          MyAppFailed(msg: state.msg),
                        ],
                      );
                    else if(state is VRegsisterSuccessState)
                      return _signupButton();
                    else if(state is VRegsisterLoadingState)
                      return MyAppLoading();
                    else
                      return _signupButton();
                  },
                    ),
                SizedBox(height: 16.h,),
                _signin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: nameController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your name";
          else if(!value.contains(" "))
            return "Must enter full name";
          else return null;
        },
        decoration: InputDecoration(
          hintText: "type your name here",
          labelText: "Full name",
          prefix: Icon(Icons.person,color: Theme.of(context).primaryColor,),
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

  Widget _phone() {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your phone number";
          else if (value.length < 10)
            return "Invalid mobil";
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: "type your phone number here",
          labelText: "Phone number",
          prefix: Icon(Icons.phone, color: Theme
              .of(context)
              .primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _email() {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your email address";
          else if (!value.contains("@"))
            return "Invalid email";
          else if (!value.contains("."))
            return "Invalid email";
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: "type your email address here",
          labelText: "Email address",
          prefix: Icon(Icons.email, color: Theme
              .of(context)
              .primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _password() {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your password";
          else if (value.length <8)
            return "Password must be at least 8 characters";
          else
            return null;
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: "type your password here",
          labelText: "Password",
          prefix: Icon(Icons.password, color: Theme
              .of(context)
              .primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isPassword=!isPassword;
            });
          }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _confirmpassword() {
    return SizedBox(
      height: 60.h,
      child: TextFormField(
        controller: confirmpasswordController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your password again";
          else if (value.length <8)
            return "Confirm password must be at least 8 characters";
          else
            return null;
        },
        obscureText: isConfirmPassword,
        decoration: InputDecoration(
          hintText: "type your confirm password here",
          labelText: "Confirm Password",
          prefix: Icon(Icons.password, color: Theme
              .of(context)
              .primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isConfirmPassword=!isConfirmPassword;
            });
          }, icon: Icon(isConfirmPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(backgroundColor: Theme.of(context).primaryColor,radius: 50.r,child: CircleAvatar(radius: 48.r,backgroundImage: profilePic!=null?FileImage(File(profilePic!.path)):AssetImage("assets/images/person.png") as ImageProvider,)),
        Positioned(
          bottom: 0,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(.3)
              ),
                onPressed: () {
                showDialog(context: context, builder: (context) => _showDialog(),);
            }, icon: Icon(Icons.add,color: Colors.blue,size: 24,)))
      ],
    );
  }

  Widget _signupButton(){
    return SizedBox(
      height: 60.h,
      width: 180.w,
      child: OutlinedButton(onPressed:  () {
        if(keyForm.currentState!.validate()){
          if(profilePic == null){
            showMessage("Must select profile picture");
          }
          /*else if(passwordController.text != confirmPasswordController.text) {
            showMessage("Password not match!");
          }*/else{
            gbloc.add(getVRegsisterDataEvent(name: nameController.text,
                phone: phoneController.text,
                email: emailController.text,
                password: passwordController.text,
                confirmPassword: confirmpasswordController.text,
                profilePic: profilePic!));
          }
        }
      }, child: Text("Sign up",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600))),
    );
  }

  Widget _signin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Have account?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        TextButton(onPressed: () {
          navigateTo(VLoginView());
        }, child: Text("Sign in!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),))
      ],
    );
  }

  _showDialog() {
    return SimpleDialog(
      title: Text("Select image source",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600),),
      children: [
        Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: OutlinedButton.icon(onPressed: () async {
            profilePic=await ImagePicker().pickImage(source: ImageSource.camera);
            Navigator.pop(context);
            setState(() {});
          }, icon: Icon(Icons.camera,color: Theme.of(context).primaryColor,), label: Text("From camera")),
        ),
        SizedBox(height: 16.h,),
        Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24.w),
          child: OutlinedButton.icon(onPressed: () async {
            profilePic=await ImagePicker().pickImage(source: ImageSource.gallery);
            Navigator.pop(context);
            setState(() {});
          }, icon: Icon(Icons.browse_gallery,color: Theme.of(context).primaryColor,), label: Text("From gallery")),
        ),
      ],
    );
  }

}
