import 'dart:async';
import 'dart:convert';

import 'package:alaqsa/bloc/donation_page/donation_page_bloc.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_event.dart';
import 'package:alaqsa/bloc/donation_page/donation_page_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/CustomSectionComponent.dart';
import 'package:alaqsa/components/composite_text.dart';
import 'package:alaqsa/components/custom_nav_bar.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;


class DonationSummaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateDonationSummaryPage();
  }
}

class StateDonationSummaryPage extends State<DonationSummaryPage> {
  TextEditingController amountText = TextEditingController();
  TextEditingController numberOfPeople = TextEditingController();

  TextEditingController nameCard = TextEditingController();
  TextEditingController numberCard = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  TextEditingController cvv = TextEditingController();

  var sector = "";
  var amount = "";
  var isTrip = false;
  var trip;
  var project;
  var user;
  var apkSettings;


  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchDonationInformation() async {
    final url = Uri.parse('https://aqsana.org/appsettings');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = response.body;
        setState(() {
          minimumDonationAmount = data;
        });
      } else {
        throw Exception("Failed to fetch donation information");
      }
    } catch (error) {
      print("Error fetching donation information: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) {
            return DonationPageBloc()..add(DonationPageInitialEvent());
          },
          child: BlocListener<DonationPageBloc, DonationPageState>(
            listener: (context, state) {
              if (state is DonationPageLoaded) {
                if (state.trip != null) {
                  isTrip = true;
                  sector = "قوافل الأقصى/رحلات";
                  trip = state.trip;
                }

                if (state.project != null) {
                  isTrip = false;
                  sector = state.project.sector;
                  project = state.project;
                }

                user = state.user;
                 apkSettings = state.apkSettings;
              }

              if (state is DonationChangePrice) {
                amount = state.price;
              }

              if (state is DonationPageInitial) {
                if (Config.isShowingLoadingDialog == false) {
                  Config.isShowingLoadingDialog = true;
                  CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      size: 35.0,
                      message: "الرجاء الأنتظار",
                      type: 1,
                      height: 96.0);
                }
              }

              if (state is DonationRequestApiLoaded) {
                if (Config.isShowingLoadingDialog == true) {
                  Config.isShowingLoadingDialog = false;
                  Navigator.of(context).pop();
                }
                if (state.responseCode == 200) {
                  Navigator.of(context).pop();
                  var description = "";
                  if (isTrip) {
                    description =
                        "تم التبرع للرحلة بقيمة " + amountText.text + " شيقل";
                  } else {
                    description =
                        "تم التبرع للمشروع بقيمة " + amountText.text + " شيقل";
                  }
                  CustomAlertDailog.CustomShowModalBottomSheetCompleatePayment(
                      context: context,
                      descriotion: description,
                      onPressedClose: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "MainPage", (route) => false);
                      },
                      onPressedHomePage: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "MainPage", (route) => false);
                      });
                } else {
                  if (Config.isShowingLoadingDialog == false) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(
                        context: context,
                        color: Colors.red,
                        size: 35.0,
                        message: "حدث خطأ",
                        type: 3,
                        height: 100.0);
                    Timer(Duration(seconds: 1), () {
                      if (Config.isShowingLoadingDialog == true) {
                        Config.isShowingLoadingDialog = false;
                        Navigator.of(context).pop();
                      }
                    });
                  }
                }
              }

              if (state is PaypalPaymentState) {
                if (Config.isShowingLoadingDialog == true) {
                  Config.isShowingLoadingDialog = false;
                  Navigator.of(context).pop();
                }
                CustomAlertDailog.PayPalShowModalBottomSheet(
                    context: context,
                    checkoutUrl: state.checkoutUrl,
                    returnURL: state.returnURL,
                    cancelURL: state.cancelURL,
                    action: () {
                      context.read<DonationPageBloc>().add(
                          DonationPageRequestApiEvent(
                              isTrip == true ? trip.id : project.id,
                              isTrip ? 2 : 1,
                              "",
                              amountText.text,
                              user != null ? user.name : "unkown",
                              numberOfPeople.text,
                              nameCard.text,
                              numberCard.text,
                              expiryDate.text,
                              cvv.text));
                    });
              }

              if (state is DonationPageErroe) {
                if (Config.isShowingLoadingDialog == true) {
                  Config.isShowingLoadingDialog = false;
                  Navigator.of(context).pop();
                }
                if (Config.isShowingLoadingDialog == false) {
                  Config.isShowingLoadingDialog = true;
                  CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Colors.red,
                      size: 35.0,
                      message: " الرجاء التاكد من قيمة المبلغ ",
                      type: 3,
                      height: 100.0);
                  Timer(Duration(seconds: 3), () {
                    if (Config.isShowingLoadingDialog == true) {
                      Config.isShowingLoadingDialog = false;
                      Navigator.of(context).pop();
                    }
                  });
                }
              }
            },
            child: BlocBuilder<DonationPageBloc, DonationPageState>(
              builder: (context, state) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 94,
                        child: CustomNavBar.customNaveBar(
                            context: context, title: "الدفع"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                        width: MediaQuery.of(context).size.width,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSectionComponent.Section(
                                context: context,
                                text: "موجز التبرع",
                                margin: EdgeInsets.only(
                                    top: 18, left: 16, right: 16),
                                seeMore: false),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: Text(
                                  "نوع التبرع: " + "تبرع " + sector.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SansArabicLight',
                                      color: Color(0xff101426))),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: Text(
                                  "المبلغ المدفوع: " +
                                      amount.toString() +
                                      " " +
                                      "شيقل",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SansArabicLight',
                                      color: Color(0xff101426))),
                            ),
                            Container(
                              child:
                                  CustomTextField.TextFieldWithTitleAndBorder(
                                      controller: amountText,
                                      width: MediaQuery.of(context).size.width -
                                          50,
                                      margin: EdgeInsets.only(
                                          left: 16, right: 16, top: 24),
                                      title: "قيمة المبلغ المدفوع",
                                      hintText: "الرجاء ادخال قيمة التبرع",
                                      obscureText: false,
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      onChanged: (text) {
                                        context.read<DonationPageBloc>().add(
                                            DonationPageTextEditionTotalAmountEvent(
                                                amountText.text));
                                      }),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 20, top: 12),
                              child: Text(
                                " ${apkSettings != null && apkSettings['donation'] != null ? apkSettings['donation'] : 'جار التحميل...'} ",
                                // "الحد الادنى للتبرع ${minimumDonationAmount} شيكل للشخص",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'SansArabicLight',
                                    color: Color(0xff101426)),
                              ),
                            ),
                            if (isTrip)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    top: 42, bottom: 32, left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              38,
                                      height: 42,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: MaterialButton(
                                        height: 42,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          "متابعة",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SansArabicLight',
                                              color: Colors.white,
                                              height: 1.4),
                                        ),
                                        onPressed: () {
                                          // CustomAlertDailog.CustomShowModalBottomSheetPaymentMethod(context: context);
                                          CustomAlertDailog
                                              .CustomShowModalBottomSheet(
                                                  context: context,
                                                  onPressedCompleated:
                                                      (singingCharacter) {
                                                    if (singingCharacter ==
                                                        SingingCharacter
                                                            .paybal) {
                                                      context
                                                          .read<
                                                              DonationPageBloc>()
                                                          .add(PaypalPaymentEvent(
                                                              isTrip == true
                                                                  ? trip
                                                                      .nameProject
                                                                  : project
                                                                      .nameProject,
                                                              amountText.text,
                                                              numberOfPeople
                                                                  .text));
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      if (true) {
                                                      } else {
                                                        if (Config
                                                                .isShowingLoadingDialog ==
                                                            false) {
                                                          Config.isShowingLoadingDialog =
                                                              true;
                                                          CustomAlertDailog
                                                              .CustomLoadingDialog(
                                                                  context:
                                                                      context,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 35.0,
                                                                  message:
                                                                      "يجب ملئ جميع الحقول",
                                                                  type: 3,
                                                                  height:
                                                                      117.0);
                                                          Timer(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            if (Config
                                                                    .isShowingLoadingDialog ==
                                                                true) {
                                                              Config.isShowingLoadingDialog =
                                                                  false;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          });
                                                        }
                                                      }
                                                    }
                                                  });
                                        },
                                      ),
                                    ),
                                    Container(
                                      height: 42,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2) -
                                              38,
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
                                          "الغاء",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'SansArabicLight',
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 1.4),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
