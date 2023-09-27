import 'dart:async';

import 'package:alaqsa/bloc/donation_page/donation_page_bloc.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_event.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return StateDonationsPage();
  }
}


class StateDonationsPage extends State<DonationsPage>{
  TextEditingController amountText = TextEditingController();
  TextEditingController nameCard = TextEditingController();
  TextEditingController numberCard = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();
  var user;
  var amount = "";
  var sector = "تبرعات عامة";
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: SingleChildScrollView(
         physics: NeverScrollableScrollPhysics(),
         padding: EdgeInsets.zero,
         child: Container(
           height: MediaQuery.of(context).size.height,
           width: MediaQuery.of(context).size.width,
           margin: EdgeInsets.only(top: 124,left: 16,right: 16),
           child: Column(
             children: [
               CustomSectionComponent.Section(context: context,text: "التبرعات",margin: EdgeInsets.only(top: 0,left: 0,right: 0),seeMore: false),

               Container(
                 margin: EdgeInsets.only(top: 8),
                 width: MediaQuery.of(context).size.width,
                 child:Text("قم بالتبرع الان للجمعية،يمكنك التبرع الان للجمعية بطريقة امنة وسريعة ، ولن يتم تخزين اي معلومات متعلقة بمعلومات حسابك ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'SansArabicLight',color:Color(0xffB7B7B7)),),
               ),

               SingleChildScrollView(
                 child: BlocProvider(
                   create: (context) {

                     return DonationPageBloc()..add(DonationPageInitialEvent());
                   },
                   child: BlocListener<DonationPageBloc,DonationPageState>(
                     listener: (context,state){

                       if(state is DonationPageLoaded){

                         user = state.user;

                       }


                       if(state is DonationChangePrice) {

                         amount = state.price;
                       }

                       if(state is DonationPageInitial) {
                         if(Config.isShowingLoadingDialog == false) {
                           Config.isShowingLoadingDialog = true;
                           CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
                         }
                       }

                       if(state is DonationRequestApiLoaded){

                         if( Config.isShowingLoadingDialog == true) {
                           Config.isShowingLoadingDialog = false;
                           Navigator.of(context).pop();
                         }
                         if(state.responseCode == 200){
                           Navigator.of(context).pop();
                           var description = "شكرا لك على تبرعك لنا سيساعد هذا على تقديم المزيد من الدعم للناس";

                           CustomAlertDailog.CustomShowModalBottomSheetCompleatePayment(context: context,descriotion: description,onPressedClose: (){
                             Navigator.of(context).pop();
                           },onPressedHomePage: (){
                             Navigator.of(context).pop();
                           });
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

                       if(state is PaypalPaymentState){
                         if( Config.isShowingLoadingDialog == true) {
                           Config.isShowingLoadingDialog = false;
                           Navigator.of(context).pop();
                         }
                         CustomAlertDailog.PayPalShowModalBottomSheet(context: context,checkoutUrl:state.checkoutUrl,returnURL:state.returnURL,cancelURL: state.cancelURL,action: (){

                           context.read<DonationPageBloc>()..add(DonationPageRequestApiEvent("",4,"", amountText.text, user != null? user.name:"unkown","",nameCard.text,numberCard.text,expiryDate.text,cvv.text));

                         });
                       }

                       if(state is DonationPageErroe){
                         if( Config.isShowingLoadingDialog == true) {
                           Config.isShowingLoadingDialog = false;
                           Navigator.of(context).pop();
                         }
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
                     child: BlocBuilder<DonationPageBloc,DonationPageState>(
                       builder: (context,state){
                         return Container(
                           child: Column(
                             children: [

                               Container(
                                 margin: EdgeInsets.only(top: 32),

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

                                     CustomSectionComponent.Section(context: context,text: "تبرعات عامة",margin: EdgeInsets.only(top: 18,left: 16,right: 16),seeMore: false),


                                     Container(
                                       margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                                       child: Text("نوع التبرع: " + sector.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426))),
                                     ),

                                     Container(
                                       margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                                       child: Text("المبلغ المدفوع: " +amount.toString()+" "+ "شيقل",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426))),
                                     ),

                                     Container(
                                       child: CustomTextField.TextFieldWithTitleAndBorder(controller: amountText,width: MediaQuery.of(context).size.width-50,margin: EdgeInsets.only(left: 16,right: 16,top: 24),title: "قيمة المبلغ المدفوع",hintText: "الرجاء ادخال قيمة التبرع",obscureText: false,textAlign: TextAlign.start,keyboardType: TextInputType.number,onChanged: (text){

                                         context.read<DonationPageBloc>()..add(DonationPageTextEditionTotalAmountEvent(amountText.text));

                                       }),
                                     ),


                                     Container(
                                       width: MediaQuery.of(context).size.width,
                                       margin: EdgeInsets.only(top: 42,bottom: 32,left: 16,right: 16),
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
                                               child: Text("متابعة",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                                               onPressed: (){
                                                 // CustomAlertDailog.CustomShowModalBottomSheetPaymentMethod(context: context);
                                                 CustomAlertDailog.CustomShowModalBottomSheet(context: context,nameCard: nameCard,numberCard: numberCard,expiryDate: expiryDate,cvv: cvv,onPressedCompleated: (singingCharacter){
                                                  if(singingCharacter == SingingCharacter.paybal){
                                                    context.read<DonationPageBloc>().add(PaypalPaymentEvent("مشاريع عامة",amountText.text,""));
                                                    Navigator.of(context).pop();
                                                  } else {
                                                    if(nameCard.text.isNotEmpty && numberCard.text.isNotEmpty && expiryDate.text.isNotEmpty && cvv.text.isNotEmpty) {

                                                      context.read<DonationPageBloc>().add(DonationPageRequestApiEvent("",4,"", amountText.text, user != null? user.name:"unkown","",nameCard.text,numberCard.text,expiryDate.text,cvv.text));
                                                    } else {
                                                      if( Config.isShowingLoadingDialog == false) {
                                                        Config.isShowingLoadingDialog = true;
                                                        CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message:"يجب ملئ جميع الحقول", type:3, height: 117.0);
                                                        Timer(Duration(seconds: 2),(){
                                                          if(Config.isShowingLoadingDialog == true) {
                                                            Config.isShowingLoadingDialog = false;
                                                            Navigator.of(context).pop();
                                                          }
                                                        });}
                                                    }
                                                  }



                                                 });

                                               },
                                             ),
                                           ),

                                         ],
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
               )
               // Container(
               //   width: (MediaQuery.of(context).size.width),
               //   height: 48,
               //   margin: EdgeInsets.only(top: 50),
               //   decoration: BoxDecoration(
               //       color: Theme.of(context).primaryColor,
               //       borderRadius: BorderRadius.circular(50),
               //       boxShadow: [
               //         BoxShadow(
               //             color: Color(0xff312E2E).withOpacity(0.16),
               //             offset: Offset(0,3),
               //             blurRadius: 6
               //         )
               //       ]
               //   ),
               //   child: MaterialButton(
               //     height: 48,
               //     shape: RoundedRectangleBorder(
               //         borderRadius: BorderRadius.circular(50)
               //     ),
               //     child: Text("تبرعات للحافلات",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
               //     onPressed: (){
               //
               //     },
               //   ),
               // ),
               // Container(
               //   width: (MediaQuery.of(context).size.width),
               //   height: 48,
               //   margin: EdgeInsets.only(top: 16),
               //   decoration: BoxDecoration(
               //       color: Theme.of(context).primaryColor,
               //       borderRadius: BorderRadius.circular(50),
               //       boxShadow: [
               //         BoxShadow(
               //             color: Color(0xff312E2E).withOpacity(0.16),
               //             offset: Offset(0,3),
               //             blurRadius: 6
               //         )
               //       ]
               //   ),
               //   child: MaterialButton(
               //     height: 48,
               //     shape: RoundedRectangleBorder(
               //         borderRadius: BorderRadius.circular(50)
               //     ),
               //     child: Text("تبرعات للمشاريع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
               //     onPressed: (){
               //
               //     },
               //   ),
               // ),
               // Container(
               //   width: (MediaQuery.of(context).size.width),
               //   height: 48,
               //   margin: EdgeInsets.only(top: 16),
               //   decoration: BoxDecoration(
               //       color: Theme.of(context).primaryColor,
               //       borderRadius: BorderRadius.circular(50),
               //       boxShadow: [
               //         BoxShadow(
               //             color: Color(0xff312E2E).withOpacity(0.16),
               //             offset: Offset(0,3),
               //             blurRadius: 6
               //         )
               //       ]
               //   ),
               //   child: MaterialButton(
               //     height: 48,
               //     shape: RoundedRectangleBorder(
               //         borderRadius: BorderRadius.circular(50)
               //     ),
               //     child: Text("تبرعات للحصالة",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
               //     onPressed: (){
               //
               //     },
               //   ),
               // ),
               // Container(
               //   width: (MediaQuery.of(context).size.width),
               //   height: 48,
               //   margin: EdgeInsets.only(top: 16),
               //   decoration: BoxDecoration(
               //       color: Theme.of(context).primaryColor,
               //       borderRadius: BorderRadius.circular(50),
               //       boxShadow: [
               //         BoxShadow(
               //             color: Color(0xff312E2E).withOpacity(0.16),
               //             offset: Offset(0,3),
               //             blurRadius: 6
               //         )
               //       ]
               //   ),
               //   child: MaterialButton(
               //     height: 48,
               //     shape: RoundedRectangleBorder(
               //         borderRadius: BorderRadius.circular(50)
               //     ),
               //     child: Text("تبرعات أخرى",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
               //     onPressed: (){
               //       // Navigator.of(context).push(MainPage());
               //     },
               //   ),
               // ),

             ],
           ),
         ),
       ),
     );
  }

}