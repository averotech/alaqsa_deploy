import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';


class CustomSectionComponent {
  static StartingEndingPoint({context,margin,title,location,clockIcon,time,distanceIcon,km,globalColor,endDate,iconColor,@required titleColor}){
    DateTime dtf = DateTime.now(); // Define the current date

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          // toString().length > 44
            child: Text("$title",style:TextStyle(fontSize: title.toString().length > 44 ? 13 : 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color: titleColor,height: 1.3),overflow: TextOverflow.clip,),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: Text("$location",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:globalColor,height: 1.4,),overflow: TextOverflow.ellipsis,),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if ( time != null)
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Row(
                      children: [
                        SvgPicture.asset("$clockIcon",color: iconColor),
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          child: Text("$time",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:globalColor),),
                        ),

                      ],
                    ),
                  ),
                if(time== null && title !='مكان الوصول')
                  Container(
                    margin: EdgeInsets.only(left: 0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 0),
                          // child: Text("تاريخ العودة:  ${endDate} ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:globalColor),),
                        ),

                      ],
                    ),
                  ),
                if (distanceIcon != null && km != null)
                  Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Row(

                      children: [
                        SvgPicture.asset("$distanceIcon",color: iconColor),
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          child: Text("$km",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:globalColor),),
                        ),

                      ],
                    ),
                  ),


              ],
            ),
          )
        ],
      ),
    );
  }
  static Section({context,text,text_color,line_color,margin,seeMore,crossAxisAlignment,width}){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width??null,
            child: Column(
              crossAxisAlignment: crossAxisAlignment??CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$text",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:text_color??Color(0xff101426)),),

                Container(
                  margin: EdgeInsets.only(top: 7),
                  width: MediaQuery.of(context).size.width/12,
                  child: Divider(
                    color: line_color??Theme.of(context).primaryColor,
                    thickness: 4,
                  ),
                )
              ],
            ),
          ),
          seeMore?Container(

            child: TextButton(
              style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Text("رؤية المزيد",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xffB7B7B7)),),
              onPressed: (){

              },
            ),
          ):Container(),


        ],
      ),
    );
  }





}
