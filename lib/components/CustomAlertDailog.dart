
import 'dart:ui';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum SingingCharacter { paybal, VisaCard }
class CustomAlertDailog {


  static CustomActionDialog({context, titelText, textButton1, textButton2, onClick1, onClick2}) {
    return showGeneralDialog(
        barrierColor: Color(0xff101426).withOpacity(0.8),

        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide.none),
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  height:  MediaQuery.of(context).size.height<800?MediaQuery.of(context).size.height/3.1:MediaQuery.of(context).size.height/3.3,
                  margin: EdgeInsets.only(left: 30,right: 30),
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 24,
                          height: 24,
                          margin: EdgeInsets.only(top: 19,left: 20),

                          child: IconButton(
                            padding: EdgeInsets.zero,

                            icon: SvgPicture.asset("assets/icons/close.svg"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 9),
                        alignment: Alignment.center,
                        child: Text("$titelText",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),textAlign: TextAlign.center,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/9,
                        margin: EdgeInsets.only(bottom: 19),
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 3,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-140,
                        margin: EdgeInsets.only(left: 40, right: 40,bottom: 9),
                        decoration: BoxDecoration(

                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),

                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff312E2E).withOpacity(0.16),
                              offset: Offset(0,3),
                              blurRadius: 6
                            )
                          ]
                        ),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.only(top: 9,bottom: 9),
                          height: 48,
                          child: Text(textButton1, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white),textAlign: TextAlign.center,),
                          onPressed: (){
                            onClick1();
                          },
                        ),
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width-140,
                        margin: EdgeInsets.only(left: 40, right: 40,bottom: 35),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff312E2E).withOpacity(0.16),
                                  offset: Offset(0,3),
                                  blurRadius: 6
                              )
                            ]

                        ),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 48,
                          padding: EdgeInsets.only(top: 9,bottom: 9),
                          child: Text(textButton2, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor),textAlign: TextAlign.center,),
                          onPressed: (){
                            onClick2();
                          },
                        ),
                      ),


                    ],
                  ),
                ),

              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {return Container();}
    );
  }
  CustomDialog(context,titelText,textButton1,textButton2,onClick1,onClick2) {
      return showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),

          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide.none),
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 102,
                    margin: EdgeInsets.only(left: 53,right: 53),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 19,bottom: 19),
                          alignment: Alignment.center,
                          child: Text("$titelText",style: Theme.of(context).primaryTextTheme.bodyText1,textAlign: TextAlign.center,),
                        ),
                        Container(

                          height: 0,
                          child: Divider(
                            color: Colors.black.withOpacity(0.36),
                          ),
                        ),
                        Container(

                          child: Row(
                            children: [
                              Container(
                                height: 43,
                                width: (MediaQuery.of(context).size.width/2)-61,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                ),
                                child: MaterialButton(
                                  height: MediaQuery.of(context).size.width/8.9, padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text("$textButton1",textAlign: TextAlign.center,),
                                  onPressed: (){
                                    onClick1();
                                  },
                                ),
                              ),
                              Container(
                                height:  44,
                                child: VerticalDivider(
                                  color: Colors.black.withOpacity(0.36),
                                ),
                              ),

                              Container(
                                height: 43,
                                width: (MediaQuery.of(context).size.width/2)-61,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                ),
                                child: MaterialButton(
                                  height: MediaQuery.of(context).size.width/8.9,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text("$textButton2",textAlign: TextAlign.center,),
                                  onPressed: (){

                                    onClick2();

                                  },
                                ),
                              )


                            ],
                          ),
                        )


                      ],
                    ),
                  ),

                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {return Container();}
      );
    }


  GenralDialog(context,barrierDismissible,height,HeadText,titelText,textButton1,textButton2,onClick1,onClick2) {
      return showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),

          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide.none),
                  content:   Container(
                    width: MediaQuery.of(context).size.width,
                    height: height,
                    //height: HeadText == ""?MediaQuery.of(context).size.width/3.97:MediaQuery.of(context).size.width/3.19,

                    margin: EdgeInsets.only(left: 53,right: 53),
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 19,bottom: 19),

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                  visible: false,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 2),
                                    child: Text("$HeadText",textAlign: TextAlign.center,),
                                  )
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text("$titelText",style: Theme.of(context).primaryTextTheme.bodyText1,textAlign: TextAlign.center,),
                              ),
                            ],
                          ),
                        ),
                        Container(

                          height: 0,
                          child: Divider(
                            color: Colors.black.withOpacity(0.36),
                          ),
                        ),
                        Container(

                          child: Row(
                            children: [
                              Container(
                                height: 43,
                                width: (MediaQuery.of(context).size.width/2)-61,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                ),
                                child: MaterialButton(
                                  height: MediaQuery.of(context).size.width/8.9, padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text("$textButton1",textAlign: TextAlign.center,),
                                  onPressed: (){
                                    onClick1();
                                  },
                                ),
                              ),
                              Container(
                                height: 45,
                                child: VerticalDivider(

                                  color: Colors.black.withOpacity(0.36),
                                ),
                              ),

                              Container(
                                height: 43,
                                width: (MediaQuery.of(context).size.width/2)-61,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                ),
                                child: MaterialButton(
                                  height: MediaQuery.of(context).size.width/8.9,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
                                  ),
                                  child: Text("$textButton2",textAlign: TextAlign.center,),
                                  onPressed: (){
                                    onClick2();
                                  },
                                ),
                              )


                            ],
                          ),
                        ),



                      ],
                    ),
                  ),

                ),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: barrierDismissible,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {return Container();
          });
    }



 static CustomLoadingDialog({context, color, size, message, type, height}) {

      return showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            if (type == 1) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      insetPadding: EdgeInsets.only(left: 140,right: 140),
                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(5.0)),

                      content: Builder(
                          builder: (context) {
                            var visibleText = true;
                            var marginTopLodaing = 16.0;



                            return Container(
                              height: height+1,

                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: marginTopLodaing, bottom: 5),
                                      child: SpinKitFadingCircle(
                                        color: color, size: size,),
                                    ),
                                    Visibility(
                                      visible: visibleText,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5, bottom: 15),
                                        child: Text('$message', style: Theme.of(context).textTheme.button,
                                          textAlign: TextAlign.center,),
                                      ),
                                    )


                                  ],
                                ),
                              ),
                            );
                          },
                        )),

                  ),

              );
            } else if (type == 2) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      insetPadding: EdgeInsets.only(left: 140,right: 140),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),

                      content: Builder(
                        builder: (context) {
                          var visibleText = true;
                          var marginTopLodaing = 16.0;



                          return Container(
                            height: height,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: marginTopLodaing, bottom: 5),
                                    child: Icon(Icons.done,color: color,size: size,),
                                  ),
                                  Visibility(
                                    visible: visibleText,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5, bottom: 16),
                                      child: Text('$message', style: Theme.of(context).textTheme.button,
                                        textAlign: TextAlign.center,),
                                    ),
                                  )


                                ],
                              ),
                            ),
                          );
                        },
                      )
                  ),
                ),
              );
            } else if (type == 3) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.only(left: 140,right: 140),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),

                    content: Builder(
                      builder: (context){
                        var visibleText = true;
                        var marginTopLodaing = 16.0;



                        return Container(
                          height: height,
                          child: Center(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: marginTopLodaing,bottom: 5),
                                  child: Icon(Icons.close,color: color,size: size,),
                                ),
                                Visibility(
                                  visible: visibleText,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 16),
                                    child: Text('$message',style: Theme.of(context).textTheme.button,textAlign: TextAlign.center,),
                                  ),
                                )



                              ],
                            ),
                          ),
                        );

                      },
                    ),
                  ),
                ),
              );
            } else{
              return Container();
            }

          },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: false,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {return Container();
          });



    }

 static CustomShowModalBottomSheet({context,nameCard,numberCard,expiryDate,cvv,onPressedCompleated}){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        SingingCharacter singingCharacter = SingingCharacter.paybal;
        return StatefulBuilder(

            builder: (context,setState){
             return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 18,left: 16,right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: CustomSectionComponent.Section(context: context,text: "أضف بياناتك لدفع",margin: EdgeInsets.only(top: 0,left: 0,right: 0),seeMore: false),
                          ),
                          Container(

                            child: IconButton(
                              icon: SvgPicture.asset("assets/icons/close.svg"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child:Row(
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            height: 20,
                            width: 20,
                            child: Transform.scale(
                                scale: 1.25,
                                child: Radio(
                                    activeColor: Theme.of(context).primaryColor,
                                    value: SingingCharacter.paybal,
                                    groupValue: singingCharacter,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        singingCharacter=value!;
                                      });

                                    }
                                )),
                          ),
                          Container(

                            child: SvgPicture.asset("assets/icons/PayPal.svg"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: Text("بايبال",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child:Row(
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            height: 20,
                            width: 20,
                            child: Transform.scale(
                                scale: 1.20,

                                child: Radio(
                                    activeColor: Theme.of(context).primaryColor,
                                    fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                                    materialTapTargetSize: MaterialTapTargetSize.padded,
                                    value: SingingCharacter.VisaCard,
                                    groupValue: singingCharacter,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        singingCharacter=value!;
                                      });

                                    }

                                )),
                          ),
                          Container(

                            child: SvgPicture.asset("assets/icons/visa.svg"),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16,right: 16),
                            child: Text("فيزا كارد",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xff101426)),),
                          ),
                        ],
                      ),
                    ),

                   if(singingCharacter == SingingCharacter.VisaCard) Column(
                      children: [
                        CustomTextField.TextFieldWithTitleAndBorder(width:MediaQuery.of(context).size.width,controller: nameCard,title: "Name on card",hintText: "Name on card",obscureText: false,margin: EdgeInsets.only(top:24,left: 16,right: 16)),
                        CustomTextField.TextFieldWithTitleAndBorder(width:MediaQuery.of(context).size.width,controller: numberCard,title: "Card Number",hintText: "Card Number",obscureText: false,margin: EdgeInsets.only(top:20,left: 16,right: 16)),
                        Container(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width/2,
                                child:  CustomTextField.TextFieldWithTitleAndBorder(width:MediaQuery.of(context).size.width,controller: cvv,title: "CVV",hintText: "CVV",obscureText: false,margin: EdgeInsets.only(top:20,left: 16,right: 16)),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width/2,
                                child:  CustomTextField.TextFieldWithTitleAndBorder(width:MediaQuery.of(context).size.width,controller: expiryDate,title: "Expiry date",hintText: "Expiry date",obscureText: false,margin: EdgeInsets.only(top:20,left: 16,right: 16)),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      width: (MediaQuery.of(context).size.width),
                      height: 42,
                      margin: EdgeInsets.only(top: 24,bottom: 32,left: 16,right: 16),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: MaterialButton(
                        height: 42,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text("تأكيد",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                        onPressed: (){
                          onPressedCompleated(singingCharacter);

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
    }

 static PayPalShowModalBottomSheet({context,checkoutUrl,returnURL,cancelURL,action}){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        SingingCharacter singingCharacter = SingingCharacter.paybal;
        return StatefulBuilder(

            builder: (context,setState){
              return Container(
                height: MediaQuery.of(context).size.height/1.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18,left: 16,right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: CustomSectionComponent.Section(context: context,text: "أكمل عملية الدفع",margin: EdgeInsets.only(top: 0,left: 0,right: 0),seeMore: false),
                          ),
                          Container(

                            child: IconButton(
                              icon: SvgPicture.asset("assets/icons/close.svg"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/1.4,
                      child: WebView(
                        initialUrl: checkoutUrl,
                        javascriptMode: JavascriptMode.unrestricted,
                        navigationDelegate: (NavigationRequest request) {

                          if (request.url.contains(returnURL)) {
                            final uri = Uri.parse(request.url.toString());
                            final payerID = uri.queryParameters['PayerID'];
                            if (payerID != null) {
                              action();

                              // if(Navigator.of(context).canPop()){
                              //   Navigator.of(context).pop();
                              // }

                            } else {

                              // if(Navigator.of(context).canPop()){
                              //   Navigator.of(context).pop();
                              // }
                            }


                          }
                          if (request.url.contains(cancelURL)) {

                            // if(Navigator.of(context).canPop()){
                            //   Navigator.of(context).pop();
                            // }
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }

 static ShowBusesModalBottomSheet({context,required Trip trip}){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height/1.5
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        return trip.litsBus.isNotEmpty?Container(
          child: ListView.builder(
              itemCount: trip.litsBus.length,
              itemBuilder: (context,index) {
                return CustomCard.CardInformationBus(context: context,bus: trip.litsBus[index], trip: trip);
              }
          ),
        ):Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          margin: EdgeInsets.only(top: 16,left: 16,right: 16),
          child: Text("لا يوجد باصات لعرضها",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.5),textAlign: TextAlign.center,),
        );
      },
    );
  }

 static CustomShowModalBottomSheetPaymentMethod({context}){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 18,left: 16,right: 16),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          child: CustomSectionComponent.Section(context: context,text: "طرق الدفع المضافة",margin: EdgeInsets.only(top: 0,left: 0,right: 0),seeMore: false),
                        ),
                        Container(

                          child: IconButton(
                            icon: SvgPicture.asset("assets/icons/close.svg"),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2.5,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context,index){
                          return Container(
                            margin: EdgeInsets.only(top: 16),
                            child:Row(
                              children: [

                                Container(
                                  margin: EdgeInsets.only(left: 16,right: 16),
                                  height: 20,
                                  width: 20,
                                  child: Transform.scale(
                                      scale: 1.20,

                                      child: Radio(
                                          activeColor: Theme.of(context).primaryColor,
                                          fillColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                                          materialTapTargetSize: MaterialTapTargetSize.padded,
                                          value: SingingCharacter.paybal,
                                          groupValue: SingingCharacter.VisaCard,
                                          onChanged: (SingingCharacter? value) {
                                            // setState(() {
                                            //   _character = value;
                                            // });
                                          }
                                      )),
                                ),
                                CustomCard.cardPaymentMethod(context: context,margin: EdgeInsets.zero,removeButton: false,width: -1)
                              ],
                            ),
                          );

                    }),
                  ),

                  Container(
                    width: (MediaQuery.of(context).size.width),
                    height: 42,
                    margin: EdgeInsets.only(top: 24,bottom: 0,left: 16,right: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: MaterialButton(
                      height: 42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("متابعة",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                      onPressed: (){
                        Navigator.of(context).pop();
                        CustomAlertDailog.CustomShowModalBottomSheetCompleatePayment(context: context);
                      },
                    ),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width),
                    height: 42,
                    margin: EdgeInsets.only(top: 16,bottom: 32,left: 16,right: 16),
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Theme.of(context).primaryColor)
                    ),
                    child: MaterialButton(
                      height: 42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("أضافة ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor,height: 1.4),),
                      onPressed: (){
                        Navigator.of(context).pop();
                        // CustomAlertDailog.CustomShowModalBottomSheet(context: context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


 static CustomShowModalBottomSheetCompleatePayment({context,descriotion,onPressedClose,onPressedHomePage}){
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 24,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 18,left: 16,right: 16),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset("assets/icons/close.svg"),
                      onPressed: (){
                        onPressedClose();

                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffE4FFE5)
                    ),
                    padding: EdgeInsets.all(9),
                    margin: EdgeInsets.only(top: 24),
                    alignment: Alignment.center,
                    child: Text("😍",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                  ),
                  Container(
                   
                    child: CustomSectionComponent.Section(context: context,text: "تم الدفع بنجاح",margin: EdgeInsets.only(top: 8,left: 0,right: 0),seeMore: false,crossAxisAlignment:CrossAxisAlignment.center,width: MediaQuery.of(context).size.width),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 16),
                      width: MediaQuery.of(context).size.width,
                      child:Text("$descriotion",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Color(0xffB7B7B7)),textAlign: TextAlign.center,),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width),
                    height: 42,
                    margin: EdgeInsets.only(top: 60,bottom: 32,left: 16,right: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: MaterialButton(
                      height: 42,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("العودة الى الصفحة الرئيسية",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'SansArabicLight',color:Colors.white,height: 1.4),),
                      onPressed: (){
                        onPressedHomePage();

                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}