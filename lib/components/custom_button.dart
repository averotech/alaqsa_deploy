import 'package:alaqsa/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomButton {

  static customButton1({context, textButton, iconButton,visibleIcon,top,bottom,onPressed})
  {
    return  Container(
      height: 48,
      margin: EdgeInsets.only(top: top,bottom: bottom),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0,3),
                blurRadius: 25
            )
          ]

      ),
      child: MaterialButton(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                visibleIcon?Visibility(visible: visibleIcon,child:Container(
                    margin: EdgeInsets.only(left: 3,right: 3),
                    child: SvgPicture.asset("$iconButton")
                )):Container(),
                Container(
                    margin: EdgeInsets.only(left: 3,right: 3),
                    child: Text("$textButton",style:TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',),)
                ),

              ],
            ),
          ),
          onPressed:(){
            onPressed();
          }
      ),
    );
  }

  static buttonNavBar({context,icon,backGoundColor,colorIcon,text,textColor,onPressed}){
    return Container(
      width: MediaQuery.of(context).size.width/5,
      child: Column(
        children: [
          Container(

              decoration: BoxDecoration(
                  color: backGoundColor,
                  shape: BoxShape.circle
              ),child:IconButton(
            padding: EdgeInsets.all(7),
            icon: SvgPicture.asset("$icon",color: colorIcon,width: 20,height: 20,),
            onPressed: (){
              onPressed();
            },
          )),
          Container(
            child: Text("$text",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:textColor),),
          )
        ],
      ),
    );
  }

  static buttonIconWithText({margin,mainAxisAlignment,padding,height,icon,title,onPressed}){
    return Container(
      margin: margin,
      height: height,

      child: MaterialButton(
        padding: padding ??EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: mainAxisAlignment??MainAxisAlignment.start,
          children: [
            Container(
              child: SvgPicture.asset(icon),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Text("$title",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.black),),

            )
          ],
        ),
        onPressed: (){
          onPressed();
        },
      ),
    );
  }

  static buttonIcon({margin,height,width,icon,onPressed}){
    return Container(
      height: height,
      width: width,
      alignment: Alignment.centerLeft,
      margin: margin,
      child: IconButton(
        padding: EdgeInsets.all(1),
        icon: SvgPicture.asset("$icon",height: height,width: width,),
        onPressed: (){
          onPressed();
        },
      ),
    );
  }

  static borderButtonIconWithText({height,margin,icon,paddingIcon,paddingButton,text,textColor,onPressed}){
    return Container(
      height: height,
      margin: margin,

      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffCFE9FF)),
          borderRadius: BorderRadius.circular(50)
      ),
      child: MaterialButton(
        height: height,

        padding: EdgeInsets.only(left: paddingButton??12,right: paddingButton??12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(

              height: 30,width: 30,
              padding: EdgeInsets.all(paddingIcon??3),
              child: SvgPicture.asset("$icon"),
            ),
            Container(
              margin: EdgeInsets.only(left: 6,right: 6),
              child: Text("$text",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color: textColor??Color(0xff101426)),),
            ),
          ],
        ),
        onPressed: (){
          onPressed();
        },
      ),
    );
  }
}

