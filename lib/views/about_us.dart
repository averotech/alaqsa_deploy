import 'package:alaqsa/bloc/settings/settings_bloc.dart';
import 'package:alaqsa/bloc/settings/settings_event.dart';
import 'package:alaqsa/bloc/settings/settings_state.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateAboutUsPage();
  }

}

class StateAboutUsPage extends State<AboutUsPage> {
  var aboutUs;
  List goals = [];
  List achievements = [];
  List workplace = [];
  var services = [1,2,3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>SettingsBloc()..add(AboutUsEvent()),
        child: BlocListener<SettingsBloc,SettingsState>(
          listener: (context,state){
            if(state is AboutUSLoaded){
              aboutUs = state.aboutUs;
              if(aboutUs != null) {
                goals = aboutUs["goals"];
                achievements = aboutUs["achievements"];
                workplace = aboutUs["workplace"];

              }
            }
          },
          child: BlocBuilder<SettingsBloc,SettingsState>(
            builder: (context,state){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 94,
                      child: CustomNavBar.customNaveBar(context: context,title: "من نحن"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32,left: 16,right: 16),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.35,
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
                            child: Text("تعرف علينا بشكل أفضل وعن خدماتنا",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/13,
                            margin: EdgeInsets.only(top: 14,left: 16,right: 16),
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 3,
                            ),
                          ),

                          Container(
                            height: MediaQuery.of(context).size.height/1.62,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 24),
                                    child: Text("${aboutUs != null ?aboutUs["main_text"]:""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 8),
                                    child: Text("${aboutUs != null ?aboutUs["sub_main_text"]:""}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 24),
                                    child: Text("${aboutUs != null ?aboutUs["vision_main"]:""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 8),
                                    child: Text("${aboutUs != null ?aboutUs["vision_sub_text_Main"]:""}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 24,bottom: 8),
                                    child: Text("${aboutUs != null ?aboutUs["goals_text"]:""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                  ),
                                  Column(
                                      children: goals.map((g) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(left: 14,right: 14,bottom: 17),
                                          child: Text(g.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                                        );
                                      }).toList()
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 24,bottom: 8),
                                    child: Text("${aboutUs != null ?aboutUs["achievements_text"]:""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                  ),
                                  Column(
                                      children: achievements.map((a) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(left: 14,right: 14,bottom: 17),
                                          child: Text(a.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                                        );
                                      }).toList()
                                  ),

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 14,right: 14,top: 24,bottom: 8),
                                    child: Text("${aboutUs != null ?aboutUs["workplace_text"]:""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                  ),
                                  Column(
                                      children: workplace.map((w) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(left: 14,right: 14,bottom: 17),
                                          child: Text("${w["text_main_workplace"]} \n ${w["sup_text_workplace"]}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                                        );
                                      }).toList()
                                  ),

                                ],
                              ),
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
