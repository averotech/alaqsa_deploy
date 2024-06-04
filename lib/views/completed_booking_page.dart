import 'dart:async';

import 'package:alaqsa/bloc/booking_page_page/booking_page_bloc.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_event.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/LineDashedPainter.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/config.dart';

class CompletedBookingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateCompletedBookingPage();
  }

}

class StateCompletedBookingPage extends State<CompletedBookingPage> {
  var trip;
  var myAddress = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BookingPageBloc()..add(BookingTripSuccessEvent()),
        child: BlocListener<BookingPageBloc,BookingPageState>(
          listener: (context,state){
            if(state is BookingTripSuccessLoaded){
              trip = state.trip;
              myAddress = state.myAddrees;
            }

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
                // context.read<TripBloc>()..add(UpdateTripEvent(trip));
                if( Config.isShowingLoadingDialog == false) {
                  Config.isShowingLoadingDialog = true;
                  CustomAlertDailog.CustomLoadingDialog(context:context, color:Theme.of(context).primaryColor, size:35.0, message:"تم الغاء الحجز", type:2, height: 100.0);
                  Timer(Duration(seconds: 1),(){
                    if(Config.isShowingLoadingDialog == true) {
                      Config.isShowingLoadingDialog = false;
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);
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
          },
          child: BlocBuilder<BookingPageBloc,BookingPageState>(
            builder: (context,state){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 94,
                      child: CustomNavBar.customNaveBar(context: context,title: "احجز الان"),
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

                            child: Text("تم الحجز بنجاح",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),textAlign: TextAlign.center,),
                          ),

                          CustomSectionComponent.Section(context: context,text: "تفاصيل الرحلة",margin: EdgeInsets.only(top: 32,left: 16,right: 16),seeMore: false,),

                          if(trip != null) Container(
                            padding: EdgeInsets.only(left: 8,right: 8),
                            margin: EdgeInsets.only(top: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(

                                        height: MediaQuery.of(context).size.height/3.3,

                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: SvgPicture.asset("assets/icons/location.svg"),
                                            ),


                                            Container(
                                              height: 51,
                                              child: CustomPaint(painter: LineDashedPainter(Color(0xffB7B7B7))),
                                            ),

                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffE4FFE5),
                                                  shape: BoxShape.circle
                                              ),
                                              child: SvgPicture.asset("assets/icons/tour-bus.svg",color: Theme.of(context).primaryColor,),
                                            ),
                                            Container(
                                              height: 51,
                                              child: CustomPaint(painter: LineDashedPainter(Color(0xffB7B7B7))),
                                            ),

                                            Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  shape: BoxShape.circle
                                              ),
                                              child: SvgPicture.asset("assets/icons/al-aqsa-mosque.svg"),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(left: 12,right: 12),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomSectionComponent.StartingEndingPoint(context: context,margin: EdgeInsets.only(top: 16),title: 'مكانك الحالي',location: '${myAddress != "" ? myAddress:"غير معروف"}',clockIcon: 'assets/icons/clock.svg',time: null,distanceIcon: 'assets/icons/distance.svg',km:'كم ' + (trip.fromDistance != null?trip.fromDistance.toString():"0.0"),globalColor: Color(0xffB7B7B7),iconColor:Color(0xffB7B7B7),titleColor: Theme.of(context).primaryColor),
                                            CustomSectionComponent.StartingEndingPoint(context: context,margin: EdgeInsets.only(top: 16),title: 'مكان الأنطلاق',location: trip.from.addressLocation != null ? trip.tripFromLocation .toString().length>30? trip.tripFromLocation.toString().substring(0,30):trip.tripFromLocation.toString():"غير معروف" ,clockIcon: 'assets/icons/clock.svg',time: trip.startTime.toString(),distanceIcon: 'assets/icons/distance.svg',km: 'كم ' +  (trip.fromDistance != null?trip.fromDistance.toString():"0.0"),globalColor: Color(0xff101426),iconColor:Theme.of(context).primaryColor,titleColor: Theme.of(context).primaryColor),
                                            CustomSectionComponent.StartingEndingPoint(context: context,margin: EdgeInsets.only(top: 16),title: 'مكان الوصول',location: trip.to.addressLocation  != null ? trip.tripToLocation.toString().length>30? trip.tripToLocation.toString().substring(0,30):trip.tripToLocation.toString():'المسجد الأقصى',clockIcon: 'assets/icons/clock.svg',time: null,distanceIcon: 'assets/icons/distance.svg',km: 'كم ' +  (trip.fromDistance != null?trip.toDistance.toString():"0.0"),globalColor: Color(0xff101426),iconColor:Theme.of(context).primaryColor,titleColor: Theme.of(context).primaryColor),

                                            Container(
                                              margin: EdgeInsets.only(top: 16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [

                                                  Container(
                                                    margin: EdgeInsets.only(left: 20),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(

                                                          child: Text("وقت العودة",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.2)),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 2),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset("assets/icons/clock.svg",color: Theme.of(context).primaryColor),
                                                              Container(
                                                                margin: EdgeInsets.only(right: 2),
                                                                child: Text(trip.endTime,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(

                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          child: Text("مكان العودة",style:TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.2)),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(top: 2),
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset("assets/icons/location.svg",color: Theme.of(context).primaryColor),
                                                              Container(
                                                                margin: EdgeInsets.only(right: 2),
                                                                child: Text("${trip.from.addressLocation != null ? trip.tripFromLocation.toString().length>30? trip.tripFromLocation.toString().substring(0,30):trip.tripFromLocation.toString():"غير معروف"}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),

                              ],
                            ),
                          ),

                          Container(
                            width: (MediaQuery.of(context).size.width),
                            height: 48,
                            margin: EdgeInsets.only(top: 32,left: 16,right: 16),
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
                              child: Text("الغاء الحجز",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                              onPressed: (){
                                CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد الغاء الحجز؟",textButton1: "نعم",textButton2: "لا",onClick1: (){

                                  Navigator.of(context).pop();
                                  context.read<BookingPageBloc>()..add(CancleBookingTripEvent(trip.id,0));

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
          ),
        ),
      ),
    );
  }

}
