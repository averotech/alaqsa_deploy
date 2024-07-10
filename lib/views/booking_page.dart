import 'dart:async';

import 'package:alaqsa/bloc/booking_page_page/booking_page_bloc.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_event.dart';
import 'package:alaqsa/bloc/booking_page_page/booking_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/MYLoaction.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateBookingPage();
  }

}

class StateBookingPage extends State<BookingPage> {
  TextEditingController numberPhone = TextEditingController();
  GlobalState globalState = GlobalState.instance;
  var numberPerson = 1;
  var trip;
  var selectedBus;
  var user;
  var myLocation;
  increasPresone(){
    setState((){
      if(numberPerson < 99){
        numberPerson++;
      }

    });
  }

  decreasPresone(){
    setState((){
      if(numberPerson > 1){
        numberPerson--;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BookingPageBloc()..add(BookingPageInitialEvent(false)),
        child: BlocListener<BookingPageBloc,BookingPageState>(
          listener: (context,state) {
            if(state is BookingPageLoaded){

              trip = state.trip;
              user = state.user;
              myLocation = state.myLocation;
            }
            if(state is BookingPageLoadedSelectedBus) {
              selectedBus = state.bus;
            }

            if(state is BookingPageInitial){
              if(Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
              }
            }

            if(state is BookingTripLoaded){
              if( Config.isShowingLoadingDialog == true) {
                Config.isShowingLoadingDialog = false;
                Navigator.of(context).pop();
              }
              print('state.responseCode   ${state.responseCode}');

              if(state.responseCode == 200) {
                globalState.set("bookingTripSuccess", trip);
                Navigator.of(context).pushNamed("CompletedBookingPage");
              }
              // if(state.responseCode == 202) {
              //   if( Config.isShowingLoadingDialog == false) {
              //     Config.isShowingLoadingDialog = true;
              //     CustomAlertDailog.CustomLoadingDialog(context:context, color:Theme.of(context).primaryColor, size:35.0, message:"تم الحجز سابقا", type:2, height: 100.0);
              //     Timer(Duration(seconds: 1),(){
              //       if(Config.isShowingLoadingDialog == true) {
              //         Config.isShowingLoadingDialog = false;
              //         Navigator.of(context).pop();
              //       }
              //     });}
              // }

              else if(state.responseCode == 500 || state.responseCode == 404){

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

            if(state is BookingPageErroe) {
              if(Config.isShowingLoadingDialog == true) {
                Config.isShowingLoadingDialog = false;
                Navigator.of(context).pop();
              }
              if( Config.isShowingLoadingDialog == false) {
                Config.isShowingLoadingDialog = true;
                CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message: state.error, type:3, height: 100.0);
                Timer(Duration(seconds: 1),(){
                  if(Config.isShowingLoadingDialog == true) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                });}
            }
          },
          child:BlocBuilder<BookingPageBloc,BookingPageState>(
            builder: (context,state){
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 94,
                        child: CustomNavBar.customNaveBar(context: context,title: "احجز الان"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32,left: 16,right: 16),
                        height: MediaQuery.of(context).size.height-180,
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
                        child: ListView(
                          padding: EdgeInsets.zero,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSectionComponent.Section(context: context,text: "البيانات الشخصية",margin: EdgeInsets.only(top: 18,left: 16,right: 16),seeMore: false,),

                            CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 24,left: 16,right: 16),icon: 'assets/icons/account.svg',text: user != null?user.name:"",onPressed: (){}),
                            CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 24,left: 16,right: 16),icon: 'assets/icons/account.svg',text: user != null&& user.phone != null ?user.phone:"",onPressed: (){}),
                            // CustomTextField.TextFieldWithIcon(controller: numberPhone,hintText: numberPhone.text==""?"لا يتوفر رقم الهاتف":"",obscureText: false,margin: EdgeInsets.only(top: 16,left: 16,right: 16),icon: "assets/icons/iphone.svg",colorHintText: Color(0xffB7B7B7),textColor: Colors.black,fontSize: 16.0),

                            // CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,left: 16,right: 16),icon: 'assets/icons/iphone.svg',text: user != null?user.phoen != ""?user.phoen:"غير معروف":"",onPressed: (){}),
                            CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,bottom: 0,left: 16,right: 16),icon: 'assets/icons/location.svg',text: myLocation,onPressed: (){}),

                            CustomSectionComponent.Section(context: context,text: "عدد اشخاص اخرين",margin: EdgeInsets.only(top: 24,left: 16,right: 16),seeMore: false,),


                            Container(
                              width: MediaQuery.of(context).size.width/1.50,
                              margin: EdgeInsets.only(top: 24,left: 16,right: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Color(0xffCFE9FF))
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width/3)-38,
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
                                      child:Container(
                                        child: SvgPicture.asset("assets/icons/plus.svg",height: 20,width: 20,),
                                      ),
                                      onPressed: (){
                                        this.increasPresone();
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20,right: 20),
                                    child: Text("$numberPerson",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,fontFamily: 'SansArabicLight',color:Color(0xff101426),height: 1.5),),
                                  ),
                                  Container(
                                    width: (MediaQuery.of(context).size.width/3)-38,
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
                                      child: Container(

                                        child: SvgPicture.asset("assets/icons/minus.svg",height: 20,width: 20,),
                                      ),
                                      onPressed: (){
                                        this.decreasPresone();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Container(

                              margin: EdgeInsets.only(left: 16,right: 16,top: 32,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width-128,
                                  //   child: CustomSectionComponent.Section(context: context,text: "قم باختيار الباص ",margin: EdgeInsets.only(left: 0,right: 0),seeMore: false,),
                                  // ),
                                  // Container(
                                  //   child: TextButton(
                                  //     style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
                                  //     child: Text("${selectedBus != null ?"تغيير" : "أختر"}",style:TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,)),
                                  //     onPressed: () async{
                                  //       var bus = await CustomAlertDailog.ShowBusesModalBottomSheet(context: context,trip: trip);
                                  //       if(bus != null) {
                                  //         selectedBus = bus;
                                  //         context.read<BookingPageBloc>()..add(BookingPageSelectedBusEvent(selectedBus));
                                  //       }
                                  //     },
                                  //   ),
                                  // )
                                ],
                              ),
                            ),

                            if(selectedBus != null)Container(
                              child: CustomCard.CardInformationBus(context: context,bus: selectedBus, trip: trip,activeClick: false),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 24,bottom: 0,left: 16,right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [


                                  Container(
                                    width: (MediaQuery.of(context).size.width)-64,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: MaterialButton(
                                      height: 45,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Text("تأكيد الحجز",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                      onPressed: (){

                                        CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد تأكيد الحجز؟",textButton1: "نعم",textButton2: "لا",onClick1: (){
                                          if(trip != null){
                                            Navigator.of(context).pop();
                                            context.read<BookingPageBloc>()..add(BookingTripEvent(trip.id, selectedBus, numberPerson, numberPhone));
                                          }
                                        },onClick2: (){
                                          Navigator.of(context).pop();
                                        });

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
                                  //     child: Text("الغاء الحجز",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                  //     onPressed: (){
                                  //
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            CustomSectionComponent.Section(context: context,text: "يمكنك ايضا",margin: EdgeInsets.only(top: 32,left: 16,right: 16),seeMore: false,),
                            Container(
                              width: (MediaQuery.of(context).size.width),
                              height: 48,
                              margin: EdgeInsets.only(top: 32,left: 16,right: 16,bottom: 32),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: MaterialButton(
                                height: 48,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("تبرع الان",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                                onPressed: (){
                                  Navigator.of(context).pushNamed("DonationSummaryPage");
                                  // CustomAlertDailog.CaneledBokkingDialog(context: context,titelText: " هل تريد تأكيد عملية التطوع؟",textButton1: "نعم",textButton2: "لا",onClick1: (){
                                  //
                                  // },onClick2: (){});

                                },
                              ),
                            ),
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
