import 'dart:async';

import 'package:alaqsa/bloc/booking_page_page/booking_page_bloc.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_event.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_state.dart';
import 'package:alaqsa/bloc/home_page/home_page_bloc.dart';
import 'package:alaqsa/bloc/home_page/home_page_event.dart';
import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/LineDashedPainter.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/components/text_field_search.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return StateHomePage();
  }

}
 class StateHomePage extends State<HomePage> {
 List<News> listNews = <News>[];
 GlobalState globalState = GlobalState.instance;
 var nearTrip;
 var isLoaded = false;
 var isLoadedError = false;
  @override
  void initState() {
    print("it is Work!");
  }

  @override
  Widget build(BuildContext context) {


     return Scaffold(
       resizeToAvoidBottomInset: true,
       body:  MultiBlocProvider(
         providers: [
           BlocProvider(create: (context) => HomePageBloc()..add(HomePageInitialEvent(false))),
           BlocProvider(create: (context) => BookingPageBloc()),
         ],
         child: MultiBlocListener(
           listeners: [
             BlocListener<HomePageBloc,HomePageState>(
                 listener: (context,state){
                   if(state is HomePageInitial) {
                      isLoaded = false;
                      isLoadedError = false;
                       if(state.isRefresh == false) {
                         if( Config.isShowingLoadingDialog == false) {
                           Config.isShowingLoadingDialog = true;
                           CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                         }
                       }

                   }


                   if(state is HomePageLoaded) {
                     listNews = state.listNews;
                     nearTrip = state.trip;
                     isLoaded = true;
                     if(state.isRefresh == false) {
                       if( Config.isShowingLoadingDialog == true) {
                         Config.isShowingLoadingDialog = false;
                         Navigator.of(context).pop();
                       }
                     }

                   }
                   if(state is HomePageErroe){
                     isLoadedError = true;
                     if( Config.isShowingLoadingDialog == true) {
                       Config.isShowingLoadingDialog = false;
                       Navigator.of(context).pop();
                     }
                   }
                 }
             ),
             BlocListener<BookingPageBloc,BookingPageState>(
                 listener: (context,state){

                   if(state is BookingPageInitial){
                     if(state.isRefresh == false) {
                       if(Config.isShowingLoadingDialog == false) {
                         Config.isShowingLoadingDialog = true;
                         CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                       }
                     }
                   }
                   if(state is CancelBookingTripLoaded){
                     if( Config.isShowingLoadingDialog == true) {
                       Config.isShowingLoadingDialog = false;
                       Navigator.of(context).pop();
                     }
                     if(state.responseCode == 200) {
                       context.read<HomePageBloc>()..add(UpdateTripEvent(nearTrip));
                       if( Config.isShowingLoadingDialog == false) {
                         Config.isShowingLoadingDialog = true;
                         CustomAlertDailog.CustomLoadingDialog(context:context, color:Theme.of(context).primaryColor, size:35.0, message:"تم الغاء الحجز", type:2, height: 100.0);
                         Timer(Duration(seconds: 1),(){
                           if(Config.isShowingLoadingDialog == true) {
                             Config.isShowingLoadingDialog = false;
                             Navigator.of(context).pop();
                           }
                         });}
                     } else if(state.responseCode == 500 || state.responseCode == 404){

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
                   if(state is BookingPageErroe){
                     print(state.error.toString());
                   }

                 }
             )
           ],
           child: BlocBuilder<HomePageBloc,HomePageState>(

              builder: (context,state){
                return Container(
                    margin: EdgeInsets.only(top: 124),
                    child:RefreshIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      onRefresh: (){
                        listNews.clear();
                        context.read<HomePageBloc>().add(HomePageInitialEvent(true));
                        return Future.delayed(Duration(seconds: 1), () {});
                      },
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,

                        child: Column(
                          children: [

                            CustomSectionComponent.Section(context: context,text: "الرحلة الأقرب",margin: EdgeInsets.only(top: 0,left: 16,right: 16),seeMore: false),
                            Container(
                              child: nearTrip != null ? CustomCard.CardInformationTrip(context: context,trip:nearTrip,key: null,isBooking: nearTrip.isBooking,onPressedBookingAndCloseTrip: (trip) async{
                                 if(await Config.checkLogin() == true){
                                   if(nearTrip.isBooking == false){
                                     globalState.set("trip", nearTrip);

                                     Navigator.of(context).pushNamed("BookingPage");
                                   } else {

                                     CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد الغاء الحجز؟",textButton1: "نعم",textButton2: "لا",onClick1: (){

                                       Navigator.of(context).pop();
                                       context.read<BookingPageBloc>()..add(CancleBookingTripEvent(nearTrip.id,-1));

                                     },onClick2: (){
                                       Navigator.of(context).pop();
                                     });

                                   }
                                 } else {
                                   Navigator.of(context).pushNamed("LoginPage");
                                 }

                              }):isLoaded?Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 0,left: 16,right: 16),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),

                                      Container(
                                        margin: EdgeInsets.only(top: 14),
                                        child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد اي رحلة قريبة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                      )
                                    ],
                                  )
                              ):Container(),
                            ),
                            TextFiledSearch(),
                            CustomSectionComponent.Section(context: context,text: "أخبار الجمعية",margin: EdgeInsets.only(top: 24,left: 16,right: 16),seeMore: false),
                            Container(
                              margin: EdgeInsets.only(top: 4,left: 16,right: 16),
                              child: listNews.isNotEmpty?CustomListView.ListNews(context: context,listNews: listNews,bottom:124.0,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),onPressed: (index){
                                globalState.set("news", listNews[index]);
                                globalState.set("project", null);
                                Navigator.of(context).pushNamed("DetaileNewsAndProjectPage");
                              }):isLoaded?Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(bottom: 150,left: 16,right: 16),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),

                                      Container(
                                        margin: EdgeInsets.only(top: 14),
                                        child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد أخبار لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                      )
                                    ],
                                  )
                              ):Container(),
                            )
                          ],
                        ),
                      ),
                    )
                );
              },
           ),
         ),
       ),
     );
  }

 }



