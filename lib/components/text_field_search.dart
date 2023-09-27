import 'package:alaqsa/bloc/home_page/home_page_bloc.dart';
import 'package:alaqsa/bloc/home_page/home_page_event.dart';
import 'package:alaqsa/bloc/home_page/home_page_state.dart';
import 'package:alaqsa/components/custom_button.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';


class TextFiledSearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateTextFiledSearch();
  }

}

class StateTextFiledSearch extends State<TextFiledSearch> {
  TextEditingController search = new TextEditingController();
  GlobalState globalState = GlobalState.instance;
  final LayerLink layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  var isShoing = false;
  OverlayEntry overlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context){
          return Positioned(

              width: size.width,
              child: CompositedTransformFollower(
                link: layerLink,
                showWhenUnlinked: false,
                offset: Offset(0,size.height+8),

                child: BlocProvider(
                  create: (context) => HomePageBloc()..add(HomePageSearchCityEvent(search.text)),
                  child: BlocBuilder<HomePageBloc,HomePageState>(
                    builder: (context,state){
                      if(state is HomePageAutoCompleteLoaded) {
                        return Container(
                          height: state.autoComplete.length * 50,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 16,right: 16,top: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    offset: Offset(0,0),
                                    blurRadius: 4
                                ),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    offset: Offset(0,2),
                                    blurRadius: 4
                                ),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    offset: Offset(0,16),
                                    blurRadius: 6
                                )

                              ]
                          ),
                          child: ListView.builder(

                              padding: EdgeInsets.zero,
                              itemCount: state.autoComplete.length,
                              itemBuilder: (context,index){
                                return Container(
                                  child: Column(
                                    children: [
                                      CustomButton.buttonIconWithText(margin: EdgeInsets.only(top: 0,bottom: 0,left: 8,right: 8),padding: EdgeInsets.only(left: 8,right: 8),icon: "assets/icons/location.svg",title: "${state.autoComplete[index].toString().length>35?state.autoComplete[index].toString().substring(0,35):state.autoComplete[index].toString()}",onPressed: (){
                                        globalState.set("search",state.autoComplete[index]);
                                        Navigator.of(context).pushNamed("SearchPage");
                                      }),
                                      Container(
                                        margin: EdgeInsets.only(left: 14,right: 14),
                                        width: MediaQuery.of(context).size.width,
                                        height: 0,
                                        child: Divider(
                                          color: Color(0xffE5E5E5),
                                          thickness: 1,
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              }
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              )
          );
        }
    );
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      search.addListener(() {
        if(search.text.length>0){
          context.read<HomePageBloc>().add(HomePageSearchCityEvent(search.text));
          showOverloy();
        } else {
          if(_overlayEntry != null){
            _overlayEntry!.remove();
            isShoing = false;
          }

        }
      });
    });


  }

  showOverloy(){

    if( isShoing == false){
      OverlayState? overlayState = Overlay.of(context);
      _overlayEntry = overlayEntry();
      overlayState!.insert(_overlayEntry!);
      isShoing = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Container(
        margin: EdgeInsets.only(top: 24,left: 16,right: 16),
        height: 44,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Color(0xffCBCBCB).withOpacity(0.25),
                  offset: Offset(0,4),
                  blurRadius: 10
              )
            ]
        ),
        child: TextField(
          controller: search,
          style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Theme.of(context).primaryColor),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
              hintText:"البحث حسب المنطقة"+"...",
              hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'SansArabicLight',color:Color(0xffB7B7B7)),
              border: InputBorder.none,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              contentPadding: EdgeInsets.only(left: 14,right: 14,bottom: 10,top: 10),
              suffixIcon: Container(
                width: 45,
                height: 44,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/icons/search.svg",),
              )


          ),
        ),
      ),
    );
  }

}
