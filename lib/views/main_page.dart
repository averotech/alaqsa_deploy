
import 'package:alaqsa/bloc/main_page/main_page_bloc.dart';
import 'package:alaqsa/bloc/main_page/main_page_event.dart';
import 'package:alaqsa/bloc/main_page/main_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/views/donations_page.dart';
import 'package:alaqsa/views/home_page.dart';
import 'package:alaqsa/views/news_page.dart';
import 'package:alaqsa/views/projects_page.dart';
import 'package:alaqsa/views/trip_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return StateMainPage();
  }

}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin  = new FlutterLocalNotificationsPlugin();
var channel = AndroidNotificationChannel(
  'WSL', // id
  'WSL', // title
  description:"WSL Notifications",
  importance: Importance.max,
  playSound: true,
  showBadge: true,
  sound: RawResourceAndroidNotificationSound("f_l_n_s"),
);


Future<void> initialize() async {
  var  initializationSettingsAndroid = new AndroidInitializationSettings('wslappnotify');
  var initializationSettingsIOS = new DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification:StateMainPage().onDidReceiveLocalNotification);

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );

  var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

}


// Future<void> _firebaseMessagingBackgroundHandler(message) async {

  // await Firebase.initializeApp();
  // StateMainPage().showNotification(message);
  // print('A bg message just showed up :  ${message.messageId}');
// }


class StateMainPage extends State<MainPage> {
  GlobalKey<ScaffoldState> mainScaffoldKey =  GlobalKey<ScaffoldState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  var homePage = true;
  var newsPage = false;
  var projectsPage = false;
  var tripPage = false;
  var donationsPage = false;
  var pageViewItem = [NewsPage(),ProjectsPage(),HomePage(),TripPage(),DonationsPage()];
  PageController controller =  PageController(initialPage: 2);
  var currentPageValue = 0.0;
  var user;
  var isLogin = false;
  var socialMedia = [];
  var indexPage = 2;
  MainPageBloc mainPageBloc = MainPageBloc();


  getPage(){
    if(homePage == true){
      return HomePage();
    }

    if(newsPage == true){
      return NewsPage();
    }

    if(projectsPage == true){
      return ProjectsPage();
    }

    if(tripPage == true){
      return TripPage();
    }
    if(donationsPage == true){
      return DonationsPage();
    }

  }


  //Start Notifications

