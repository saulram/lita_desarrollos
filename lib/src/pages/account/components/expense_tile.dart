import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/account/models/expenses_model.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpenseTile extends StatelessWidget {
  final IncomesExpense object;

  const ExpenseTile({Key key, this.object}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*.1,
      color:Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Text('${object.concept.title}',style: GoogleFonts.sourceSansPro(),),
                object.incomeFullFile!= null && object.incomeFullFile != ""?
                    FlatButton(
                      onPressed: (){
                        _launchURL(object.incomeFullFile);


                      },
                      child: Text(
                        'Descargar comprobante',style: GoogleFonts.sourceSansPro(fontSize: 10,color: accentLita),
                      ),
                    ):
                    Container()

              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children: <Widget>[
                Text('${object.amount} ',style: GoogleFonts.sourceSansPro(
                  color: object.overdue == true ? Colors.red : object.movementType=='adeudo' ? Colors.black : primaryLita
                )),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Text('${object.termPaidDateFormat}',style: GoogleFonts.sourceSansPro(fontSize: 12),),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _launchURL(url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
