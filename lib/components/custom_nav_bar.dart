import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CustomNavBar {

 static customNaveBar({context,title}){
    return Stack(

      children: [

        Positioned(
            top: 58,
            left: 0,
            right: 0,
            child:  Center(
              child: Text("$title",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
            )
        ),

        Positioned(
            top: 42,
            right: 16,
            child: Container(
              child: Image.asset("assets/images/MainIcon.png", width: 54,height: 51,fit: BoxFit.cover,),
            )
        ),
        Positioned(
            left: 8,
            top: 58,
            child: Container(
              height: 24,
              width: 40,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset("assets/icons/arrow-back.svg"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            )
        )
      ],
    );
  }

}