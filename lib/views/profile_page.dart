import 'dart:async';

import 'package:alaqsa/bloc/user_profile/user_profile_bloc.dart';
import 'package:alaqsa/bloc/user_profile/user_profile_event.dart';
import 'package:alaqsa/bloc/user_profile/user_profile_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/composite_text.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/components/custom_listview.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/user.dart';
import 'package:alaqsa/models/user_profile.dart';
import 'package:alaqsa/models/volunteer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
     return StateProfilePage();
  }

}

class StateProfilePage extends State<ProfilePage> {

  TextEditingController name = new TextEditingController();
  TextEditingController numberPhone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController locations = new TextEditingController();
  PageController controller = new PageController(initialPage: 0);
  GlobalState globalState = GlobalState.instance;
  var currentPageValue = 0.0;

  var clickData = true;
  var clickDonations = false;
  var clickProjects = false;
  var isLoaded = false;
  var isLoadedError = false;

  var pageViewItem = [];

  var height = 300.0;

  UserProfileBloc userProfileBloc = UserProfileBloc();

  @override
  void initState() {

    controller.addListener(() {
      setState(() {

        currentPageValue = controller.page!;
        setState((){
          if(currentPageValue == 0){
            clickData = true;
            clickDonations = false;
            clickProjects = false;
          }
          if(currentPageValue == 1){
            clickData = false;
            clickDonations = true;
            clickProjects = false;
          }
          if(currentPageValue == 2){
            clickData = false;
            clickDonations = false;
            clickProjects = true;
          }
        });
      });
    });
  }
  actionRemoveAccount() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: BlocProvider(
         create: (context) => userProfileBloc ..add(UserProfileApiEvent()),
         child: BlocListener<UserProfileBloc,UserProfileState>(
           listener: (context,state){

             if(state is UserProfileInitial){
                isLoaded = false;
                isLoadedError = false;
               if(Config.isShowingLoadingDialog == false) {
                 Config.isShowingLoadingDialog = true;
                 CustomAlertDailog.CustomLoadingDialog(context: context,color: Theme.of(context).primaryColor,size: 35.0,message:"الرجاء الأنتظار",type: 1,height: 96.0);
               }
             }
             if(state is UserProfileLoaded){
               isLoaded = true;
               name.text=state.userProfile.user.name;
               numberPhone.text= state.userProfile.user.phone == ""? "":state.userProfile.user.phone;
               email.text=state.userProfile.user.email;
               pageViewItem = [InformationAccountPages(state.userProfile.user),ProfileDonationsPage(state.userProfile.myDonationes),ProfileProjectsPage(state.userProfile.myVolunteers)];
               if(Config.isShowingLoadingDialog == true) {
                 Config.isShowingLoadingDialog = false;
                 Navigator.of(context).pop();
               }
             }

             if(state is RemoveAccountUserLoaded){

               if(Config.isShowingLoadingDialog == true) {
                 Config.isShowingLoadingDialog = false;
                 Navigator.of(context).pop();
               }
               actionRemoveAccount();
             }
             if(state is UserProfileError) {
               print(state.error);
               isLoadedError = true;
               if(Config.isShowingLoadingDialog == true) {
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
           child: BlocBuilder<UserProfileBloc,UserProfileState>(
             builder: (context,state){

                if(state is UserProfileLoaded){
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 94,
                          child: CustomNavBar.customNaveBar(context: context,title: "الملف الشخصي"),
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
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 24,left: 12,right: 12,bottom: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width/3)-21,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: clickData?Theme.of(context).primaryColor:Colors.white,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: MaterialButton(
                                        height: 42,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Text("البيانات",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:clickData?Colors.white:Color(0xff101426),height: 1.4),),
                                        onPressed: (){
                                          this.controller.animateToPage(0,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                          setState((){
                                            clickData = true;
                                            clickDonations = false;
                                            clickProjects = false;
                                          });

                                        },
                                      ),
                                    ),

                                    Container(
                                      width: (MediaQuery.of(context).size.width/3)-21,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: clickDonations?Theme.of(context).primaryColor:Colors.white,
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: MaterialButton(
                                        height: 42,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50)
                                        ),
                                        child: Text("تبرع الان",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:clickDonations?Colors.white:Color(0xff101426),height: 1.4),),
                                        onPressed: (){
                                          this.controller.animateToPage(1,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                          setState((){
                                            clickData = false;
                                            clickDonations = true;
                                            clickProjects = false;
                                          });

                                        },
                                      ),
                                    ),

                                    // Container(
                                    //   width: (MediaQuery.of(context).size.width/3)-21,
                                    //   height: 42,
                                    //   decoration: BoxDecoration(
                                    //       color: clickProjects?Theme.of(context).primaryColor:Colors.white,
                                    //       borderRadius: BorderRadius.circular(50)
                                    //   ),
                                    //   child: MaterialButton(
                                    //     height: 42,
                                    //     shape: RoundedRectangleBorder(
                                    //         borderRadius: BorderRadius.circular(50)
                                    //     ),
                                    //     child: Text("المشاريع",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:clickProjects?Colors.white:Color(0xff101426),height: 1.4),),
                                    //     onPressed: (){
                                    //       this.controller.animateToPage(2,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                    //       setState((){
                                    //         clickData = false;
                                    //         clickDonations = false;
                                    //         clickProjects = true;
                                    //       });
                                    //
                                    //     },
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/1.38,
                                child:PageView.builder(
                                    itemCount: pageViewItem.length,
                                    scrollDirection: Axis.horizontal,
                                    controller: controller,


                                    itemBuilder: (context, index) {
                                      return Transform(
                                        transform: Matrix4.identity()
                                          ..rotateX(currentPageValue - index),
                                        child:  ListView(
                                          padding: EdgeInsets.only(top: 1,bottom: 32),
                                          children: [
                                            pageViewItem[index],

                                            CustomSectionComponent.Section(context: context,text: "الأحصائيات",margin: EdgeInsets.only(top: 24,left: 16,right: 16),seeMore: false),

                                            Container(
                                              margin: EdgeInsets.only(top: 16,left: 24,right: 24),
                                              alignment: Alignment.center,
                                              child: GridView.count(

                                                primary: false,
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 10,
                                                childAspectRatio: 0.84,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                children: [
                                                  CompositeText.statisticsItem(context: context,icon: "assets/icons/tour-bus.svg",title: "عدد الرحلات",statistics: state.userProfile.tripCount),
                                                  CompositeText.statisticsItem(context: context,icon: "assets/icons/donation.svg",title: "عدد التبرعات",statistics: state.userProfile.donationCount),
                                                  CompositeText.statisticsItem(context: context,icon: "assets/icons/hands-up.svg",title: "عدد التطوعات",statistics: state.userProfile.volunteerCount),

                                                ],
                                              ),
                                            )

                                          ],
                                        ),
                                      );
                                    }),
                              ),


                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(

                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 94,
                          child: CustomNavBar.customNaveBar(context: context,title: "الملف الشخصي"),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height-200,
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

                          child: isLoadedError?Container(
                              width: MediaQuery.of(context).size.width,

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/icons/error_icon.svg"),
                                  Container(
                                    margin: EdgeInsets.only(top: 14),
                                    child:Text("يوجد خطأ يرجى المحاولة مرة أخرى",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
                                  )
                                ],
                              )
                          ):Container(),
                        )
                      ],
                    ),
                  );

                }

             },
           ),
         ),
       ),
     );
  }

  Widget InformationAccountPages(User user){
    return Container(

      child:Column(
        children: [
          CustomTextField.TextFieldWithIcon(controller: name,hintText: "",obscureText: false,margin: EdgeInsets.only(top: 6,left: 16,right: 16),icon: "assets/icons/account.svg"),
          CustomTextField.TextFieldWithIcon(controller: numberPhone,hintText: numberPhone.text==""?"لا يتوفر رقم الهاتف":"",obscureText: false,margin: EdgeInsets.only(top: 12,left: 16,right: 16),icon: "assets/icons/iphone.svg",colorHintText: Color(0xffB7B7B7)),
          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 12,bottom: 0,left: 16,right: 16),icon: 'assets/icons/mail.svg',paddingIcon: 5.0,paddingButton: 6.0,text: user.email,textColor: Color(0xffB7B7B7),onPressed: ()async{

          }),
          CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 12,bottom: 0,left: 16,right: 16),icon: 'assets/icons/location.svg',paddingIcon: 5.0,paddingButton: 6.0,text: globalState.get("myAddress")??"غير معروف",textColor: Color(0xffB7B7B7),onPressed: (){}),
          Container(

            child: CustomButton.buttonIconWithText(mainAxisAlignment: MainAxisAlignment.center,margin: EdgeInsets.only(top: 12,left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/trash.svg",title: "حذف الحساب",onPressed: () async{
              CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد حذف الحساب؟",textButton1: "نعم",textButton2: "لا",onClick1: () async{
                Navigator.of(context).pop();
                CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل أنت متأكد من حذف الحساب؟",textButton1: "نعم",textButton2: "لا",onClick1: () async{
                  Navigator.of(context).pop();
                  CustomAlertDailog.CustomActionDialog(context: context,titelText: "سيتم حذف الحساب الان نهائيا!",textButton1: "نعم",textButton2: "لا",onClick1: () async{
                    Navigator.of(context).pop();
                    userProfileBloc..add(RemoveAccountUserEvent());

                  },onClick2: (){
                    Navigator.of(context).pop();
                  });

                },onClick2: (){
                  Navigator.of(context).pop();
                });


              },onClick2: (){
                Navigator.of(context).pop();
              });

            }),
          )
          // CustomButton.borderButtonIconWithText(height: 42.0,margin:EdgeInsets.only(top: 12,bottom: 0,left: 16,right: 16),icon: 'assets/icons/wallet.svg',paddingIcon: 5.0,paddingButton: 6.0,text: 'طرق الدفع',textColor: Color(0xffB7B7B7),onPressed: (){
          //  print("owais");
          //   Navigator.of(context).pushNamed("PaymentMethodPage");
          // }),

        ],
      ),
    );
  }
  Widget ProfileDonationsPage(List<Donatione> donations){

    if(donations.isNotEmpty){
      return CustomListView.ListProfileDonations(donations);
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 16,left: 16,right: 16),
        child: Column(
          children: [
            SvgPicture.asset("assets/icons/no_data.svg"),

            Container(
              margin: EdgeInsets.only(top: 14),
              child:Text("لا يوجد تبرعات لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
            )
          ],
        )
      );
    }
  }


  Widget ProfileProjectsPage(List<Volunteer>myVolunteers){
    if(myVolunteers.isNotEmpty){
      return CustomListView.ListProfileProjects(myVolunteers);
    } else {
      return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 16,left: 16,right: 16),
          child: Column(
            children: [
              SvgPicture.asset("assets/icons/no_data.svg"),
              Container(
                margin: EdgeInsets.only(top: 14),
                child:Text("لا يوجد تطوعات لعرضها",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
              )
            ],
          )
      );
    }

  }


}