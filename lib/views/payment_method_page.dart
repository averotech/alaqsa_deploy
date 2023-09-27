import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/composite_text.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class PaymentMethodPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return StatePaymentMethodPage();
  }

}

class StatePaymentMethodPage extends State<PaymentMethodPage> {



  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         child: Column(
           children: [
             Container(
               width: MediaQuery.of(context).size.width,
               height: 94,
               child: CustomNavBar.customNaveBar(context: context,title: "الدفع"),
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
                     margin: EdgeInsets.only(top: 18,left: 16,right: 16),
                     // width: MediaQuery.of(context).size.width,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           width: MediaQuery.of(context).size.width/2,
                           child: CustomSectionComponent.Section(context: context,text: "طرق الدفع",margin: EdgeInsets.only(top: 0,left: 0,right: 0),seeMore: false),
                         ),
                         Container(

                           child: TextButton(

                             style: ButtonStyle(padding:MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
                             child: Text("أضافة",style:TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.2)),
                             onPressed: (){


                               // CustomAlertDailog.CustomShowModalBottomSheet(context: context);
                             },
                           ),
                         )
                       ],
                     ),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height/1.57,
                     margin: EdgeInsets.only(top: 24),
                     child: CustomListView.ListPaymentMethod(context:context,bottom: 32.0,onPressed: (){}),
                   )

                 ],
               ),
             )
           ],
         ),
       ),
     );
  }



}