  Future onDidReceiveLocalNotification(var id, var title, var body, var payload) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future onSelectNotification(var payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => HomePage()),
    );
  }

  showNotification(RemoteMessage message) async{

    var data = message.data;

    InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
      [message.notification!.body.toString()],
      contentTitle: message.notification!.title.toString(),
    );



    AndroidNotificationDetails androidPlatformChannelSpecifics = new AndroidNotificationDetails(channel.id,channel.name,channelDescription:channel.description,
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'WSL',
      channelShowBadge: true,
      showWhen: true,
      enableLights: true,
      playSound: true,
      icon: '@drawable/wslappnotify',
      styleInformation: inboxStyleInformation,
      groupKey: channel.id,
      setAsGroupSummary: true,
      sound: RawResourceAndroidNotificationSound("f_l_n_s"),
    );




    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        message.notification.hashCode, message.notification!.title.toString(), message.notification!.body.toString(), platformChannelSpecifics,
        payload: '');

  }

  @override
  void didChangeDependencies() {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (controller.hasClients)
        controller.jumpToPage(2);

    });

    super.didChangeDependencies();
  }


  @override
  void initState() {

    super.initState();

    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page!;
      });
    });
    WidgetsFlutterBinding.ensureInitialized();

    // setupNotfication();


  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       key: mainScaffoldKey,
       resizeToAvoidBottomInset: false,
       body: Container(

         child: BlocProvider(
           create: (context) => mainPageBloc ..add(MainPageInitialEvent()),
           child: BlocListener<MainPageBloc,MainPageState>(
             listener: (context,state){

               if (state is MainPageLoaded) {
                 setState(() {
                   user = state.user;
                   isLogin = state.isLogin;
                   // print('MainPageLoaded: User: ${user.name}, isLogin: $isLogin');
                 });
               }else if (state is MainPageError) {
                 setState(() {
                   isLogin = state.isLogin ?? false;
                 });
               }
               if(state is MainPageSocialMediaLoaded) {
                 socialMedia = state.socialMedia;
               }
             },
             child: BlocBuilder<MainPageBloc,MainPageState>(
               builder: (context,state){
                 return Stack(

                   children: [
                     // Content
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: indexPage == 0 ?NewsPage():
                          (indexPage == 1)? ProjectsPage()
                          :(indexPage == 2)?HomePage()
                          :(indexPage == 3)?TripPage()
                          :(indexPage == 4)?DonationsPage():Container()

                     ),
                     // getPage(),
                     // End Content

                     //Top Nav Bar
                     Positioned(
                       top: 0,
                       child: Container(
                         margin: EdgeInsets.only(top: 55,left: 16,right: 16,bottom: 24),

                         width: MediaQuery.of(context).size.width-32,

                         alignment: Alignment.center,
                         child: Stack(
                           alignment: Alignment.center,
                           children: [

                             Positioned(right: 0,child:
                             GestureDetector(child:Container(

                               child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(

                                     child: SvgPicture.asset("assets/icons/account.svg",height: 16,width: 16,),
                                   ),
                                   Container(
                                       margin: EdgeInsets.only(left: 8,right: 8),
                                       child:Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           Container(
                                             child: Text("مرحبا",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor)),
                                           ),
                                           Visibility(visible: !isLogin ,child:Container(
                                             height: 24,

                                             child: MaterialButton(
                                               padding: EdgeInsets.zero,
                                               child: Text("تسجيل الدخول",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color: Color(0xffB7B7B7)),),
                                               onPressed: () async{
                                                 if(await Config.checkLogin() == true){
                                                   Navigator.of(context).pushNamed("ProfilePage");
                                                 } else{
                                                   Navigator.of(context).pushNamed("LoginPage");
                                                 }
                                               },
                                             ),
                                           )),

                                          Visibility(visible: isLogin,child:Container(
                                             height: 24,
                                             margin: EdgeInsets.only(top: 2),
                                             child: GestureDetector(
                                               child: Text((user != null ? user.name : ""),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color: Color(0xff101426)),textAlign: TextAlign.start,),
                                               onTap: (){
                                                 Navigator.of(context).pushNamed("ProfilePage");
                                               },
                                             ),
                                           )),

                                         ],
                                       )),

                                 ],
                               ),
                             ),
                               onTap: (){
                               if(isLogin) {
                                 Navigator.of(context).pushNamed("ProfilePage");
                               }

                               },
                             )
                             ),
                             Center(

                               child: Image.asset("assets/images/MainIcon.png",width: 54,height: 51,),
                             ),
                             Positioned(left: 0,child:Container(
                               height: 24,
                               width: 24,
                               child: IconButton(

                                 padding: EdgeInsets.zero,
                                 icon: SvgPicture.asset("assets/icons/menu.svg",width: 24,height: 24,),
                                 onPressed: (){

                                   mainScaffoldKey.currentState?.openEndDrawer();
                                 },
                               ),
                             )),


                           ],
                         ),
                       ),),

                     //Button Nav Bar
                     Positioned(bottom: 0,
                         child: Container(
                           color: Colors.white,
                           width: MediaQuery.of(context).size.width,
                           padding: EdgeInsets.only(top: 16,bottom: 16),
                           child: Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               CustomButton.buttonNavBar(context: context,icon: "assets/icons/news.svg",backGoundColor: newsPage?Theme.of(context).primaryColor:Color(0xffE4FFE5),colorIcon: newsPage?Colors.white:Theme.of(context).primaryColor,text: "الأخبار",textColor: newsPage?Theme.of(context).primaryColor:Color(0xffB7B7B7),onPressed: (){
                                 // controller.animateToPage(0,duration: const Duration(milliseconds: 400), curve: Curves.linear);
                                 // controller.jumpToPage(0);
                                 indexPage = 0;
                                 setState((){

                                   newsPage = true;
                                   homePage = false;
                                   projectsPage = false;
                                   tripPage = false;
                                   donationsPage = false;
                                 });
                               }),
                               CustomButton.buttonNavBar(context: context,icon: "assets/icons/project.svg",backGoundColor: projectsPage?Theme.of(context).primaryColor:Color(0xffE4FFE5),colorIcon: projectsPage?Colors.white:Theme.of(context).primaryColor,text: "المشاريع",textColor: projectsPage?Theme.of(context).primaryColor:Color(0xffB7B7B7),onPressed: (){
                                 // controller.animateToPage(1,duration: const Duration(milliseconds: 400), curve: Curves.linear);
                                 // controller.jumpToPage(1);
                                 indexPage = 1;
                                 setState((){

                                   newsPage = false;
                                   homePage = false;
                                   projectsPage = true;
                                   tripPage = false;
                                   donationsPage = false;
                                 });

                               }),
                               CustomButton.buttonNavBar(context: context,icon: "assets/icons/home.svg",backGoundColor: homePage?Theme.of(context).primaryColor:Color(0xffE4FFE5),colorIcon: homePage?Colors.white:Theme.of(context).primaryColor,text: "الرئيسية",textColor: homePage?Theme.of(context).primaryColor:Color(0xffB7B7B7),onPressed: (){
                                 // controller.animateToPage(2,duration: const Duration(milliseconds: 400), curve: Curves.linear);
                                 // controller.jumpToPage(2);
                                 indexPage = 2;
                                 setState((){

                                   newsPage = false;
                                   homePage = true;
                                   projectsPage = false;
                                   tripPage = false;
                                   donationsPage = false;
                                 });

                               }),
                               CustomButton.buttonNavBar(context: context,icon: "assets/icons/tour-bus.svg",backGoundColor: tripPage?Theme.of(context).primaryColor:Color(0xffE4FFE5),colorIcon: tripPage?Colors.white:Theme.of(context).primaryColor,text: "الرحلات",textColor: tripPage?Theme.of(context).primaryColor:Color(0xffB7B7B7),onPressed: (){
                                 // controller.animateToPage(3,duration: const Duration(milliseconds: 400), curve: Curves.linear);
                                 // controller.jumpToPage(3);
                                 indexPage = 3;
                                 setState((){

                                   newsPage = false;
                                   homePage = false;
                                   projectsPage = false;
                                   tripPage = true;
                                   donationsPage = false;
                                 });

                               }),
                               // Todo Modify Donation Page from NavBar
                               // CustomButton.buttonNavBar(context: context,icon: "assets/icons/donation.svg",backGoundColor: donationsPage?Theme.of(context).primaryColor:Color(0xffE4FFE5),colorIcon: donationsPage?Colors.white:Theme.of(context).primaryColor,text: "التبرعات",textColor: donationsPage?Theme.of(context).primaryColor:Color(0xffB7B7B7),onPressed: (){
                               //   // controller.animateToPage(4,duration: const Duration(milliseconds: 400), curve: Curves.linear);
                               //   // controller.jumpToPage(4);
                               //   indexPage = 4;
                               //   setState((){
                               //     currentPageValue = 4.0;
                               //     newsPage = false;
                               //     homePage = false;
                               //     projectsPage = false;
                               //     tripPage = false;
                               //     donationsPage = true;
                               //   });
                               //
                               // }),
                             ],
                           ),
                         )
                     )
                   ],
                 );
               },
             ),
           ),
         ),
       ),
       endDrawer: Container(

         height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width/1.6,
         color: Colors.white,
         padding: EdgeInsets.only(top: 40),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Column(
               children: [
                 Container(
                   height: 20,
                   width: MediaQuery.of(context).size.width,
                   alignment: Alignment.centerLeft,
                   margin: EdgeInsets.only(left: 16,top: 16),
                   child: IconButton(
                     padding: EdgeInsets.all(1),
                     icon: SvgPicture.asset("assets/icons/close.svg",height: 20,width: 20,),
                     onPressed: (){
                       mainScaffoldKey.currentState?.closeEndDrawer();
                     },
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.only(bottom: 14),
                   width: 75,height: 71,
                   child: Image.asset("assets/images/MainIcon.png",fit: BoxFit.cover,),
                 ),
                 Container(
                   margin: EdgeInsets.only(left: 16,right: 16,bottom: 20),
                   child: Divider(
                     height: 0,
                     color: Theme.of(context).primaryColor,
                     thickness: 1,
                   ),
                 ),
                 // CustomButton.buttonIconWithText(margin: EdgeInsets.only(left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/setting.svg",title: "الأعدادات",onPressed: (){Navigator.of(context).pushNamed("SettingPage");}),
                 CustomButton.buttonIconWithText(margin: EdgeInsets.only(left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/contuct_us.svg",title: "تواصل معنا",onPressed: (){Navigator.of(context).pushNamed("ContuctUsPage");}),
                 CustomButton.buttonIconWithText(margin: EdgeInsets.only(left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/support.svg",title: "ابلغ عن مشكلة",onPressed: (){Navigator.of(context).pushNamed("ReportProblemPage");}),
                 CustomButton.buttonIconWithText(margin: EdgeInsets.only(left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/about_us.svg",title: "سياسة الخصوصية",onPressed: (){Navigator.of(context).pushNamed("PrivacyPolicyPage");}),
                 isLogin == true?CustomButton.buttonIconWithText(margin: EdgeInsets.only(left: 20,right: 20,bottom: 16),height: 30.0,icon: "assets/icons/logout.svg",title: "تسجيل الخروج",onPressed: () async{
                  CustomAlertDailog.CustomActionDialog(context: context,titelText: " هل تريد تسجيل الخروج؟",textButton1: "نعم",textButton2: "لا",onClick1: () async{
                     final prefs = await SharedPreferences.getInstance();
                     prefs.remove("token");
                     Navigator.of(context).pushNamedAndRemoveUntil("MainPage", (route) => false);

                   },onClick2: (){
                     Navigator.of(context).pop();
                   });

                 }):Container(),

               ],
             ),

             Container(
               margin: EdgeInsets.only(bottom: 40,left: 20,right: 20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   Container(
                     margin: EdgeInsets.only(bottom: 10),
                     child: Text("تابعنا على",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff8F9BB3)),),
                   ),
                   Container(
                     width: MediaQuery.of(context).size.width,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         CustomButton.buttonIcon(margin: EdgeInsets.only(left: 10),height: 22.0,width: 22.0,icon: "assets/icons/instagram.svg",onPressed: (){
                          if(socialMedia.isNotEmpty) {
                            Config.launchURL(uri: Uri.parse(socialMedia[0]));
                          }

                         }),
                         CustomButton.buttonIcon(margin: EdgeInsets.only(left: 10),height: 27.0,width: 27.0,icon: "assets/icons/twitter.svg",onPressed: (){
                           if(socialMedia.isNotEmpty) {
                             Config.launchURL(uri: Uri.parse(socialMedia[1]));
                           }
                         }),
                         CustomButton.buttonIcon(margin: EdgeInsets.only(left: 10),height: 22.0,width: 22.0,icon: "assets/icons/facebook.svg",onPressed: (){
                           if(socialMedia.isNotEmpty) {
                             Config.launchURL(uri: Uri.parse(socialMedia[2]));
                           }
                         }),
                       ],
                     ),
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

