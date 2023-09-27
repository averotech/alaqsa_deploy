import 'package:alaqsa/theme_app/styles.dart';
import 'package:alaqsa/views/about_us.dart';
import 'package:alaqsa/views/booking_page.dart';
import 'package:alaqsa/views/completed_booking_page.dart';
import 'package:alaqsa/views/completed_volunteer_page.dart';
import 'package:alaqsa/views/contuct_us_page.dart';
import 'package:alaqsa/views/PrivacyPolicyPage.dart';
import 'package:alaqsa/views/detaile_news_and_project_page.dart';
import 'package:alaqsa/views/donation_summary_page.dart';
import 'package:alaqsa/views/news_page.dart';
import 'package:alaqsa/views/payment_method_page.dart';
import 'package:alaqsa/views/profile_page.dart';
import 'package:alaqsa/views/splash_screen.dart';
import 'package:alaqsa/views/volunteer_page.dart';
import 'package:alaqsa/views/main_page.dart';
import 'package:alaqsa/views/login.dart';
import 'package:alaqsa/views/new_password.dart';
import 'package:alaqsa/views/register.dart';
import 'package:alaqsa/views/report_problem_page.dart';
import 'package:alaqsa/views/reset_password.dart';
import 'package:alaqsa/views/search_page.dart';
import 'package:alaqsa/views/setting_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alaqsa',
      debugShowCheckedModeBanner: false,
      theme: Styles.themeData(false, context),
      home:  SplashScreen(),
      locale: Locale('ar','QA'),
        supportedLocales: [
          const Locale('ar','QA'),
          const Locale('en','US'),
        ],
      localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      routes: {
        'MainPage': (BuildContext context) => new MainPage(),
        'LoginPage': (BuildContext context) => new Login(),
        'RegisterPage': (BuildContext context) => new Register(),
        'ResetPassworedPage': (BuildContext context) => new ResetPassword(),
        'NewPassworedPage': (BuildContext context) => new NewPassword(),
        'SettingPage': (BuildContext context) => new SettingPage(),
        'ContuctUsPage': (BuildContext context) => new ContuctUsPage(),
        'PrivacyPolicyPage': (BuildContext context) => new PrivacyPolicy(),
        'ReportProblemPage': (BuildContext context) => new ReportProblemPage(),
        'AboutUsPage': (BuildContext context) => new AboutUsPage(),
        'SearchPage': (BuildContext context) => new SearchPage(),
        'VolunteerPage': (BuildContext context) => new VolunteerPage(),
        'CompletedVolunteerPage': (BuildContext context) => new CompletedVolunteerPage(),
        'DetaileNewsAndProjectPage': (BuildContext context) => new DetaileNewsAndProjectPage(),
        'BookingPage': (BuildContext context) => new BookingPage(),
        'CompletedBookingPage': (BuildContext context) => new CompletedBookingPage(),
        'ProfilePage': (BuildContext context) => new ProfilePage(),
        'PaymentMethodPage': (BuildContext context) => new PaymentMethodPage(),
        'DonationSummaryPage': (BuildContext context) => new DonationSummaryPage(),
        'NewsPage': (BuildContext context) => new NewsPage()

      }
    );
  }
}


