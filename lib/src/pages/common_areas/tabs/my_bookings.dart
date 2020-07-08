import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/pages/common_areas/widgets/my_books.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class MyBookingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonService>(context);
    return  RefreshIndicator(
      onRefresh: commonProvider.getMyReservations,
      child: Container(
        color: primaryLita,
        child: commonProvider.loading != true?  ListView.builder(physics:BouncingScrollPhysics(),itemCount:commonProvider.myBooks.myBookings != null ? commonProvider.myBooks.myBookings.length:0,itemBuilder: (BuildContext ctx , int i){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: MyBookCard(
              book: commonProvider.myBooks.myBookings[i],
            ),
          );
        }):Center(child: CircularProgressIndicator(),),
      ),
    );
  }
}
