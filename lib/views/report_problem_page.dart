import 'dart:async';

import 'package:alaqsa/bloc/settings/settings_bloc.dart';
import 'package:alaqsa/bloc/settings/settings_event.dart';
import 'package:alaqsa/bloc/settings/settings_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportProblemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateReportProblemPage();
  }

}

class StateReportProblemPage extends State<ReportProblemPage> {
  TextEditingController numberPhone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController messageProblem = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SettingsBloc()..add(ReportProblemEvent()),
        child: BlocListener<SettingsBloc,SettingsState>(
          listener: (context,state){

            if(state is ReportProblemLoaded) {
              name.text=state.user.name;
              numberPhone.text= state.user.phoen == ""? "":state.user.phoen;
            }

            if(state is SettingsInitial){
              if(Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
              }
            }

            if(state is ReportProblemSendLoaded){

              if(Config.isShowingLoadingDialog == true) {
                Config.isShowingLoadingDialog = false;
                Navigator.of(context).pop();
              }
              if( Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context:context, color:Theme.of(context).primaryColor, size:35.0, message:"تم الأرسال", type:2, height: 100.0);
                Timer(Duration(seconds: 1),(){
                  if(Config.isShowingLoadingDialog == true) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                });}
            }

            if(state is SettingsSendReportError) {

              if(Config.isShowingLoadingDialog == true) {
                Config.isShowingLoadingDialog = false;
                Navigator.of(context).pop();
              }
              if( Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message:"حدث خطأ", type:3, height: 100.0);
                Timer(Duration(seconds: 1),(){
                  if(Config.isShowingLoadingDialog == true) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                });}
            }



          },
          child: BlocBuilder<SettingsBloc,SettingsState>(
            builder: (context,state){
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 94,
                        child: CustomNavBar.customNaveBar(context: context,title: "أبلغ عن مشكلة"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32,left: 16,right: 16),

                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  offset: Offset(0,0),
                                  blurRadius: 1
                              ),
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  offset: Offset(0,2),
                                  blurRadius: 4
                              ),
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  offset: Offset(0,16),
                                  blurRadius: 6
                              )

                            ]
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 14,right: 14,top: 18),
                              child: Text("إذا كانت تواجه أي مشكلة او أقتراحات لتطبيق يمكنك ارسالنا الينا",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/13,
                              margin: EdgeInsets.only(top: 14,left: 16,right: 16),
                              child: Divider(
                                color: Theme.of(context).primaryColor,
                                thickness: 3,
                              ),
                            ),
                            CustomTextField.TextFieldWithIcon(controller: name,hintText: "",obscureText: false,margin: EdgeInsets.only(top: 12,left: 16,right: 16),icon: "assets/icons/account.svg"),
                            CustomTextField.TextFieldWithIcon(controller: numberPhone,hintText: numberPhone.text==""?"لا يتوفر رقم الهاتف":"",obscureText: false,margin: EdgeInsets.only(top: 10,left: 16,right: 16),icon: "assets/icons/iphone.svg",colorHintText: Color(0xffB7B7B7),keyboardType: TextInputType.number),
                            // CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 24,left: 16,right: 16),icon: 'assets/icons/iphone.svg',text: '+972592336959',onPressed: (){}),
                            Container(
                              margin: EdgeInsets.only(top: 10,left: 16,right: 16),
                              height: 172,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffCFE9FF)),
                                borderRadius: BorderRadius.circular(16),

                              ),
                              child: TextField(

                                style:  TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),
                                textAlign: TextAlign.start,
                                maxLines: 10,
                                controller: messageProblem,
                                decoration: InputDecoration(
                                    hintText:"رسالتك",
                                    hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),
                                    border: InputBorder.none,
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                                    prefixIcon: Container(
                                      width: 30,
                                      height: 172,
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.only(top: 5,right: 5,left: 5,bottom: 8),
                                      margin: EdgeInsets.only(right: 16,top: 7),
                                      child: SvgPicture.asset("assets/icons/paper-plane.svg",),
                                    )


                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 100),
                              height: 42,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                padding: EdgeInsets.only(top: 12,bottom: 12,left: 40,right: 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("إرسال",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'SansArabicLight',color:Colors.white),),
                                onPressed: (){
                                  context.read<SettingsBloc>()..add(ReportProblemOnClickEvent(name.text, numberPhone.text, messageProblem.text));
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
