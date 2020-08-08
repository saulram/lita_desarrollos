import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/pages/group_name.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class AddParticipants extends StatefulWidget {
  @override
  _AddParticipantsState createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {
  List _selectedParticipants = List();

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    final directoryService = Provider.of<DirectoryService>(context);
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => ChatName()));
          },
          child: Icon(FontAwesomeIcons.chevronRight)),
      body: Column(
        children: <Widget>[
          directoryService.loading
              ? Center()
              : Expanded(
                  child: ListView.builder(
                      itemCount:
                          directoryService.residents.usersDirectory != null
                              ? directoryService.residents.usersDirectory.length
                              : 0,
                      itemBuilder: (BuildContext cctx, int i) {
                        return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.platform,
                          title: Text(directoryService
                              .residents.usersDirectory[i].completeName),
                          secondary: CircleAvatar(
                            backgroundColor: primaryLita,
                            backgroundImage: NetworkImage(directoryService
                                .residents.usersDirectory[i].fullFile),
                          ),
                          value: chatService.chatParticipants.contains(
                              directoryService.residents.usersDirectory[i].id),
                          onChanged: (bool value) {
                            chatService.onCategorySelected(
                                value,
                                directoryService.residents.usersDirectory[i].id,
                                context);
                          },
                        );
                      }),
                )
        ],
      ),
    );
  }
}
