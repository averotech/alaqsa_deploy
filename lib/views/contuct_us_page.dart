import 'package:alaqsa/bloc/settings/settings_bloc.dart';
import 'package:alaqsa/bloc/settings/settings_event.dart';
import 'package:alaqsa/bloc/settings/settings_state.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContuctUsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateContuctUsPage();
  }

}

class StateContuctUsPage extends State<ContuctUsPage> {
   var contactUs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context)=>SettingsBloc()..add(ContactUsEvent()),
        child: BlocListener<SettingsBloc,SettingsState>(
          listener: (context,state){
            if(state is ContactUSLoaded){
              contactUs = state.contactUs;
            }
          },
          child: BlocBuilder<SettingsBloc,SettingsState>(
            builder: (context,state){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 94,
                      child: CustomNavBar.customNaveBar(context: context,title: "توصل معنا"),
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
                            margin: EdgeInsets.only(left: 14,right: 14,top: 18),
                            child: Text("تواصل معنا بشكل افضل",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/13,
                            margin: EdgeInsets.only(top: 14,left: 16,right: 16),
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 3,
                            ),
                          ),

                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 24,left: 16,right: 16),icon: 'assets/icons/iphone.svg',text: '${contactUs != null? contactUs["phone"]:""}',onPressed: (){
                            final Uri uriPhone = Uri(
                              scheme: 'tel',
                              path: contactUs["phone"].toString(),
                            );
                            if(contactUs != null) {
                              Config.launchURL(uri: uriPhone);
                            }
                          }),
                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,left: 16,right: 16),icon: 'assets/icons/mail.svg',text: '${contactUs != null? contactUs["email"]:""}',onPressed: (){
                            String? encodeQueryParameters(Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: contactUs["email"],
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Contact Us',
                              }),
                            );

                            if(contactUs != null) {
                              Config.launchURL(uri: emailLaunchUri);
                            }

                          }),
                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,left: 16,right: 16),icon: 'assets/icons/web.svg',text: '${contactUs != null? contactUs["web_url"]:""}',onPressed: (){
                            if(contactUs != null) {
                              Config.launchURL(uri: Uri.parse(contactUs["web_url"]));
                            }
                          }),
                          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 16,bottom: 100,left: 16,right: 16),icon: 'assets/icons/location.svg',text: '${contactUs != null? contactUs["location"].toString().length > 35?contactUs["location"].toString().substring(0,35)+'...':contactUs["location"].toString():""}',onPressed: (){}),

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
