import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/components/chat_tile_lita.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class AddParticipants extends StatelessWidget {
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
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Text('Nuevo Chat',
                      style: GoogleFonts.sourceSansPro(
                          color: accentLita, fontWeight: FontWeight.w600)),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: FlatButton(
                  child: Text(
                    'Crear Grupo',
                    style: GoogleFonts.sourceSansPro(
                        color: accentLita, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          Divider(),
          chatService.isloading ? Expanded(
            child:AlphabetListScrollView(strList: null, indexedHeight: null),
          ) : Expanded(
            child: ListView.builder(itemCount:chatService.chatList.chats.length,itemBuilder: (BuildContext cctx, int i) {
              return ChatTile(
                  name:"${chatService.chatList.chats[i].name}",
                  chatId:"${chatService.chatList.chats[i].id}",
                  userId:"${chatService.loginResult.token}"
              );
            }),
          )
        ],
      ),
    );
  }
}
