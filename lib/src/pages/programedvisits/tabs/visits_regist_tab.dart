import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/pages/programedvisits/widgets/visits_card.dart';
import 'package:provider/provider.dart';

class VisitsRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final visits = Provider.of<VisitService>(context);
    if (visits.isloading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: visits.registrov.visits != null
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: visits.registrov.visits.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: VisitsCard
                      (
                      codeUrl: visits.registrov.visits[i].codeUrl,
                      code: visits.registrov.visits[i].code,
                      completeName: visits.registrov.visits[i].visitorsName,
                      type: visits.registrov.visits[i].typeFormat,
                      date: visits.registrov.visits[i].scheduleAtFormat,
                      until: visits.registrov.visits[i].untilDateFormat,
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    }
  }
}
