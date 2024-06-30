import 'dart:async';

import 'package:alaqsa/bloc/login/login_bloc.dart';
import 'package:alaqsa/bloc/login/login_event.dart';
import 'package:alaqsa/bloc/login/login_state.dart';
import 'package:alaqsa/bloc/register/register_bloc.dart';
import 'package:alaqsa/bloc/register/register_event.dart';
import 'package:alaqsa/bloc/register/register_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateRegister();
  }

}

class StateRegister extends State<Register> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: MultiBlocProvider(
         providers: [
           BlocProvider(create: (context)=> RegisterBloc()),
           BlocProvider(create: (context)=> LoginBloc()),
         ],
         child: MultiBlocListener(
           listeners: [
             BlocListener<RegisterBloc,RegisterState>(
               listener: (context,state){
                 if(state is RegisterInitial){
                   if(Config.isShowingLoadingDialog == false) {
                     Config.isShowingLoadingDialog = true;
                     CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                   }
                 }
                 if(state is RegisterLoaded){
                   if(Config.isShowingLoadingDialog == true) {
                     Config.isShowingLoadingDialog = false;
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
                   }
                 }

                 if(state is RegisterErroe){
                   if(Config.isShowingLoadingDialog == true) {
                     Config.isShowingLoadingDialog = false;
                     Navigator.of(context).pop();
                   }
                   if( Config.isShowingLoadingDialog == false) {
                     Config.isShowingLoadingDialog = true;
                     String errorMessage = state.error['general'] ?? "خطأ";

                     String nameError = state.error['name'] ?? "";
                     String emailError = state.error['email'] ?? "";
                     String phone = state.error['phone'] ?? "";
                     String passwordError = state.error['password'] ?? "";

                     List<String> errorMessages = [];
                     if (nameError.isNotEmpty) errorMessages.add(nameError);
                     if (emailError.isNotEmpty) errorMessages.add(emailError);
                     if (phone.isNotEmpty) errorMessages.add(phone);
                     if (passwordError.isNotEmpty) errorMessages.add(passwordError);

                     if (errorMessages.isNotEmpty) {
                       errorMessage = errorMessages.join("\n");
                     }

                     CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message:errorMessage, type:3, height: 200.0);
                     Timer(Duration(seconds: 1),(){
                       if(Config.isShowingLoadingDialog == true) {
                         Config.isShowingLoadingDialog = false;
                         Navigator.of(context).pop();
                       }
                     });}
                 }
               },
             ),
             BlocListener<LoginBloc,LoginState>(
               listener: (context,state) async {
                 if(state is LoginInitial){
                   if(Config.isShowingLoadingDialog == false) {
                     Config.isShowingLoadingDialog = true;
                     CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                   }
                 }
                 if(state is LoginLoaded){
                   if(Config.isShowingLoadingDialog == true) {
                     Config.isShowingLoadingDialog = false;
                     Navigator.of(context).pop();
                     Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
                   }
                 }

                 if(state is LoginErroe){
                   if(Config.isShowingLoadingDialog == true) {
                     Config.isShowingLoadingDialog = false;
                     Navigator.of(context).pop();
                   }
                   if( Config.isShowingLoadingDialog == false) {
                     Config.isShowingLoadingDialog = true;
                     CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message:"الايميل او كلمة السر غير صحيحات", type:3, height: 117.0);
                     Timer(Duration(seconds: 1),(){
                       if(Config.isShowingLoadingDialog == true) {
                         Config.isShowingLoadingDialog = false;
                         Navigator.of(context).pop();
                       }
                     });}
                 }
               },
             )
           ],
           child:BlocBuilder<RegisterBloc,RegisterState>(
             builder: (context,state){
               return Stack(
                 children: [
                   Positioned(
                       top: 0,
                       child: Container(
                         height: MediaQuery.of(context).size.height,
                         width: MediaQuery.of(context).size.width,
                         child: Image.asset("assets/images/backgound.png",fit: BoxFit.cover,),
                       )
                   ),
                   Positioned(
                     top: 0,
                     left: 0,
                     right: 0,
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       height: MediaQuery.of(context).size.height,
                       margin: EdgeInsets.only(left: 16,right: 16),
                       child: SingleChildScrollView(
                           padding: EdgeInsets.zero,

                           child:Column(

                             children: [
                               Container(
                                 margin: const EdgeInsets.only(top: 40,left: 0),
                                 alignment: Alignment.centerLeft,
                                 child:  TextButton(
                                   child: const Text("تخطي",style: TextStyle(color: Colors.white,fontFamily: 'SansArabicLight',fontSize: 16,fontWeight: FontWeight.w600),),
                                   onPressed: (){
                                     Navigator.of(context).pushNamed("MainPage");
                                   },
                                 ),
                               ),
                               Container(

                                 margin: const EdgeInsets.only(top: 0),
                                 child: Image.asset("assets/images/iconApp.png"),
                               ),
                               CustomTextField.TextFieldWithTitle(controller: name,title: "اسم المستخدم",hintText:"اسم المستخدم",obscureText: false ,borderColor: Colors.white,margin: EdgeInsets.only(top: 32)),
                               CustomTextField.TextFieldWithTitle(controller: email,title: "البريد الالكتروني ",hintText:"البريد الالكتروني او رقم الجوال",obscureText: false ,borderColor: Colors.white,margin: EdgeInsets.only(top: 14)),
                               CustomTextField.TextFieldWithTitle(controller: phone_number,title: "رقم الهاتف",hintText:"رقم الهاتف" ,obscureText: false,borderColor: Colors.white,margin: EdgeInsets.only(top: 14)),
                               CustomTextField.TextFieldWithTitle(controller: password,title: "كلمة المرور",hintText:"كلمة المرور" ,obscureText: true,borderColor: Colors.white,margin: EdgeInsets.only(top: 14)),

                               CustomButton.customButton1(context: context,visibleIcon: false,textButton: "تسجيل",iconButton:"",top: 24.0,bottom: 0.0,onPressed: (){

                                 context.read<RegisterBloc>()..add(RegisterApiEvent(name.text, email.text,phone_number.text ,password.text));
                                 //Navigator.of(context).pushNamed("MainPage");
                               }),

                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 margin: EdgeInsets.only(top: 24),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Container(
                                       width: MediaQuery.of(context).size.width/2.5,
                                       child: Divider(
                                         color: Colors.white,
                                         thickness: 0.75,
                                       ),
                                     ),
                                     Container(
                                       margin: EdgeInsets.only(left: 7,right: 7),
                                       child: Text("أو",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontFamily: 'SansArabicLight',color:Colors.white),),
                                     ),
                                     Container(
                                       width: MediaQuery.of(context).size.width/2.5,
                                       child: Divider(
                                         color: Colors.white,
                                         thickness: 0.75,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                               // CustomButton.customButton1(context: context,visibleIcon: true,textButton: "التسجيل عبر حساب ابل",iconButton:"assets/icons/apple-logo.svg",top: 16.0,bottom: 0.0,onPressed: (){
                               //   Navigator.of(context).pushNamed("MainPage");
                               // }),
                               //Todo modify Google and facebook
                               // CustomButton.customButton1(context: context,visibleIcon: true,textButton: "التسجيل عبر جوجل",iconButton:"assets/icons/google.svg",top: 19.0,bottom: 0.0,onPressed: (){
                               //   context.read<LoginBloc>()..add(LoginGoogleEvent());
                               // }),
                               // CustomButton.customButton1(context: context,visibleIcon: true,textButton: "التسجيل عبر فيسبوك",iconButton:"assets/icons/facebook-app-symbol.svg",top: 16.0,bottom: 24.0,onPressed: (){
                               //   context.read<LoginBloc>()..add(LoginFacebookEvent());
                               // }),
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 margin: EdgeInsets.only(bottom: 32),
                                 child: Center(

                                   child: TextButton(

                                     child: Text("هل لديك حساب؟ سجل الان",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "SansArabicLight",fontWeight: FontWeight.w600),),
                                     onPressed: (){
                                       Navigator.of(context).pop();
                                     },
                                   ),
                                 ),
                               )
                             ],
                           )),
                     ),
                   ),


                 ],
               );
             },
           ),
         ),
       ),
     );
  }


}