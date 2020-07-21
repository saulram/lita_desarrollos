import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/benefits/models/benefits_model.dart';
import 'package:litadesarrollos/src/pages/benefits/pages/view_benefit_qr.dart';
import 'package:litadesarrollos/src/pages/benefits/services/benefits_service.dart';

import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class BenefitDetail extends StatelessWidget {
  final Benefit object;

  const BenefitDetail({Key key, this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);
    final benefitService = Provider.of<BenefitsService>(context);

    return loginProvider.loginResult.user != null
        ? Scaffold(
            endDrawer: DrawerLita(),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Beneficios',
                style: GoogleFonts.sourceSansPro(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: primaryLita,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${object.title}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.network(
                    object.fullFile,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${object.title}',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${object.description}',
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Center(
                    child: CupertinoButton(
                      color: accentLita,
                      onPressed: () async {
                        bool benefit_created =
                            await benefitService.getQr(object.id);
                        if (benefit_created == true) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (_) => QRBenefit(
                                        code: benefitService
                                            .newBenefit.addExchange.code,
                                        codeUrl: benefitService
                                            .newBenefit.addExchange.codeUrl,
                                      )));
                        } else {
                          Alert.alert(context, title: 'Error al crear el QR');
                        }
                      },
                      child: Text('Crear Codigo QR'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                ],
              ),
            ),
          )
        : Scaffold();
  }
}
