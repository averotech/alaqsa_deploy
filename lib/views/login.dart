import 'dart:async';
import 'dart:io'; // Import to check the platform


import 'package:alaqsa/bloc/login/login_bloc.dart';
import 'package:alaqsa/bloc/login/login_event.dart';
import 'package:alaqsa/bloc/login/login_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/GlobalState.dart';
import '../models/LatLng.dart';
import 'location_service.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateLogin();
  }
}

class StateLogin extends State<Login> with WidgetsBindingObserver {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  GlobalState globalState = GlobalState.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initiateLocationCheck();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App has resumed from background, check location permissions again
      _initiateLocationCheck();
    }
  }

  Future<void> _initiateLocationCheck() async {
    try {
      await LocationService.initiateLocationCheck(context);
    } catch (e) {
      print("Location check failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: BlocProvider(
         create: (context) => LoginBloc(),
         child: BlocListener<LoginBloc,LoginState>(
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
                 // CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message: "الرجاء الأنتظار", type:1, height:  Platform.isAndroid ? 150.0 : 117.0,);
                 Timer(Duration(seconds: 2),(){
                   if(Config.isShowingLoadingDialog == true) {
                     Config.isShowingLoadingDialog = false;
                     // Navigator.of(context).pop();
                   }
                 });}
             }
           },
           child: BlocBuilder<LoginBloc,LoginState>(
             builder: (context,state){
               String passwordError = '';
               if (state is LoginErroe) {
                 passwordError = 'البريد الالكتروني او رقم الهاتف او كلمة المرور غير صحيحات';
               }
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
                                     if(Navigator.canPop(context)){
                                       Navigator.of(context).pop();
                                     } else {
                                       Navigator.of(context).pushNamed("MainPage");
                                     }

                                   },
                                 ),
                               ),
                               Container(

                                 margin: const EdgeInsets.only(top: 0),
                                 child: Image.asset("assets/images/iconApp.png"),
                               ),

                               CustomTextField.TextFieldWithTitle(controller: email,title: "البريد الالكتروني او رقم الهاتف",hintText:"البريد الالكتروني او رقم الهاتف" ,obscureText: false,borderColor: Colors.white,margin: EdgeInsets.only(top: 45)),
                               CustomTextField.TextFieldWithTitle(controller: password,title: "كلمة المرور",hintText:"كلمة المرور" ,obscureText: true,borderColor: Colors.white,margin: EdgeInsets.only(top: 14)),
                               if (passwordError.isNotEmpty)
                                 Container(
                                   margin: EdgeInsets.only(top: 8),
                                   child: Text(
                                     passwordError,
                                     style: TextStyle(
                                       color: Colors.red,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ),
                               CustomButton.customButton1(context: context,visibleIcon: false,textButton: "تسجيل دخول",iconButton:"",top: 24.0,bottom: 0.0,onPressed: (){
                                 context.read<LoginBloc>()..add(LoginApiEvent(email.text.toString(), password.text.toString()));
                                 // Navigator.of(context).pushNamed("MainPage");
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
                               Container(
                                 width: MediaQuery.of(context).size.width,
                                 margin: EdgeInsets.only(bottom: 32),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Center(
                                       child: TextButton(
                                         child: Text(
                                           "لا تمتلك حساب؟ أنشئ الآن",
                                           style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 16,
                                             fontFamily: "SansArabicLight",
                                             fontWeight: FontWeight.w600,
                                           ),
                                         ),
                                         onPressed: () {
                                           Navigator.of(context).pushNamed("RegisterPage");
                                         },
                                       ),
                                     ),
                                     SizedBox(height: 10), // Add space between the buttons
                                     Center(
                                       child: TextButton(
                                         child: Text(
                                           "نسيت كلمة المرور؟",
                                           style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 16,
                                             fontFamily: "SansArabicLight",
                                             fontWeight: FontWeight.w600,
                                           ),
                                         ),
                                         onPressed: () {
                                           Navigator.of(context).pushNamed("ResetPassworedPage");
                                         },
                                       ),
                                     ),
                                   ],
                                 ),
                               ),

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