import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class NewPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateNewPassword();
  }

}

class StateNewPassword extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Stack(
         children: [
           Positioned(
               top: 0,
               child: Container(
                 height: MediaQuery.of(context).size.height,
                 width: MediaQuery.of(context).size.width,
                 child: Image.asset("assets/images/backgound.png",fit: BoxFit.cover,),
               )
           ),
           Positioned(
             top: 0,
             left: 0,
             right: 0,
             child: Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height,
               margin: EdgeInsets.only(left: 16,right: 16),
               child: SingleChildScrollView(
                   padding: EdgeInsets.zero,

                   child:Column(

                 children: [
                   Container(
                     margin: const EdgeInsets.only(top: 40,left: 8),
                     alignment: Alignment.centerLeft,
                     child:  TextButton(
                       child: const Text("تخطي",style: TextStyle(color: Colors.white,fontFamily: 'SansArabicLight',fontSize: 16,fontWeight: FontWeight.w600),),
                       onPressed: (){
                         Navigator.of(context).pushNamed("MainPage");
                       },
                     ),
                   ),
                   Container(

                     margin: const EdgeInsets.only(top: 50),
                     child: Image.asset("assets/images/iconApp.png"),
                   ),
                   CustomTextField.TextFieldWithTitle(title: "كلمة المرور الجديدة ",hintText:"كلمة المرور الجديدة",obscureText: true ,borderColor: Colors.white,margin: EdgeInsets.only(top: 45,left: 0,right: 0)),
                   CustomTextField.TextFieldWithTitle(title: "تأكيد كلمة المرور الجديدة",hintText:"تأكيد كلمة المرور الجديدة " ,obscureText: true,borderColor: Colors.white,margin: EdgeInsets.only(top: 16,left: 0,right: 0)),


                   CustomButton.customButton1(context: context,visibleIcon: false,textButton: "تغيير كلمة المرور",iconButton:"",top: 33.0,bottom: 0.0,onPressed: (){
                     Navigator.of(context).pushNamed("MainPage");
                   }),



                 ],
               )),
             ),
           ),


         ],
       ),
     );
  }

}