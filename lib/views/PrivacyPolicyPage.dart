import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/custom_nav_bar.dart';


class PrivacyPolicy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return statePrivacyPolicy();
  }
}

class statePrivacyPolicy extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 94,
              child: CustomNavBar.customNaveBar(context: context,title: "سياسة الخصوصيه"),
            ),
            Container(
              margin: EdgeInsets.only(top: 32,left: 16,right: 16),
              width: MediaQuery.of(context).size.width,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 14,right: 14,top: 32),
                    child: Text("سياسة الخصوصية لتطبيق الاقصى",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                  ),
                  SizedBox(height: 12.0),
                  SizedBox(height: 20.0),
                  Text(
                    'مقدمة',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'نحن في تطبيق جمعية الاقصى نلتزم بحماية خصوصية معلومات مستخدمي تطبيقنا. نحن نفهم أهمية البيانات الشخصية التي تشاركونها معنا ونسعى جاهدين للحفاظ على سرية هذه المعلومات واستخدامها بشكل آمن.',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'اتصال',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'إذا كانت لديك أية أسئلة أو استفسارات بخصوص سياسة الخصوصية لتطبيقنا ، يُرجى التواصل معنا على العنوان التالي:',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    'alaqsaquds@gmail.com',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blue, // Add a hyperlink style.
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }

}