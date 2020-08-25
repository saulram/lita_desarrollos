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

class MainChatPage extends StatefulWidget {
  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var _chatService = Provider.of<ChatService>(context);

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
          _chatService.isloading ? Expanded(
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
            child: RefreshIndicator(onRefresh: _chatService.getChats,
              child: ListView.builder(itemCount:_chatService.chatList.chats.length ?? 0,itemBuilder: (BuildContext cctx, int i) {
                return ChatTile(
                  name:"${_chatService.chatList.chats[i].name}",
                  chatId:"${_chatService.chatList.chats[i].id}",
                  userId:"${_chatService.loginResult.user?.id}",

                );
              }),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  print('SE CIERRA EL CHAT');
  }
}
