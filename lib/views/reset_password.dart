import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/CustomAlertDailog.dart';


class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateResetPassword();
  }

}

class StateResetPassword extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  Future<void> resetPassword(String email) async {
    final url = Uri.parse('https://aqsana.org/api/reset_password_request'); // Replace with your API endpoint
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("تم الارسال "),
            content: Text("تم ارسال رابط استعادة كلمة المرور الى بريدك الالكتروني"),
            actions: [
              TextButton(
                child: Text("موافق"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      print('Password reset failed: ${response.statusCode}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("خطأ"),
            content: Text("فشل في ارسال الرابط. الرجاء التاكد من الايميل المدخل."),
            actions: [
              TextButton(
                child: Text("موافق"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
                      CustomTextField.TextFieldWithTitle(controller: email,title: "البريد الالكتروني ",hintText:"البريد الالكتروني " ,obscureText: false,borderColor: Colors.white,margin: EdgeInsets.only(top: 45,left: 0,right: 0)),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 16),
                        child: Text("سوف يتم ارسال رمز الى حسابك يرجى التحقق منه",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: "SansArabicLight",fontWeight: FontWeight.w500),),
                      ),
                      CustomButton.customButton1(context: context,visibleIcon: false,textButton: "استعادة كلمة المرور",iconButton:"",top: 16.0,bottom: 0.0,onPressed: (){
                        // Navigator.of(context).pushNamed("MainPage");
                        resetPassword(email.text.toString());
                        // CustomAlertDailog.CustomLoadingDialog(context:context, color:Colors.red, size:35.0, message:"الايميل او كلمة السر غير صحيحات", type:3, height: 117.0);

                      }),



                    ],
                  )),
            ),
          ),
          Positioned(
            bottom: 60,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(

                  child: TextButton(

                    child: Text("لا تمتلك حساب؟ أنشئء الان",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "SansArabicLight",fontWeight: FontWeight.w600),),
                    onPressed: (){
                      Navigator.of(context).pushNamed("RegisterPage");
                    },
                  ),
                ),
              )
          )

        ],
      ),
    );
  }

}