import 'package:alaqsa/components/custom_card.dart';
import 'package:alaqsa/helper/GlobalState.dart';
import 'package:alaqsa/models/Trip.dart';
import 'package:alaqsa/models/donatione.dart';
import 'package:alaqsa/models/news.dart';
import 'package:alaqsa/models/project.dart';
import 'package:alaqsa/models/volunteer.dart';
import 'package:flutter/material.dart';



class CustomListView {

  static ListNews({required BuildContext context,controller,required List<News> listNews,bottom,shrinkWrap,physics,onRefresh,onPressed}){
    return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        onRefresh: (){
          return onRefresh();
        },
        child:ListView.builder(
        itemCount: listNews.length,
        shrinkWrap: shrinkWrap,
        physics: physics,
        controller: controller,
        padding: EdgeInsets.only(bottom: bottom),
        itemBuilder: (context,index){
          if(listNews.isNotEmpty) {
            return CustomCard.cardNews(context: context,news:listNews[index],index: index,onPressed: onPressed);
          } else {
            return Container();
          }

        }
    ));
  }



  static ListProjects({required BuildContext context,required List<Project> projects,controller,onRefresh,onPressed,onPressedVolunteer,bottom}){
    return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        onRefresh: (){
          return onRefresh();
        },
        child:ListView.builder(
        controller: controller,
        itemCount: projects.length,
        padding: EdgeInsets.only(bottom: bottom),
        itemBuilder: (context,index){
          return CustomCard.cardProjects(context: context,index: index,project: projects[index],onPressed: onPressed,onPressedVolunteer: onPressedVolunteer);
        }
    ));
  }

  static ListProfileProjects(List<Volunteer> volunteers){
    return ListView.builder(
        itemCount: volunteers.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          if(volunteers[index].project.id != null){

            return CustomCard.cardProfileProjects(context: context,index: index,volunteer:volunteers[index]);

          } else {
            return Container();
          }
        }
    );
  }


  static ListProfileDonations(List<Donatione> donations){
    return ListView.builder(
        itemCount: donations.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return CustomCard.cardStatistics(context: context,margin:  EdgeInsets.only(top: index ==0?0:12,left: 16,right: 16),title1: "نوع التبرع",value1: donations[index].sectorProject,title2: "تاريخ التبرع",value2:donations[index].donationDate,title3: "المبلغ المتبرع به",value3: donations[index].totalAmount.toString()+"شيقل ");

        }
    );
  }


  static ListTrips({context,controller,required List <Trip> tripList,bottom,onRefresh,onPressed,onPressedBookingAndCloseTrip}){
    return RefreshIndicator(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        onRefresh: (){
          return onRefresh();
        },
        child:ListView.builder(
        itemCount: tripList.length,
        padding: EdgeInsets.only(bottom: bottom),
        controller:controller ,
        itemBuilder: (context,index){
          return CustomCard.cardTrip(context: context,index: index,trip: tripList[index],onPressed: (index){onPressed(index);},onPressedBookingAndCloseTrip: onPressedBookingAndCloseTrip);
        }
    ));
  }


  static ListPaymentMethod({context,bottom,onPressed}){
    return ListView.builder(
        itemCount: 3,
        padding: EdgeInsets.only(bottom: bottom),
        itemBuilder: (context,index){
          return CustomCard.cardPaymentMethod(context: context);
        }
    );
  }

}