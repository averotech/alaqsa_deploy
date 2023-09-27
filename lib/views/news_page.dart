import 'package:alaqsa/bloc/news/news_bloc.dart';
import 'package:alaqsa/bloc/news/news_event.dart';
import 'package:alaqsa/bloc/news/news_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/repository/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateNewsPage();
  }

}

class StateNewsPage extends State<NewsPage> {
  ScrollController _scrollController =  ScrollController();
  GlobalState globalState = GlobalState.instance;
  var isScrollEnd = false;
  var nextPageUrl = "";
  List<News> newsList = <News>[];
  var isLoaded = false;
  var isLoadedError = false;


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MultiBlocProvider(

        providers: [
          BlocProvider(create: (context) => NewsBloc()..add(LoadNewsAPIEvent(false))),


        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<NewsBloc,NewsState>(listener: (context,state){

              if(state is NewsInitial) {
                isLoaded = false;
                isLoadedError = false;
                if(state.isRefresh == false) {
                  if(Config.isShowingLoadingDialog == false) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                  }
                }

              }
              if(state is NewsFoundNextPages) {
                nextPageUrl = state.nextPageUrl;
              }
              if(state is NewsLoaded) {
                isLoaded = true;
                newsList = state.newsList;
                if(state.isRefresh == false) {
                  if( Config.isShowingLoadingDialog == true) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                }

              }

              if(state is NewsErroe){
                isLoadedError = true;
                if( Config.isShowingLoadingDialog == true) {
                  Config.isShowingLoadingDialog = false;
                  Navigator.of(context).pop();
                }
              }
            })
          ],
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            child: BlocBuilder<NewsBloc,NewsState>(

                builder:(context,state){

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(top: 124),
                    // padding: EdgeInsets.only(left: 16,right: 16),

                    child:  Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomSectionComponent.Section(context: context,text: "الأخبار",margin: EdgeInsets.only(top: 0,bottom: 16,left: 16,right: 16),seeMore: false),

                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height-190,
                            child: NotificationListener(
                                onNotification: (notification){
                                  if (notification is ScrollEndNotification &&
                                      _scrollController.position.extentAfter == 0) {
                                    if(nextPageUrl != "null" && nextPageUrl != "" ) {
                                      context.read<NewsBloc>().add(LoadNewsAPINextPageEvent(nextPageUrl,newsList));
                                    }
                                  }

                                  return false;
                                },
                                child: newsList.isNotEmpty?CustomListView.ListNews(context: context,controller: _scrollController,listNews: newsList,bottom: 142.0,shrinkWrap: false,physics: AlwaysScrollableScrollPhysics(),onRefresh: (){
                                  newsList.clear();
                                  nextPageUrl = "null";
                                  nextPageUrl = "";
                                  context.read<NewsBloc>().add(LoadNewsAPIEvent(true));
                                  return Future.delayed(Duration(seconds: 1), () {});
                                },onPressed: (index){
                                  globalState.set("news", newsList[index]);
                                  globalState.set("project", null);
                                  Navigator.of(context).pushNamed("DetaileNewsAndProjectPage");
                                }): isLoaded?Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    margin: EdgeInsets.only(bottom: 150,left: 16,right: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),

                                        Container(
                                          margin: EdgeInsets.only(top: 14),
                                          child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد أخبار لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                        )
                                      ],
                                    )
                                ):Container()
                            )
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
    // return Scaffold(
    //   body: MultiBlocProvider(
    //
    //     providers: [
    //       BlocProvider(create: (context) => NewsBloc()..add(LoadNewsAPIEvent(false))),
    //
    //
    //     ],
    //     child: MultiBlocListener(
    //       listeners: [
    //         BlocListener<NewsBloc,NewsState>(listener: (context,state){
    //
    //           if(state is NewsInitial) {
    //             isLoaded = false;
    //             isLoadedError = false;
    //             if(state.isRefresh == false) {
    //               if(Config.isShowingLoadingDialog == false) {
    //                 Config.isShowingLoadingDialog = true;
    //                 CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
    //               }
    //             }
    //
    //            }
    //           if(state is NewsFoundNextPages) {
    //             nextPageUrl = state.nextPageUrl;
    //           }
    //           if(state is NewsLoaded) {
    //             isLoaded = true;
    //             newsList = state.newsList;
    //             if(state.isRefresh == false) {
    //               if( Config.isShowingLoadingDialog == true) {
    //                 Config.isShowingLoadingDialog = false;
    //                 Navigator.of(context).pop();
    //               }
    //             }
    //
    //           }
    //
    //           if(state is NewsErroe){
    //             isLoadedError = true;
    //             if( Config.isShowingLoadingDialog == true) {
    //               Config.isShowingLoadingDialog = false;
    //               Navigator.of(context).pop();
    //             }
    //           }
    //         })
    //       ],
    //       child: SingleChildScrollView(
    //         padding: EdgeInsets.zero,
    //         physics: NeverScrollableScrollPhysics(),
    //         child: BlocBuilder<NewsBloc,NewsState>(
    //
    //             builder:(context,state){
    //
    //               return Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: MediaQuery.of(context).size.height,
    //                 margin: EdgeInsets.only(top: 124),
    //                 // padding: EdgeInsets.only(left: 16,right: 16),
    //
    //                 child:  Column(
    //
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     CustomSectionComponent.Section(context: context,text: "الأخبار",margin: EdgeInsets.only(top: 0,bottom: 16,left: 16,right: 16),seeMore: false),
    //
    //                     Container(
    //                         width: MediaQuery.of(context).size.width,
    //                         height: MediaQuery.of(context).size.height-190,
    //                         child: NotificationListener(
    //                             onNotification: (notification){
    //                               if (notification is ScrollEndNotification &&
    //                                   _scrollController.position.extentAfter == 0) {
    //                                 if(nextPageUrl != "null" && nextPageUrl != "" ) {
    //                                   context.read<NewsBloc>().add(LoadNewsAPINextPageEvent(nextPageUrl,newsList));
    //                                 }
    //                               }
    //
    //                               return false;
    //                             },
    //                             child: newsList.isNotEmpty?CustomListView.ListNews(context: context,controller: _scrollController,listNews: newsList,bottom: 142.0,shrinkWrap: false,physics: AlwaysScrollableScrollPhysics(),onRefresh: (){
    //                               newsList.clear();
    //                               nextPageUrl = "null";
    //                               nextPageUrl = "";
    //                               context.read<NewsBloc>().add(LoadNewsAPIEvent(true));
    //                               return Future.delayed(Duration(seconds: 1), () {});
    //                             },onPressed: (index){
    //                               globalState.set("news", newsList[index]);
    //                               globalState.set("project", null);
    //                               Navigator.of(context).pushNamed("DetaileNewsAndProjectPage");
    //                             }): isLoaded?Container(
    //                                 width: MediaQuery.of(context).size.width,
    //                                 height: MediaQuery.of(context).size.height,
    //                                 margin: EdgeInsets.only(bottom: 150,left: 16,right: 16),
    //                                 child: Column(
    //                                   mainAxisAlignment: MainAxisAlignment.center,
    //                                   children: [
    //                                     SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),
    //
    //                                     Container(
    //                                       margin: EdgeInsets.only(top: 14),
    //                                       child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد أخبار لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
    //                                     )
    //                                   ],
    //                                 )
    //                             ):Container()
    //                         )
    //                     )
    //
    //                   ],
    //
    //                 ),
    //               );
    //             }
    //         ),
    //       ),
    //     ),
    //
    //   ),
    // );
  }

}