import 'dart:async';

import 'package:alaqsa/bloc/volunteer_page/volunteer_page_bloc.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_event.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class VolunteerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateVolunteerPage();
  }

}

class StateVolunteerPage extends State<VolunteerPage> {
  var user;
  var project;
  var myAddress;
  var dateNow = DateTime.now();
  var outputFormat = DateFormat('yyyy-MM-dd, hh:mm a',"en");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VolunteerPageBloc()..add(VolunteerPageInitialEvent()),
        child: BlocListener<VolunteerPageBloc,VolunteerPageState>(
          listener: (context,state) {
            if(state is VolunteerPageLoaded){
              user = state.user;
              project = state.project;
              myAddress = state.myAddress;
            }

            if(state is VolunteerPageInitial) {
              if(Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
              }
            }

            if(state is VolunteerRequestApiLoaded){

              if( Config.isShowingLoadingDialog == true) {
                Config.isShowingLoadingDialog = false;
                Navigator.of(context).pop();
              }
              if(state.responseCode == 200){
                Navigator.of(context).pushNamed("CompletedVolunteerPage");
              } else {
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

            }

            if(state is VolunteerPageErroe){
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
          child: BlocBuilder<VolunteerPageBloc,VolunteerPageState>(
            builder: (context,state){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 94,
                      child: CustomNavBar.customNaveBar(context: context,title: "تطوع الأن"),
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
                          CustomSectionComponent.Section(context: context,text: "البيانات الشخصية",margin: EdgeInsets.only(top: 18,left: 16,right: 16),seeMore: false,),

                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 24,left: 16,right: 16),icon: 'assets/icons/account.svg',text: user != null?user.name:"غير معروف",onPressed: (){}),
                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,left: 16,right: 16),icon: 'assets/icons/iphone.svg',text: user != null? user.phoen != "" ?user.phone:"غير معروف":"غير معروف",onPressed: (){}),
                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,bottom: 0,left: 16,right: 16),icon: 'assets/icons/location.svg',text: myAddress ??"غير معروف",onPressed: (){}),
                          CustomSectionComponent.Section(context: context,text: "البيانات الشخصية",margin: EdgeInsets.only(top: 24,left: 16,right: 16),seeMore: false,),

                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16,top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,width: 30,
                                  padding: EdgeInsets.all(3),
                                  child: SvgPicture.asset("assets/icons/location.svg"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 6,right: 6),
                                  child: Text("${myAddress != null ?myAddress:"غير معروف"}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16,top: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,width: 30,
                                  padding: EdgeInsets.all(3),
                                  child: SvgPicture.asset("assets/icons/clock.svg"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 6,right: 6),
                                  child: Text("${Config.weekdayName[dateNow.weekday]}"+"  ${outputFormat.format(dateNow)}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 20,bottom: 32,left: 16,right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [


                                Container(
                                  width: (MediaQuery.of(context).size.width)-64,
                                  height: 42,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: MaterialButton(
                                    height: 42,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Text("تأكيد التطوع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                    onPressed: (){
                                      CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد تأكيد عملية التطوع؟",textButton1: "نعم",textButton2: "لا",onClick1: (){
                                        Navigator.of(context).pop();
                                        context.read<VolunteerPageBloc>()..add(VolunteerPageRequestApiEvent(project.id));

                                      },onClick2: (){});

                                    },
                                  ),
                                ),
                                // Container(
                                //   height: 42,
                                //   width: (MediaQuery.of(context).size.width/2)-38,
                                //   decoration: BoxDecoration(
                                //       border: Border.all(color: Theme.of(context).primaryColor),
                                //       borderRadius: BorderRadius.circular(50)
                                //   ),
                                //   child: MaterialButton(
                                //     height: 42,
                                //     shape: RoundedRectangleBorder(
                                //
                                //         borderRadius: BorderRadius.circular(50)
                                //     ),
                                //     child: Text("الغاء التطوع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                //     onPressed: (){
                                //
                                //     },
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
