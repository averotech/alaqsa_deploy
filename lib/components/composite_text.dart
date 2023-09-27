import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CompositeText {
  static statisticsItem({context,icon,title,statistics}){
    return Container(

      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(8.5),
            decoration: BoxDecoration(
                color: Color(0xffE4FFE5),
                shape: BoxShape.circle
            ),
            child: SvgPicture.asset("$icon",color: Theme.of(context).primaryColor,),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text("$title",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xffB7B7B7),height: 1.5),),

          ),
          Container(
            child: Text("$statistics",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w600,fontFamily: 'Montserrat',color:Color(0xff101426),height: 1.5),),

          )
        ],
      ),
    );
  }

  static textAboveText({context,title,value}){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Text("$title",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),),
          ),
          Container(
            child: Text("$value",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426),height: 1.5),textAlign: TextAlign.center,),
          )
        ],
      ),
    );
  }
}