import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/account/components/expense_tile.dart';
import 'package:litadesarrollos/src/pages/account/models/expenses_model.dart';
import 'package:litadesarrollos/src/pages/account/services/expenses_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';

import 'package:provider/provider.dart';

class PaidTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final incomeService = Provider.of<ExpensesService>(context);
    ExpansesList list = ExpansesList();
    list.incomesExpenses=[];
    incomeService.expanse.incomesExpenses.forEach((element) {
      if(element.overdue == false && element.movementType == 'ingreso'){
        print(element.toString());
        list.incomesExpenses.add(element);
      }
    });
    if (incomeService.loading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: list.incomesExpenses != null
            ? Column(
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Gracias por tu pago.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Por pagar ',style: GoogleFonts.sourceSansPro()),
                      DotsIndicator(dotsCount: 1,decorator: DotsDecorator(color: Colors.black,activeColor: Colors.black),)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Pagados ',style: GoogleFonts.sourceSansPro()),
                      DotsIndicator(dotsCount: 1,decorator: DotsDecorator(color: Colors.black,activeColor: primaryLita),)
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Vencidos ',style: GoogleFonts.sourceSansPro()),
                      DotsIndicator(dotsCount: 1,decorator: DotsDecorator(color: Colors.black,activeColor: Colors.red),)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.05),
              height: MediaQuery.of(context).size.height*.04,
              color:Colors.grey[300],
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Concepto',style: GoogleFonts.sourceSansPro(),),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Cantidad ',style: GoogleFonts.sourceSansPro()),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Fecha de Pago ',style: GoogleFonts.sourceSansPro()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(

                onRefresh: incomeService.getEmergency,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),

                  itemCount: list.incomesExpenses.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    return ExpenseTile(object: list.incomesExpenses[i],);
                  },
                ),
              ),
            ),
          ],
        )
            : Center(
          child: Text('Aún no hay registro'),
        ),
      );
    }
  }
}
