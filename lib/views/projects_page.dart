import 'dart:async';

import 'package:alaqsa/bloc/project/project_bloc.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_bloc.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_event.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/views/detaile_news_and_project_page.dart';
import 'package:alaqsa/views/volunteer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateProjectsPage();
  }

}

class StateProjectsPage extends State<ProjectsPage> {
  @override

  ScrollController _scrollController =  ScrollController();
  GlobalState globalState = GlobalState.instance;
  var isScrollEnd = false;
  var nextPageUrl = "";
  List<Project> projectList = <Project>[];
  var onClickProject;
  var isLoaded = false;
  var isLoadedError = false;

  Widget build(BuildContext context) {

    return Scaffold(
      body: MultiBlocProvider(

        providers: [
          BlocProvider(create: (context) => ProjectBloc()..add(LoadProjectAPIEvent(false))),
          BlocProvider(create: (context) => VolunteerPageBloc()),

        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProjectBloc,ProjectState>(listener: (context,state){

              if(state is ProjectInitial) {
                isLoaded = false;
                isLoadedError = false;
                if(state.isRefresh == false) {
                  if( Config.isShowingLoadingDialog == false) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                  }
                }

              }
              if(state is ProjectFoundNextPages) {
                nextPageUrl = state.nextPageUrl;
              }
              if(state is ProjectLoaded) {
                projectList = state.projectsList;
                isLoaded = true;
                if(state.isRefresh == false) {
                  if( Config.isShowingLoadingDialog == true) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                }

              }
            }),
            BlocListener<VolunteerPageBloc,VolunteerPageState>(
              listener: (context,state) {


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
                    if(onClickProject != null) {
                      context.read<ProjectBloc>()..add(UpdateProjectEvent(onClickProject));
                    }

                    if( Config.isShowingLoadingDialog == false) {
                      Config.isShowingLoadingDialog = true;
                      CustomAlertDailog.CustomLoadingDialog(context:context, color: Theme.of(context).primaryColor, size:35.0, message:"تم الغاء التطوع", type:2, height: 100.0);
                      Timer(Duration(seconds: 1),(){
                        if(Config.isShowingLoadingDialog == true) {
                          Config.isShowingLoadingDialog = false;
                          Navigator.of(context).pop();
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
                  isLoadedError = true;
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
            )
          ],
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            child: BlocBuilder<ProjectBloc,ProjectState>(

                builder:(context,state){

                  return  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 124),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSectionComponent.Section(context: context,text: "المشاريع",margin: EdgeInsets.only(top: 0,bottom: 16,left: 16,right: 16),seeMore: false),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height-190,
                          child: NotificationListener(
                            onNotification: (notification){
                              if (notification is ScrollEndNotification && _scrollController.position.extentAfter == 0) {
                                if(nextPageUrl != "null" && nextPageUrl != "" ) {
                                  context.read<ProjectBloc>().add(LoadProjectAPINextPageEvent(nextPageUrl,projectList));
                                }
                              }

                              return false;
                            },
                            child: projectList.isNotEmpty?CustomListView.ListProjects(context: context,controller: _scrollController,projects: projectList,onRefresh: (){
                              projectList.clear();
                              nextPageUrl = "null";
                              nextPageUrl = "";
                              context.read<ProjectBloc>().add(LoadProjectAPIEvent(true));
                              return Future.delayed(Duration(seconds: 1), () {});

                            },onPressed: (index){
                              globalState.set("project", projectList[index]);
                              globalState.set("news", null);
                              if(projectList[index].publicationStatus) {
                                Navigator.of(context).pushNamed("DetaileNewsAndProjectPage");
                              }

                            },onPressedVolunteer: (project){
                              if(project.is_volunteer_user){
                                onClickProject = project;
                                context.read<VolunteerPageBloc>()..add(CancleVolunteerPageRequestApiEvent(project.id));
                              } else {
                                globalState.set("volunteerProject", project);
                                Navigator.of(context).pushNamed("VolunteerPage");
                              }
                            },bottom: 142.0):isLoaded?Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                margin: EdgeInsets.only(bottom: 150,left: 16,right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),

                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد مشاريع لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                    )
                                  ],
                                )
                            ):Container()
                          ),
                        )

                      ],
                    ),

                  );

                }
            ),
          ),
        ),

      ),
    );
  }

}