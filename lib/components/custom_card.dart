import 'dart:math';

import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/LineDashedPainter.dart';
import 'package:alaqsa/components/composite_text.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/bus.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/volunteer.dart';
import 'package:alaqsa/views/main_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

class CustomCard {
  static GlobalState globalState = GlobalState.instance;

  static cardNews({context, required News news, index, onPressed}) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      height: (MediaQuery.of(context).size.height / 6.0),
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 8,
              color: Theme.of(context).primaryColor,
            ),
            Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(right: 7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: Offset(0, 0),
                          blurRadius: 1),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          offset: Offset(0, 2),
                          blurRadius: 6),
                      BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          offset: Offset(0, 16),
                          blurRadius: 24)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffE4FFE5).withOpacity(0.52),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 212,
                        margin: EdgeInsets.only(left: 12, right: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "${news.title.toString().length > 20 ? news.title.toString().substring(0, 20) + "..." : news.title.toString()}",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SansArabicLight',
                                    color: Theme.of(context).primaryColor,
                                    height: 1.5,
                                    overflow: TextOverflow.ellipsis),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              child: Text(
                                "${news.date}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SansArabicLight',
                                    color: Color(0xff8F9BB3),
                                    height: 1.5),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${news.description}",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SansArabicLight',
                                    color: Color(0xff101426),
                                    height: 1.5,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: (MediaQuery.of(context).size.height / 6.7),
                        width: 133,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.network(
                            "${Config.BaseUrl.toString() + "/storage/" + news.imageNews.toString()}",
                            fit: BoxFit.cover,
                          ),
                          // child: CachedNetworkImage(
                          //   placeholder: (context, url) => Image.asset("assets/images/image1.png",fit: BoxFit.fill),
                          //   errorWidget: (context, url, error) => Image.asset("assets/images/image1.png",fit: BoxFit.fill),
                          //   imageUrl: "${Config.BaseUrl.toString()+"/storage/"+news.imageNews.toString()}",fit: BoxFit.fill,)
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
        onPressed: () {
          onPressed(index);
        },
      ),
    );
  }

  static cardProjects(
      {context,
      index,
      required Project project,
      onPressed,
      onPressedVolunteer}) {
    var now = DateTime.now();
    bool isExpired = false;
    if (project.endDate != null && project.endDate.toString() != "") {
      var expirationDate = DateTime.parse(project.endDate);
      isExpired = expirationDate.isBefore(now);
    } else {
      isExpired = false;
    }

    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,

                // height: (project.descriptionProject.toString().length>100?MediaQuery.of(context).size.height/2.00:project.descriptionProject.toString().length>50?MediaQuery.of(context).size.height/2.09:MediaQuery.of(context).size.height/2.19),
                color: Theme.of(context).primaryColor,
              ),
              Container(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, bottom: 16, top: 16),
                  margin: EdgeInsets.only(right: 7),
                  // height: (project.descriptionProject.toString().length>100?MediaQuery.of(context).size.height/2.00:project.descriptionProject.toString().length>50?MediaQuery.of(context).size.height/2.09:MediaQuery.of(context).size.height/2.19),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            offset: Offset(0, 0),
                            blurRadius: 1),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            offset: Offset(0, 2),
                            blurRadius: 6),
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            offset: Offset(0, 16),
                            blurRadius: 24)
                      ]),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 55,
                    margin: EdgeInsets.only(left: 7, right: 7),
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffE4FFE5).withOpacity(0.52),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "${project.nameProject.toString().length > 35 ? project.nameProject.toString().substring(0, 35) + "..." : project.nameProject.toString()}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SansArabicLight',
                                      color: Theme.of(context).primaryColor,
                                      height: 1),
                                ),
                              ),
                              Container(
                                  height: 24,
                                  width: 24,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: SvgPicture.asset(
                                        "assets/icons/share.svg"),
                                    onPressed: () {
                                      Config.share(
                                          title: project.nameProject,
                                          text: project.descriptionProject);
                                    },
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Text(
                            "${project.startDate}",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SansArabicLight',
                                color: Color(0xff8F9BB3),
                                height: 1.5),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 8),
                        //   child: Row(
                        //     children: [
                        //       SvgPicture.asset("assets/icons/location.svg"),
                        //       Container(
                        //         margin: EdgeInsets.only(left: 8, right: 8),
                        //         child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Container(
                        //               child: Text(
                        //                 "مكان المشروع",
                        //                 style: TextStyle(
                        //                     fontSize: 12,
                        //                     fontWeight: FontWeight.w700,
                        //                     fontFamily: 'SansArabicLight',
                        //                     color:
                        //                         Theme.of(context).primaryColor,
                        //                     height: 1.5),
                        //               ),
                        //             ),
                        //             Container(
                        //               child: Text(
                        //                 "${project.location != null && project.location != "" ? project.location : "غير محدد"}",
                        //                 style: TextStyle(
                        //                     fontSize: 14,
                        //                     fontWeight: FontWeight.w600,
                        //                     fontFamily: 'SansArabicLight',
                        //                     color: Color(0xff8F9BB3)),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                            "${project.descriptionProject}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SansArabicLight',
                              color: Color(0xff101426),
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Visibility(
                            visible: isExpired ||
                                    (project.is_donation == false &&
                                        project.is_volunteer == false)
                                ? false
                                : true,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10, bottom: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
//                                Todo Modify donation now by payPal and Tranzila
//                                   Visibility(visible: project.is_donation && !isExpired, child:Container(
//                                     width: project.is_volunteer == false && !isExpired?(MediaQuery.of(context).size.width)-75:(MediaQuery.of(context).size.width/2)-45,
//                                     height: 42,
//                                     decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor,
//                                         borderRadius: BorderRadius.circular(50)
//                                     ),
//                                     child: MaterialButton(
//                                       height: 42,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(50)
//                                       ),
//                                       child: Text("تبرع الان",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
//                                       onPressed: () async{
//                                         if(await Config.checkLogin() == true){
//                                         globalState.set("donationTrip", null);
//                                         globalState.set("donationProject", project);
//                                         Navigator.of(context).pushNamed("DonationSummaryPage");
//                                         } else {
//                                         Navigator.of(context).pushNamed("LoginPage");
//                                         }
//                                       },
//                                     ),
//                                   )),
                                  Visibility(
                                      visible:
                                          project.is_volunteer && !isExpired,
                                      child: Container(
                                        height: 42,
                                        // Todo change divided width by (2)-45
                                        width: project.is_donation == false &&
                                                !isExpired
                                            ? (MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                75
                                            : (MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                75,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: MaterialButton(
                                          height: 42,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Text(
                                            "${project.is_volunteer_user ? "الغاء التطوع" : "تطوع الأن"}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'SansArabicLight',
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                height: 1.4),
                                          ),
                                          onPressed: () async {
                                            if (await Config.checkLogin() ==
                                                true) {
                                              onPressedVolunteer(project);
                                            } else {
                                              Navigator.of(context)
                                                  .pushNamed("LoginPage");
                                            }
                                          },
                                        ),
                                      )),
                                ],
                              ),
                            )),
                        Container(
                          height: MediaQuery.of(context).size.height / 6.1,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 16),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: project.news.imageNews.toString() != "null"
                                ? Image.network(
                                    "${Config.BaseUrl.toString() + "/storage/" + project.news.imageNews}",
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/image3.png",
                                    fit: BoxFit.cover,
                                  ),

                            // child: project.imageProject != null && project.imageProject != "null"?Image.network(Config.BaseUrl.toString()+"/storage/"+project.imageProject)
                            //     :Image.asset("assets/images/image3.png",fit: BoxFit.cover,),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        onPressed: () {
          onPressed(index);
        },
      ),
    );
  }

  static cardProfileProjects({context, index, required Volunteer volunteer}) {
    var now = DateTime.now();
    var expirationDate = DateTime.parse(volunteer.project.endDate);
    bool isExpired = expirationDate.isBefore(now);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 8, bottom: 8),
        shape: RoundedRectangleBorder(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              clipBehavior: Clip.none,
              padding:
                  EdgeInsets.only(left: 12, right: 12, bottom: 18, top: 18),
              margin: EdgeInsets.only(right: 16, left: 16),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        offset: Offset(0, 0),
                        blurRadius: 1),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        offset: Offset(0, 2),
                        blurRadius: 6),
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        offset: Offset(0, 16),
                        blurRadius: 24)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSectionComponent.Section(
                      context: context,
                      text:
                          "${volunteer.statusVolunteer.toString() == "1" && !isExpired ? "مهمات فعالة" : "مهمات غير فعالة"}",
                      text_color: Colors.white,
                      line_color: Colors.white,
                      margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                      seeMore: false),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            volunteer.project.nameProject,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SansArabicLight',
                                color: Colors.white,
                                height: 1.5),
                          ),
                        ),
                        Container(
                          height: 24,
                          width: 24,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text(
                      volunteer.project.startDate,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SansArabicLight',
                          color: Colors.white,
                          height: 1.5),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 8),
                  //   child: Row(
                  //     children: [
                  //       SvgPicture.asset(
                  //         "assets/icons/location.svg",
                  //         color: Colors.white,
                  //       ),
                  //       Container(
                  //         margin: EdgeInsets.only(left: 8, right: 8),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               child: Text(
                  //                 "مكان المشروع",
                  //                 style: TextStyle(
                  //                     fontSize: 12,
                  //                     fontWeight: FontWeight.w700,
                  //                     fontFamily: 'SansArabicLight',
                  //                     color: Colors.white,
                  //                     height: 1.5),
                  //               ),
                  //             ),
                  //             Container(
                  //               child: Text(
                  //                 "فاولوس هشيشي 102، الناصرة",
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.w600,
                  //                     fontFamily: 'SansArabicLight',
                  //                     color: Colors.white),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      "${volunteer.project.descriptionProject}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'SansArabicLight',
                        color: Colors.white,
                        height: 1.5,
                      ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Visibility(
                      visible: volunteer.statusVolunteer.toString() == "1" &&
                              !isExpired
                          ? true
                          : false,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 42,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 51, right: 51),
                          height: 42,
                          child: Text(
                            "الغاء التطوع",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SansArabicLight',
                                color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      )),
                ],
              ),
            ),
            Visibility(
                visible:
                    volunteer.statusVolunteer.toString() == "1" && !isExpired
                        ? false
                        : true,
                child: Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ))
          ],
        ),
        onPressed: () {
          globalState.set("project", volunteer.project);
          globalState.set("news", null);
          if (volunteer.project.publicationStatus) {
            Navigator.of(context).pushNamed("DetaileNewsAndProjectPage");
          }
        },
      ),
    );
  }

  static cardTrip(
      {context,
      index,
      required Trip trip,
      onPressed,
      onPressedBookingAndCloseTrip}) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: Offset(0, 0),
                      blurRadius: 1),
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: Offset(0, 2),
                      blurRadius: 6),
                ]),
            child: MaterialButton(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: Text(
                            "يوم " + "${trip.nameDate}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SansArabicLight',
                                color: Color(0xff101426),
                                height: 1),
                          ),
                        ),
                        Container(
                          child: Text(
                            trip.startDate,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SansArabicLight',
                                color: Color(0xff8F9BB3),
                                height: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    duration: Duration(milliseconds: 300),
                    child: SvgPicture.asset("assets/icons/down-arrow.svg"),
                    turns: trip.isOpen ? 0.25 : 0.0,
                  )
                ],
              ),
              onPressed: () {
                onPressed(index);
              },
            ),
          ),
          AnimatedContainer(
            height: trip.isOpen == false
                ? (MediaQuery.of(context).size.height < 800
                    ? MediaQuery.of(context).size.height / 2.1
                    : MediaQuery.of(context).size.height / 2.15)
                : 0,
            duration: Duration(milliseconds: 300),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              child: CardInformationTrip(
                  context: context,
                  trip: trip,
                  index: index,
                  isBooking: false,
                  onPressedBookingAndCloseTrip: onPressedBookingAndCloseTrip),
            ),
          )
        ],
      ),
    );
  }

  static CardInformationBus(
      {context, required Bus bus, required Trip trip, activeClick = true}) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 16, right: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffCFE9FF))),
      child: MaterialButton(
        padding: EdgeInsets.only(left: 8, right: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 5.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset("assets/icons/location.svg"),
                        ),
                        Container(
                          height: 51,
                          child: CustomPaint(
                              painter: LineDashedPainter(Color(0xffB7B7B7))),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffE4FFE5), shape: BoxShape.circle),
                          child: SvgPicture.asset(
                            "assets/icons/tour-bus.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Text("رقم الباص: " + bus.busNumber.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SansArabicLight',
                                  color: Colors.black)),
                        ),
                        CustomSectionComponent.StartingEndingPoint(
                            context: context,
                            margin: EdgeInsets.only(top: 7),
                            title: 'مكان الأنطلاق',
                            location: bus.startPoint.addressLocation != null
                                ? bus.startPoint.addressLocation
                                            .toString()
                                            .length >
                                        30
                                    ? bus.startPoint.addressLocation
                                        .toString()
                                        .substring(0, 30)
                                    : bus.startPoint.addressLocation.toString()
                                : "غير معروف",
                            clockIcon: 'assets/icons/clock.svg',
                            time: trip.startTime,
                            distanceIcon: 'assets/icons/distance.svg',
                            km: 'كم ' +
                                (trip.fromDistance != null
                                    ? trip.fromDistance.toString()
                                    : "0.0"),
                            globalColor: Color(0xff101426),
                            iconColor: Theme.of(context).primaryColor,
                            titleColor: Theme.of(context).primaryColor),
                        CustomSectionComponent.StartingEndingPoint(
                            context: context,
                            margin: EdgeInsets.only(top: 16),
                            title: 'مكان الوصول',
                            location: bus.endPoint.addressLocation != null
                                ? bus.endPoint.addressLocation
                                            .toString()
                                            .length >
                                        30
                                    ? bus.endPoint.addressLocation
                                        .toString()
                                        .substring(0, 30)
                                    : bus.endPoint.addressLocation.toString()
                                : 'المسجد الأقصى',
                            clockIcon: 'assets/icons/clock.svg',
                            time: trip.endTime,
                            distanceIcon: 'assets/icons/distance.svg',
                            km: 'كم ' +
                                (trip.toDistance != null
                                    ? trip.toDistance.toString()
                                    : "0.0"),
                            globalColor: Color(0xff101426),
                            iconColor: Theme.of(context).primaryColor,
                            titleColor: Theme.of(context).primaryColor),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(
                              "عدد الركاب: " +
                                  (bus.numberOfSeats.toString() == "null"
                                      ? "غير معروف"
                                      : bus.numberOfSeats.toString()) +
                                  " راكب",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SansArabicLight',
                                  color: Colors.black)),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
        onPressed: () {
          if (activeClick) {
            Navigator.of(context).pop(bus);
          }
        },
      ),
    );
  }

  static CardInformationTrip({
    context,
    key,
    required Trip trip,
    index,
    onPressedBookingAndCloseTrip,
    isBooking,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      margin: EdgeInsets.only(top: 12, left: 16, right: 16),
      decoration: BoxDecoration(
        color: isBooking ? Theme.of(context).primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0, 0),
              blurRadius: 4
          ),
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0, 2),
              blurRadius: 4
          ),
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: Offset(0, 16),
              blurRadius: 6
          )
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/icons/location.svg",
                            color: isBooking
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          height: 60,
                          child: CustomPaint(
                            painter: LineDashedPainter(
                                isBooking ? Colors.white : Color(0xffB7B7B7)
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffE4FFE5),
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/tour-bus.svg",
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Container(
                          height: 60,
                          child: CustomPaint(
                            painter: LineDashedPainter(
                                isBooking ? Colors.white : Color(0xffB7B7B7)
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: isBooking
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              shape: BoxShape.circle
                          ),
                          child: SvgPicture.asset("assets/icons/al-aqsa-mosque.svg"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 0,top:16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "اسم القافلة:  ${trip.nameTrip.length > 44 ? trip.nameTrip.substring(0, 44) + '...' : trip.nameTrip}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SansArabicLight',
                              height: 2,
                              color: isBooking
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                            overflow: TextOverflow.visible, // This allows the text to overflow into multiple lines
                            softWrap: true, // Enables text wrapping
                          ),
                        ),
                        Container(
                          child: Text(
                            "تفاصيل الرحلة: ${trip.nameDate} - ${trip.startDate}  ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SansArabicLight',
                              height: 2,
                              color: isBooking
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.visible, // This allows the text to overflow into multiple lines
                            softWrap: true, // Enables text wrapping
                          ),
                        ),
                        CustomSectionComponent.StartingEndingPoint(
                          context: context,
                          margin: EdgeInsets.only(top: 16),
                          title: 'مكان الأنطلاق',
                          location: trip.tripFromLocation != null
                              ? trip.tripFromLocation.toString().length > 45
                              ? trip.tripFromLocation
                              .toString()
                              .substring(0, 45)
                              : trip.tripFromLocation.toString()
                              : "غير معروف",
                          clockIcon: 'assets/icons/clock.svg',
                          time: trip.startTime,
                          endDate:trip.endDate,
                          distanceIcon: 'assets/icons/distance.svg',
                          km: 'كم ' +
                              (trip.fromDistance != null
                                  ? trip.fromDistance.toString()
                                  : "0.0"),
                          globalColor:
                          isBooking ? Colors.white : Color(0xff101426),
                          iconColor: isBooking
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          titleColor: isBooking
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                        CustomSectionComponent.StartingEndingPoint(
                          context: context,
                          margin: EdgeInsets.only(top: 16),
                          title: 'مكان الوصول '  ,
                          location: trip.to.addressLocation != null
                              ? trip.tripToLocation.toString().length > 45
                              ? trip.tripToLocation
                              .toString()
                              .substring(0, 45)
                              : trip.tripToLocation
                              : 'المسجد الأقصى',
                          clockIcon: 'assets/icons/clock.svg',
                          // time: trip.endTime,
                          distanceIcon: 'assets/icons/distance.svg',
                          km: 'كم ' +
                              (trip.fromDistance != null
                                  ? trip.toDistance.toString()
                                  : "0.0"),
                          globalColor:
                          isBooking ? Colors.white : Color(0xff101426),
                            endDate:trip.endDate,
                          iconColor: isBooking
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          titleColor: isBooking
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text("وقت العودة",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SansArabicLight',
                                              color: isBooking
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColor,
                                              height: 1.2)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/clock.svg",
                                              color: isBooking
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColor),
                                          Container(
                                            margin: EdgeInsets.only(right: 2),
                                            child: Text(
                                              trip.endTime,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SansArabicLight',
                                                  color: isBooking
                                                      ? Colors.white
                                                      : Color(0xff101426)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text("مكان العودة",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SansArabicLight',
                                              color: isBooking
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColor,
                                              height: 1.2)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/location.svg",
                                              color: isBooking
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                  .primaryColor),
                                          Container(
                                            margin: EdgeInsets.only(right: 2),
                                            child: Text(
                                              "${trip.tripFromLocation != null ? trip.tripFromLocation.toString().length > 45 ? trip.tripFromLocation.toString().substring(0, 45) : trip.tripFromLocation.toString() : "غير معروف"}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SansArabicLight',
                                                  color: isBooking
                                                      ? Colors.white
                                                      : Color(0xff101426)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      height: 42,
                      decoration: BoxDecoration(
                          color: isBooking
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        height: 42,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "${trip.isFull && !trip.isBooking?'القافلة ممتلئة':trip.isBooking ? "الغاء الحجز" : "احجز الان"}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SansArabicLight',
                              color:trip.isFull && !trip.isBooking ? Theme.of(context).disabledColor: isBooking
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              height: 1.4),
                        ),
                        onPressed:trip.isFull && !trip.isBooking ? null: () {
                          onPressedBookingAndCloseTrip(index);
                        },
                      ),
                    ),
                    Container(
                      height: 42,
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: isBooking
                                  ? Colors.white
                                  : Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(50)),
                      child: MaterialButton(
                        height: 42,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "تبرع الان",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SansArabicLight',
                              color: isBooking
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              height: 1.4),
                        ),
                        onPressed: () async {
                          if (await Config.checkLogin() == true) {
                            globalState.set("donationTrip", trip);
                            globalState.set("donationProject", null);
                            Navigator.of(context).pushNamed("DonationSummaryPage");
                          } else {
                            Navigator.of(context).pushNamed("LoginPage");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          trip.isFull?  Positioned(
            top: 10,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                " ممتلئة",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ):Container(),
        ],
      ),
    );
  }


  static cardStatistics(
      {context, margin, title1, value1, title2, value2, title3, value3}) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: Offset(0, 0),
                blurRadius: 1),
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: Offset(0, 2),
                blurRadius: 4),
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                offset: Offset(0, 16),
                blurRadius: 6)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: CompositeText.textAboveText(
                context: context, title: title1, value: value1.toString()),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: CompositeText.textAboveText(
                context: context, title: title2, value: value2),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 4,
              child: CompositeText.textAboveText(
                  context: context, title: title3, value: value3)),
        ],
      ),
    );
  }

  static cardPaymentMethod({context, margin, removeButton, width}) {
    return Container(
      width: width == -1 ? null : MediaQuery.of(context).size.width,
      margin: margin ?? EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/PayPal.svg"),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: Text("paybal",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SansArabicLight',
                              color: Color(0xff101426),
                              height: 1.2)),
                    ),
                    Container(
                      child: Text(
                        "admin@gmail.com",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SansArabicLight',
                            color: Color(0xffB7B7B7),
                            height: 1.2),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Visibility(
              visible: removeButton ?? true,
              child: Container(
                child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero)),
                  child: Text("إزالة",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SansArabicLight',
                          color: Theme.of(context).primaryColor,
                          height: 1.2)),
                  onPressed: () {},
                ),
              ))
        ],
      ),
    );
  }
}
