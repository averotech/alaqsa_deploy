import 'package:alaqsa/bloc/settings/settings_bloc.dart';
import 'package:alaqsa/bloc/settings/settings_event.dart';
import 'package:alaqsa/bloc/settings/settings_state.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateSettingPage();
  }

}

class StateSettingPage extends State<SettingPage> {
  var isSwitchedNotificatioMopile = false;
  var isSwitchedNotificatioPhoneNumber = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SettingsBloc()..add(GlobalSettingEvent()),
        child: BlocListener<SettingsBloc,SettingsState>(
          listener: (context,state){
            if(state is GlobalSettingLoaded) {
              isSwitchedNotificatioMopile = state.avtiveNotfiaction;
              isSwitchedNotificatioPhoneNumber = state.avtiveSms;
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
                      child: CustomNavBar.customNaveBar(context: context,title: "الأعدادات"),
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
                            child: Text("يمكنك التحكم بإعدادات التطبيق من هنا",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/13,
                            margin: EdgeInsets.only(top: 14,left: 16,right: 16),
                            child: Divider(
                              color: Theme.of(context).primaryColor,
                              thickness: 3,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 14,right: 14,top: 16),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("ارسال الأشعارات عن الرحلات القريبة منك",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                ),
                                Container(
                                  child: Switch(
                                    value: isSwitchedNotificatioMopile,
                                    onChanged: (isSwitch){

                                      context.read<SettingsBloc>()..add(GlobalSettingOnClickEvent(isSwitch, isSwitchedNotificatioPhoneNumber));

                                    },
                                    activeColor: Color(0xff4CD964,),


                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 14,right: 14,top: 16,bottom: 100),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text("ارسال الأشعارات الى رقم الهاتف",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                                ),
                                Container(
                                  child: Switch(
                                    value: isSwitchedNotificatioPhoneNumber,
                                    onChanged: (isSwitch){
                                      context.read<SettingsBloc>()..add(GlobalSettingOnClickEvent(isSwitchedNotificatioMopile, isSwitch));

                                    },
                                    activeColor: Color(0xff4CD964,),


                                  ),
                                )
                              ],
                            ),
                          )
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
