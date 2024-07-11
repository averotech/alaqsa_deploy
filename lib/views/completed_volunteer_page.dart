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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedVolunteerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateCompletedVolunteerPage();
  }

}

class StateCompletedVolunteerPage extends State<CompletedVolunteerPage> {

  var project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
       create:  (context)=> VolunteerPageBloc()..add(VolunteerPageSuccessEvent()),
        child: BlocListener<VolunteerPageBloc,VolunteerPageState>(
            listener: (context,state){
              if(state is VolunteerPageSuccessLoaded){
                project = state.project;
              }

              if(state is VolunteerPageInitial) {
                if(Config.isShowingLoadingDialog == false) {
                  Config.isShowingLoadingDialog = true;
                  CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                }
              }

              if(state is CancleVolunteerRequestApiLoaded){

                if( Config.isShowingLoadingDialog == true) {
                  Config.isShowingLoadingDialog = false;
                  Navigator.of(context).pop();
                }
                if(state.responseCode == 200){


                  if( Config.isShowingLoadingDialog == false) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(context:context, color: Theme.of(context).primaryColor, size:35.0, message:"تم الغاء التطوع", type:2, height: 100.0);
                    Timer(Duration(seconds: 1),(){
                      if(Config.isShowingLoadingDialog == true) {
                        Config.isShowingLoadingDialog = false;
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
                      }
                    });}
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

                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 24,bottom: 24),
                              child: SvgPicture.asset("assets/icons/done.svg"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,

                              child: Text("تم التطوع بنجاح",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),textAlign: TextAlign.center,),
                            ),

                            CustomSectionComponent.Section(context: context,text: "تفاصيل المشروع",margin: EdgeInsets.only(top: 32,left: 16,right: 16),seeMore: false,),
                            Container(
                              margin: EdgeInsets.only(top: 16,left: 16,right: 16),
                              child: Text("${project != null ? project.nameProject :""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor),),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 16,right: 16,top: 2),
                              child: Text(project != null ?project.startDate:"",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3),height: 1.5),),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 16,right: 16,top: 8),
                              width: MediaQuery.of(context).size.width,
                              // child: Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: [
                                //   Container(
                                //     child: SvgPicture.asset("assets/icons/location.svg",height: 16,width: 16,),
                                //   ),
                                //   Container(
                                //
                                //       margin: EdgeInsets.only(left: 5,right: 5),
                                //       child:Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         children: [
                                //           Container(
                                //             child: Text("مكان المشروع",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor)),
                                //           ),
                                //           Container(
                                //             child:Text("${project != null?(project.location.toString() != null && project.location != "" ? project.location : "غير محدد"):""}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color: Color(0xff8F9BB3)),),
                                //           ),
                                //
                                //         ],
                                //       )),
                                //
                              //   ],
                              // ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 8,left: 16,right: 16),
                              child: Text("${project != null ?project.descriptionProject:""}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),maxLines: 4),
                            ),

                            Container(
                              width: (MediaQuery.of(context).size.width),
                              height: 48,
                              margin: EdgeInsets.only(top: 24,left: 16,right: 16),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                height: 48,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("العودة لصفحة الرئيسة",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                onPressed: (){
                                  Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
                                },
                              ),
                            ),
                            Container(
                              height: 48,
                              width: (MediaQuery.of(context).size.width),
                              margin: EdgeInsets.only(top: 16,bottom: 24,left: 16,right: 16),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                height: 48,
                                shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("الغاء التطوع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                onPressed: (){
                                  CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد الغاء التطوع؟",textButton1: "نعم",textButton2: "لا",onClick1: (){
                                    context.read<VolunteerPageBloc>()..add(CancleVolunteerPageRequestApiEvent(project.id));
                                  },onClick2: (){
                                    Navigator.of(context).pop();

                                  });

                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
        ),
      ),
    );
  }

}
