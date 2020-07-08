import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/polls_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class PollsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pollsService = Provider.of<PollService>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: pollsService.getPollsFc,
            child: Container(
              height: MediaQuery.of(context).size.height * .7,
              child:pollsService.loading == true ? Center(child: CircularProgressIndicator(),): ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (pollsService.listOfPolls.polls[index].alreadyAnswer ==
                      true) {
                    return Column(
                      children: <Widget>[
                        Text(
                          'Resultados de votación anterior: \n ${pollsService.listOfPolls.polls[index].question}',
                          style: GoogleFonts.sourceSansPro(
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              child: Text(
                                  '${pollsService.listOfPolls.polls[index].firstOption.answer}'),
                              width: MediaQuery.of(context).size.width * .15,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .7,
                              child: FAProgressBar(
                                currentValue: pollsService
                                    .listOfPolls.polls[index].percent.firstOption,
                                displayText: '%',
                                size: MediaQuery.of(context).size.width * .1,
                                direction: Axis.horizontal,
                                maxValue: 100,
                                borderRadius: 0,
                                backgroundColor: Colors.white,
                                progressColor: HexColor(pollsService
                                    .loginResult.user.residency.theme.mainColor),
                                changeProgressColor: accentLita,
                                animatedDuration: Duration(milliseconds: 500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                child: Text( '${pollsService.listOfPolls.polls[index].secondOption.answer}'),
                                width: MediaQuery.of(context).size.width * .15),
                            Container(
                              width: MediaQuery.of(context).size.width * .7,
                              child: FAProgressBar(
                                currentValue: pollsService.listOfPolls
                                    .polls[index].percent.secondOption,
                                displayText: '%',
                                size: MediaQuery.of(context).size.width * .1,
                                direction: Axis.horizontal,
                                maxValue: 100,
                                borderRadius: 0,
                                backgroundColor: Colors.white,
                                progressColor:Colors.grey,
                                changeProgressColor: accentLita,
                                animatedDuration: Duration(milliseconds: 500),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                child: Text( '${pollsService.listOfPolls.polls[index].thirdOption.answer}'),
                                width: MediaQuery.of(context).size.width * .15),
                            Container(
                              width: MediaQuery.of(context).size.width * .7,
                              child: FAProgressBar(
                                currentValue: pollsService.listOfPolls
                                    .polls[index].percent.thirdOption,
                                displayText: '%',
                                size: MediaQuery.of(context).size.width * .1,
                                direction: Axis.horizontal,
                                maxValue: 100,
                                borderRadius: 0,
                                backgroundColor: Colors.white,
                                progressColor: HexColor(pollsService
                                    .loginResult.user.residency.theme.mainColor),
                                changeProgressColor: accentLita,
                                animatedDuration: Duration(milliseconds: 500),
                              ),
                            )
                          ],
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Text(
                          '${pollsService.listOfPolls.polls[index].question}',
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 0,
                                      groupValue: pollsService.option,
                                      onChanged: (value) {
                                        pollsService.option = value;
                                        pollsService.trueAnswer = true;
                                        pollsService.falseAnswer = false;
                                      },
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * .2,
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                          '${pollsService.listOfPolls.polls[index].firstOption.answer}'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: pollsService.option,
                                      onChanged: (value) {
                                        pollsService.option = value;
                                        pollsService.trueAnswer = false;
                                        pollsService.falseAnswer = true;
                                      },
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * .2,
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                          '${pollsService.listOfPolls.polls[index].secondOption.answer}'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 2,
                                      groupValue: pollsService.option,
                                      onChanged: (value) {
                                        pollsService.option = value;
                                        pollsService.trueAnswer = false;
                                        pollsService.falseAnswer = true;
                                      },
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * .2,
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                          '${pollsService.listOfPolls.polls[index].thirdOption.answer}'),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .1,
                            ),
                            OutlineButton(
                              onPressed: () {
                                int answer = 0;
                                if (pollsService.option == 0) {
                                  answer = 1;
                                } else if (pollsService.option == 1) {
                                  answer = 2;
                                } else {
                                  answer = 3;
                                }
                                pollsService.voteFunction(
                                    pollsService.listOfPolls.polls[index].id,
                                    answer);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              borderSide: BorderSide(color: accentLita),
                              child: Text(
                                'Votar',
                                style: GoogleFonts.sourceSansPro(
                                    color: accentLita,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )
                      ],
                    );

                  }
                },
                itemCount: pollsService.listOfPolls.polls!= null ? pollsService.listOfPolls.polls.length:0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
