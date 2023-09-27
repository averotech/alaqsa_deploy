import 'dart:async';

import 'package:alaqsa/bloc/booking_page_page/booking_page_bloc.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_event.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_state.dart';
import 'package:alaqsa/bloc/trip/trip_bloc.dart';
import 'package:alaqsa/bloc/trip/trip_event.dart';
import 'package:alaqsa/bloc/trip/trip_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class TripPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return StateTripPage();
  }

}


class StateTripPage extends State<TripPage> {

  ScrollController _scrollController =  ScrollController();
  GlobalState globalState = GlobalState.instance;
  var isScrollEnd = false;
  var skip = 0;
  List<Trip> tripList = <Trip>[];
  var isLoaded = false;
  var isLoadedError = false;

  onPressedOpenAndCloseTrip(index){
    setState(() {
      tripList[index].isOpen == true?  tripList[index].isOpen=false:  tripList[index].isOpen=true;
    });
  }
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: MultiBlocProvider(
         providers: [
           BlocProvider(create: (context) => TripBloc()..add(LoadTripAPIEvent(false))),
           BlocProvider(create: (context) => BookingPageBloc()),

         ],

         child: MultiBlocListener(

           listeners: [
             BlocListener<TripBloc,TripState>(
                 listener: (context,state){
                   if(state is TripInitial) {
                     isLoaded = false;
                     isLoadedError = false;
                     if(state.isRefresh == false) {
                       if(Config.isShowingLoadingDialog == false) {
                         Config.isShowingLoadingDialog = true;
                         CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                       }
                     }

                   }
                   if(state is SkipTrips) {
                     skip = state.skip;
                   }
                   if(state is TripLoaded) {
                     isLoaded = true;
                     tripList = state.tripList;
                     if(state.isRefresh == false) {
                       if( Config.isShowingLoadingDialog == true) {
                         Config.isShowingLoadingDialog = false;
                         Navigator.of(context).pop();
                       }
                     }

                   }
                   if(state is TripErroe){
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
                       context.read<TripBloc>()..add(UpdateTripEvent(tripList[state.index]));
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
           child: SingleChildScrollView(
             physics: NeverScrollableScrollPhysics(),
             padding: EdgeInsets.zero,
             child: BlocBuilder<TripBloc,TripState>(
               builder: (context,state){
                 return  Container(
                   width: MediaQuery.of(context).size.width,
                   height: MediaQuery.of(context).size.height,
                   margin: EdgeInsets.only(top: 124),

                   child:  Column(

                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       CustomSectionComponent.Section(context: context,text: "الرحلات",margin: EdgeInsets.only(top: 0,bottom: 16,left: 16,right: 16),seeMore: false),
                       Container(
                         width: MediaQuery.of(context).size.width,
                         height: MediaQuery.of(context).size.height-190,
                         child: NotificationListener(
                             onNotification: (notification){
                               if (notification is ScrollEndNotification &&
                                   _scrollController.position.extentAfter == 0) {
                                 skip = skip+10;
                                 context.read<TripBloc>().add(LoadTripAPINextPageEvent(skip,tripList));
                               }

                               return false;
                             },
                             child: tripList.isNotEmpty?CustomListView.ListTrips(context: context,controller:_scrollController,tripList: tripList,bottom: 142.0,onRefresh: (){
                               tripList.clear();
                               skip = 0;
                               context.read<TripBloc>().add(LoadTripAPIEvent(true));
                               return Future.delayed(Duration(seconds: 1), () {});
                             },onPressed: (index){onPressedOpenAndCloseTrip(index);},onPressedBookingAndCloseTrip: (index) async{
                               if(await Config.checkLogin() == true){
                                 if(tripList[index].isBooking == false){
                                   globalState.set("trip", tripList[index]);
                                   Navigator.of(context).pushNamed("BookingPage");
                                 } else {

                                   CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد الغاء الحجز؟",textButton1: "نعم",textButton2: "لا",onClick1: (){

                                     Navigator.of(context).pop();
                                     context.read<BookingPageBloc>()..add(CancleBookingTripEvent(tripList[index].id,index));

                                   },onClick2: (){
                                     Navigator.of(context).pop();
                                   });

                                 }
                               } else{
                                 Navigator.of(context).pushNamed("LoginPage");
                               }


                             }):isLoaded?Container(
                                 width: MediaQuery.of(context).size.width,
                                 height: MediaQuery.of(context).size.height,
                                 margin: EdgeInsets.only(bottom: 150,left: 16,right: 16),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     SvgPicture.asset(isLoadedError?"assets/icons/error_icon.svg":"assets/icons/no_data.svg"),

                                     Container(
                                       margin: EdgeInsets.only(top: 14),
                                       child:Text(isLoadedError?"حدث خطأ ما يرجى المحاولة مرة أخرى":"لا يوجد رحلات لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                     )
                                   ],
                                 )
                             ):Container()
                         ),
                       )
                     ],

                   ),
                 );
               },
             ),
           ),
         ),
       ),
     );
  }

}

