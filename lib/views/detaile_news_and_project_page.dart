import 'dart:async';

import 'package:alaqsa/bloc/news/news_bloc.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/bloc/project/project_bloc.dart';
import 'package:alaqsa/bloc/project/project_event.dart';
import 'package:alaqsa/bloc/project/project_state.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_bloc.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_event.dart';
import 'package:alaqsa/bloc/volunteer_page/volunteer_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DetaileNewsAndProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateDetaileNewsAndProjectPage();
  }

}

class StateDetaileNewsAndProjectPage extends State<DetaileNewsAndProjectPage> {
  GlobalState globalState = GlobalState.instance;
  var onClickProject;
  ProjectBloc projectBloc = ProjectBloc();
  GlobalKey _containerKey = GlobalKey();
  var heightNewsContent = 0.0;
  @override
  void initState() {
    getHeight();
  }
  void getHeight() {
    Timer.periodic(Duration(milliseconds: 500), (_) {
      if(_containerKey.currentContext != null) {
        var renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;

        if(renderBox != null) {
          var height = renderBox.size.height;
          setState(() {
            heightNewsContent = height;
          });
        }
      }

    });


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: globalState.get("news") != null ? BlocProvider(
        create: (context) => NewsBloc()..add(DetailNewsEvent()),
        child: BlocBuilder<NewsBloc,NewsState>(
          builder: (context,state){
            if(state is DetailNewsState){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 94,
                      child: CustomNavBar.customNaveBar(context: context,title: "${state.news.title.toString().length > 20 ? state.news.title.toString().substring(0,20) + '...':state.news.title.toString()}"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32,bottom: 0),
                      height: MediaQuery.of(context).size.height-126,

                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 32,left: 16,right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 8,
                              height: heightNewsContent,
                              color: Theme.of(context).primaryColor,
                            ),
                            Container(
                                key: _containerKey,
                                width: MediaQuery.of(context).size.width-47,
                                padding: EdgeInsets.all(4),
                                margin: EdgeInsets.only(right: 7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          offset: Offset(0,0),
                                          blurRadius: 1
                                      ),
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.04),
                                          offset: Offset(0,2),
                                          blurRadius: 6
                                      ),
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          offset: Offset(0,16),
                                          blurRadius: 24
                                      )

                                    ]
                                ),
                                child:Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 8,right: 8),
                                  decoration: BoxDecoration(
                                      color: Color(0xffE4FFE5).withOpacity(0.52),
                                      borderRadius:BorderRadius.circular(5)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Container(
                                        margin: EdgeInsets.only(top: 18),
                                        child: Text("${state.news.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),),
                                      ),
                                      Container(

                                        child: Text("${state.news.date}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3),height: 1.5),),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Html(data: '${state.news.content}',
                                            style: {
                                              "*":Style(
                                                  fontSize: FontSize.medium,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'SansArabicLight',
                                                  color: Color(0xff101426)
                                              )
                                            },
                                          )
                                        // Text("ل لنص يمكن أن يستبدل في نفس المساحة الأخرى إضافة إلى زيادة .",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff101426),height: 1.5,),maxLines: 100,
                                        //   overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,),
                                      ),

                                      Container(
                                        height: (MediaQuery.of(context).size.height/5).roundToDouble(),
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(top: 10,bottom: 18),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5.0),
                                          child: Image.network("${Config.BaseUrl.toString()+"/storage/"+state.news.imageNews}",fit: BoxFit.cover,),
                                        ),
                                      ),

                                    ],
                                  ),
                                )),


                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },

        ),
      ): MultiBlocProvider(
        providers:[
          BlocProvider(create: (context) => projectBloc..add(DetailProjectEvent())),
          BlocProvider(create: (context) => VolunteerPageBloc()),
        ],
        child: MultiBlocListener(
          listeners: [
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
                      projectBloc..add(UpdateDetailProjectEvent(onClickProject));
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
            ),
            BlocListener<ProjectBloc,ProjectState>(
                listener: (context,state) {
                  if(state is UpdateProject) {
                    print(state.project.nameProject);
                  }
             })
          ],
          child: BlocBuilder<ProjectBloc,ProjectState>(
            builder: (context,state){
              if(state is DetailProjectState){
                var now = DateTime.now();
                bool isExpired = false;
                if(state.project.endDate != null && state.project.endDate.toString() != "") {
                  var expirationDate = DateTime.parse(state.project.endDate);
                  isExpired = expirationDate.isBefore(now);
                } else {
                  isExpired = false;
                }

                state.project = state.project;



                return Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 94,
                        child: CustomNavBar.customNaveBar(context: context,title: "${state.project.news.title.toString().length > 20 ? state.project.news.title.toString().substring(0,20) + '...':state.project.news.title.toString()}"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32,bottom: 0),
                        height: MediaQuery.of(context).size.height-126,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 32,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: heightNewsContent,
                                color: Theme.of(context).primaryColor,
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width-47,
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(right: 7),
                                  key: _containerKey,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.04),
                                            offset: Offset(0,0),
                                            blurRadius: 1
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.04),
                                            offset: Offset(0,2),
                                            blurRadius: 6
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.06),
                                            offset: Offset(0,16),
                                            blurRadius: 24
                                        )

                                      ]
                                  ),
                                  child:Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE4FFE5).withOpacity(0.52),
                                        borderRadius:BorderRadius.circular(5)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 18),
                                          child: Text("${state.project.news.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),),
                                        ),
                                        Container(

                                          child: Text("${state.project.news.date}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3),height: 1.5),),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Html(data: '${state.project.news.content}',
                                              style: {
                                                "*":Style(
                                                    fontSize: FontSize.medium,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SansArabicLight',
                                                    color: Color(0xff101426)
                                                )
                                              },
                                            )
                                        ),
                                        Visibility(visible: isExpired || (state.project.is_donation == false && state.project.is_volunteer == false)?false:true,child:  Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 20,bottom: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Visibility(visible: state.project.is_donation && !isExpired,child:Container(
                                                width: state.project.is_volunteer == false && !isExpired?(MediaQuery.of(context).size.width)-71:(MediaQuery.of(context).size.width/2)-40,
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
                                                  child: Text("تبرع الان",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                                  onPressed: () async{
                                                    if(await Config.checkLogin() == true){
                                                      globalState.set("donationTrip", null);
                                                      globalState.set("donationProject", state.project);
                                                      Navigator.of(context).pushNamed("DonationSummaryPage");
                                                    } else {
                                                      Navigator.of(context).pushNamed("LoginPage");
                                                    }

                                                  },
                                                ),
                                              )),
                                              Visibility(visible: state.project.is_volunteer && !isExpired,child:Container(
                                                height: 42,
                                                width: state.project.is_donation == false && !isExpired?(MediaQuery.of(context).size.width)-71:(MediaQuery.of(context).size.width/2)-40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: MaterialButton(
                                                  height: 42,
                                                  shape: RoundedRectangleBorder(

                                                      borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  child: Text(state.project.is_volunteer_user == false?"تطوع الأن":"الغاء التطوع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                                  onPressed: () async{
                                                    if(await Config.checkLogin() == true){

                                                      if(state.project.is_volunteer_user){
                                                        onClickProject = state.project;
                                                        context.read<VolunteerPageBloc>()..add(CancleVolunteerPageRequestApiEvent(state.project.id));
                                                      } else {
                                                        globalState.set("volunteerProject", state.project);
                                                        Navigator.of(context).pushNamed("VolunteerPage");
                                                      }

                                                    } else {
                                                      Navigator.of(context).pushNamed("LoginPage");
                                                    }
                                                  },
                                                ),
                                              )),
                                            ],
                                          ),
                                        )),
                                        Container(
                                          height: (MediaQuery.of(context).size.height/5).roundToDouble(),
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 10,bottom: 18),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: state.project.news.imageNews.toString() != "null"?Image.network("${Config.BaseUrl.toString()+"/storage/"+state.project.news.imageNews}",fit: BoxFit.cover,):Image.asset("assets/images/image3.png",fit: BoxFit.cover,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else if(state is UpdateProject) {
                var now = DateTime.now();
                var expirationDate = DateTime.parse(state.project.endDate);
                bool isExpired = expirationDate.isBefore(now);
                state.project = state.project;
                return Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 94,
                        child: CustomNavBar.customNaveBar(context: context,title: "${state.project.news.title.toString().length > 20 ? state.project.news.title.toString().substring(0,20) + '...':state.project.news.title.toString()}"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32,bottom: 0),
                        height: MediaQuery.of(context).size.height-126,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 32,left: 16,right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: heightNewsContent,
                                color: Theme.of(context).primaryColor,
                              ),
                              Container(
                                  key: _containerKey,
                                  width: MediaQuery.of(context).size.width-47,
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.04),
                                            offset: Offset(0,0),
                                            blurRadius: 1
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.04),
                                            offset: Offset(0,2),
                                            blurRadius: 6
                                        ),
                                        BoxShadow(
                                            color: Colors.black.withOpacity(0.06),
                                            offset: Offset(0,16),
                                            blurRadius: 24
                                        )

                                      ]
                                  ),
                                  child:Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(left: 8,right: 8),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE4FFE5).withOpacity(0.52),
                                        borderRadius:BorderRadius.circular(5)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(top: 18),
                                          child: Text("${state.project.news.title}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),),
                                        ),
                                        Container(

                                          child: Text("${state.project.news.date}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3),height: 1.5),),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 8),
                                            child: Html(data: '${state.project.news.content}',
                                              style: {
                                                "*":Style(
                                                    fontSize: FontSize.medium,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'SansArabicLight',
                                                    color: Color(0xff101426)
                                                )
                                              },
                                            )
                                        ),
                                        Visibility(visible: isExpired || (state.project.is_donation == false && state.project.is_volunteer == false)?false:true,child:  Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 20,bottom: 16),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Visibility(visible: state.project.is_donation && !isExpired,child:Container(
                                                width: state.project.is_volunteer == false && !isExpired?(MediaQuery.of(context).size.width)-71:(MediaQuery.of(context).size.width/2)-40,
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
                                                  child: Text("تبرع الان",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                                  onPressed: () async{
                                                    if(await Config.checkLogin() == true){
                                                      globalState.set("donationTrip", null);
                                                      globalState.set("donationProject", state.project);
                                                      Navigator.of(context).pushNamed("DonationSummaryPage");
                                                    } else {
                                                      Navigator.of(context).pushNamed("LoginPage");
                                                    }

                                                  },
                                                ),
                                              )),
                                              Visibility(visible: state.project.is_volunteer && !isExpired,child:Container(
                                                height: 42,
                                                width: state.project.is_donation == false && !isExpired?(MediaQuery.of(context).size.width)-71:(MediaQuery.of(context).size.width/2)-40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                                child: MaterialButton(
                                                  height: 42,
                                                  shape: RoundedRectangleBorder(

                                                      borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  child: Text(state.project.is_volunteer_user == false?"تطوع الأن":"الغاء التطوع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                                  onPressed: () async{
                                                    if(await Config.checkLogin() == true){

                                                      if(state.project.is_volunteer_user){
                                                        onClickProject = state.project;
                                                        context.read<VolunteerPageBloc>()..add(CancleVolunteerPageRequestApiEvent(state.project.id));
                                                      } else {
                                                        globalState.set("volunteerProject", state.project);
                                                        Navigator.of(context).pushNamed("VolunteerPage");
                                                      }

                                                    } else {
                                                      Navigator.of(context).pushNamed("LoginPage");
                                                    }
                                                  },
                                                ),
                                              )),
                                            ],
                                          ),
                                        )),
                                        Container(
                                          height: (MediaQuery.of(context).size.height/5).roundToDouble(),
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 10,bottom: 18),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5.0),
                                            child: state.project.news.imageNews.toString() != "null"?Image.network("${Config.BaseUrl.toString()+"/storage/"+state.project.news.imageNews}",fit: BoxFit.cover,):Image.asset("assets/images/image3.png",fit: BoxFit.cover,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  )),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
       ),
      )
    );
  }



}
