import 'dart:async';

import 'package:alaqsa/bloc/login/login_bloc.dart';
import 'package:alaqsa/bloc/login/login_state.dart';
import 'package:alaqsa/bloc/register/register_bloc.dart';
import 'package:alaqsa/bloc/register/register_event.dart';
import 'package:alaqsa/bloc/register/register_state.dart';
import 'package:alaqsa/components/CustomAlertDailog.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/components/custom_text_field.dart';
import 'package:alaqsa/helper/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateRegister();

  }
}

class StateRegister extends State<Register> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController password = TextEditingController();

  List<String> items = [];
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    _fetchCities();
  }

  List<Map<String, dynamic>> cities = [];
  int? _selectedCityId;


  Future<void> _fetchCities() async {
    var api = '${Config.BaseUrl}${Config.getCities}';
    final response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('cities')) {
        final List<dynamic> fetchedCities = data['cities'];
        setState(() {
          cities = fetchedCities.map((city) => {
            'id': city['id'],
            'name': city['name']
          }).toList();
          items = cities.map((city) => city['name'] as String).toList();
        });
      } else {
        // Handle the error
        print('Cities key not found in the response');
      }
    } else {
      // Handle the error
      print('Failed to load cities');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => RegisterBloc()),
          BlocProvider(create: (context) => LoginBloc()),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterInitial) {
                  if (!Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      size: 35.0,
                      message: "الرجاء الأنتظار",
                      type: 1,
                      height: 96.0,
                    );
                  }
                }
                if (state is RegisterLoaded) {
                  if (Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("MainPage", (route) => false);
                  }
                }
                if (state is RegisterErroe) {
                  if (Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                  if (!Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = true;
                    String errorMessage = state.error['general'] ?? "خطأ";

                    String nameError = state.error['name'] ?? "";
                    String emailError = state.error['email'] ?? "";
                    String phone = state.error['phone'] ?? "";
                    String passwordError = state.error['password'] ?? "";

                    List<String> errorMessages = [];
                    if (nameError.isNotEmpty) errorMessages.add(nameError);
                    if (emailError.isNotEmpty) errorMessages.add(emailError);
                    if (phone.isNotEmpty) errorMessages.add(phone);
                    if (passwordError.isNotEmpty)
                      errorMessages.add(passwordError);

                    if (errorMessages.isNotEmpty) {
                      errorMessage = errorMessages.join("\n");
                    }

                    CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Colors.red,
                      size: 35.0,
                      message: errorMessage,
                      type: 3,
                      height: 200.0,
                    );
                    Timer(Duration(seconds: 1), () {
                      if (Config.isShowingLoadingDialog) {
                        Config.isShowingLoadingDialog = false;
                        Navigator.of(context).pop();
                      }
                    });
                  }
                }
                if (state is CitiesLoaded) {
                  setState(() {
                    print(state);
                    items = state.cities;
                  });
                }
              },
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) async {
                if (state is LoginInitial) {
                  if (!Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Theme.of(context).primaryColor,
                      size: 35.0,
                      message: "الرجاء الأنتظار",
                      type: 1,
                      height: 96.0,
                    );
                  }
                }
                if (state is LoginLoaded) {
                  if (Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil("MainPage", (route) => false);
                  }
                }
                if (state is LoginErroe) {
                  if (Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = false;
                    Navigator.of(context).pop();
                  }
                  if (!Config.isShowingLoadingDialog) {
                    Config.isShowingLoadingDialog = true;
                    CustomAlertDailog.CustomLoadingDialog(
                      context: context,
                      color: Colors.red,
                      size: 35.0,
                      message: "الايميل او كلمة السر غير صحيحات",
                      type: 3,
                      height: 117.0,
                    );
                    Timer(Duration(seconds: 1), () {
                      if (Config.isShowingLoadingDialog) {
                        Config.isShowingLoadingDialog = false;
                        Navigator.of(context).pop();
                      }
                    });
                  }
                }
              },
            ),
          ],
          child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "assets/images/backgound.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 40, left: 0),
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                child: const Text(
                                  "تخطي",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SansArabicLight',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed("MainPage");
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 0),
                              child: Image.asset("assets/images/iconApp.png"),
                            ),
                            CustomTextField.TextFieldWithTitle(
                              controller: name,
                              title: "اسم المستخدم",
                              hintText: "اسم المستخدم",
                              obscureText: false,
                              borderColor: Colors.white,
                              margin: EdgeInsets.only(top: 32),
                            ),
                            CustomTextField.TextFieldWithTitle(
                              controller: email,
                              title: "البريد الالكتروني",
                              hintText: "البريد الالكتروني او رقم الجوال",
                              obscureText: false,
                              borderColor: Colors.white,
                              margin: EdgeInsets.only(top: 14),
                            ),
                            CustomTextField.TextFieldWithTitle(
                              controller: phone_number,
                              title: "رقم الهاتف",
                              hintText: "رقم الهاتف",
                              obscureText: false,
                              borderColor: Colors.white,
                              margin: EdgeInsets.only(top: 14),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 14),
                              child: DropdownSearch<String>(
                                items: items,
                                selectedItem: _selectedItem,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    filled: false,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                    hintText: "ابحث عن البلد",
                                    labelText: "البلد",
                                    labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                                    suffixIcon: null, // Remove the default suffix icon (arrow)
                                  ),
                                ),
                                popupProps: PopupProps.menu(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),

                                      hintText: "بحث",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                                      ),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  menuProps: MenuProps(
                                    backgroundColor: Colors.green.withOpacity(0.98),
                                  ),
                                  itemBuilder: (context, item, isSelected) {
                                    // Check if items list is empty
                                    if (items.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "لا توجد بيانات", // "No data found" in Arabic
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    }
                                    // Regular item builder
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.white : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.white, width: 1.5),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected ? Colors.black : Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                dropdownBuilder: (context, selectedItem) {
                                  return Container(
                                    width: double.infinity, // Make the container full width
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white, width: 1),
                                    ),
                                    child: Text(
                                      selectedItem ?? "ابحث عن البلد",
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  );
                                },
                                onChanged: (selectedItem) {
                                  setState(() {
                                    _selectedItem = selectedItem;
                                    // Ensure the selected city name is matched to the city ID
                                    final selectedCity = cities.firstWhere(
                                          (city) => city['name'] == selectedItem,
                                      orElse: () => {'id': 0, 'name': ''}, // Provide a default value if not found
                                    );
                                    _selectedCityId = int.tryParse(selectedCity['id'].toString()) ?? 0; // Use int type
                                  });
                                },
                              ),
                            ),

                            CustomTextField.TextFieldWithTitle(
                              controller: password,
                              title: "كلمة المرور",
                              hintText: "كلمة المرور",
                              obscureText: true,
                              borderColor: Colors.white,
                              margin: EdgeInsets.only(top: 14),
                            ),
                            CustomButton.customButton1(
                              context: context,
                              visibleIcon: false,
                              textButton: "تسجيل",
                              iconButton: "",
                              top: 24.0,
                              bottom: 0.0,
                              onPressed: () {
                                context.read<RegisterBloc>()
                                  ..add(RegisterApiEvent(name.text, email.text,
                                      phone_number.text, password.text,_selectedCityId));
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 0.75,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 7, right: 7),
                                    child: Text(
                                      "أو",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'SansArabicLight',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Divider(
                                      color: Colors.white,
                                      thickness: 0.75,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(bottom: 32),
                              child: Center(
                                child: TextButton(
                                  child: Text(
                                    "هل لديك حساب؟ سجل الان",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: "SansArabicLight",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
