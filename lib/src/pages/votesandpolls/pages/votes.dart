import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/votes_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class VotesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final voteService = Provider.of<VoteService>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: voteService.getVotationsFc,
            child: Container(
              height: MediaQuery.of(context).size.height*.7,
              child: voteService.loading == true ? Center(child: CircularProgressIndicator(),):ListView.builder(

                itemBuilder: (BuildContext context, int index) {
                  if (voteService.votations.votes[index].alreadyAnswer == true) {
                    return Padding(
                      padding:  EdgeInsets.all(MediaQuery.of(context).size.height*.02),
                      child: Column(
                        children: <Widget>[


                          Text(
                            'Resultados de la votación anterior: \n ${voteService.votations.votes[index].title}\n',
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(child: Text('Sí'),width: MediaQuery.of(context).size.width*.05,),
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: FAProgressBar(
                                  currentValue:
                                      voteService.votations.votes[index].percent.upVote,
                                  displayText: '%',
                                  size: MediaQuery.of(context).size.width * .1,
                                  direction: Axis.horizontal,
                                  maxValue: 100,
                                  borderRadius: 0,
                                  backgroundColor: Colors.white,
                                  progressColor: HexColor(voteService
                                      .loginResult.user.residency.theme.mainColor),
                                  changeProgressColor: accentLita,
                                  animatedDuration: Duration(milliseconds: 500),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(child: Text('No'),width: MediaQuery.of(context).size.width*.05),
                              Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: FAProgressBar(
                                  currentValue:
                                      voteService.votations.votes[index].percent.downVote,
                                  displayText: '%',
                                  size: MediaQuery.of(context).size.width * .1,
                                  direction: Axis.horizontal,
                                  maxValue: 100,
                                  borderRadius: 0,
                                  backgroundColor: Colors.white,
                                  progressColor: Colors.grey,
                                  changeProgressColor: accentLita,
                                  animatedDuration: Duration(milliseconds: 500),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                          Row(
                            children: <Widget>[
                              Text('Votación cerrada el: ${voteService.votations.votes[index].expiresAtFormat}',style: GoogleFonts.sourceSansPro(),),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.01,),
                          Divider()
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        Text(
                          '${voteService.votations.votes[index].title}',
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
                                      groupValue: voteService.option,
                                      onChanged: (value) {
                                        voteService.option = value;
                                        voteService.trueAnswer = true;
                                        voteService.falseAnswer = false;
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Text('Si'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      value: 1,
                                      groupValue: voteService.option,
                                      onChanged: (value) {
                                        voteService.option = value;
                                        voteService.trueAnswer = false;
                                        voteService.falseAnswer = true;
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text('No'),
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
                                bool answer = false;
                                if (voteService.option == 0) {
                                  answer = true;
                                } else {
                                  answer = false;
                                }
                                voteService.voteFunction(
                                    voteService.votations.votes[index].id, answer);
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
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: <Widget>[
                              Text('Votación valida hasta el: ${voteService.votations.votes[index].expiresAtFormat}',style: GoogleFonts.sourceSansPro(),),
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );

                  }
                },
                itemCount:voteService.votations.votes!= null ?  voteService.votations.votes.length : 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
