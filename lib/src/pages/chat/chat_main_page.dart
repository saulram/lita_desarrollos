import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/components/chat_tile_lita.dart';
import 'package:litadesarrollos/src/pages/chat/pages/add_participants.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class MainChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: DrawerLita(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Chat',
          style: GoogleFonts.sourceSansPro(),
        ),
      ),
      bottomNavigationBar: BottomLita(),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container()
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  child: Text(
                    'Crear Conversación',
                    style: GoogleFonts.sourceSansPro(
                        color: accentLita, fontWeight: FontWeight.w600,fontSize: 13),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddParticipants()));
                  },
                ),
              )
            ],
          ),
          Divider(),
          chatService.isloading ? Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int i) {
                  return Center(
                    child: CardSkeleton(
                      style: SkeletonStyle(
                        theme: SkeletonTheme.Light,
                        isShowAvatar: true,
                        isCircleAvatar: true,
                        borderRadius:
                        BorderRadius.all(Radius.circular(16.0)),
                        padding: EdgeInsets.all(32.0),
                        barCount: 2,
                        colors: [
                          Colors.grey[300],
                          Colors.grey[200],
                          Colors.grey[100]
                        ],
                        backgroundColor: Color(0xffffff),
                        isAnimation: true,

                      ),
                    ),
                  );
                }),
          ) : Expanded(
            child: ListView.builder(itemCount:chatService.chatList.chats.length,itemBuilder: (BuildContext cctx, int i) {
              return ChatTile(
                name:"${chatService.chatList.chats[i].name}",
                chatId:"${chatService.chatList.chats[i].id}",
                userId:"${chatService.loginResult.user?.id}",

              );
            }),
          )
        ],
      ),
    );
  }
}
