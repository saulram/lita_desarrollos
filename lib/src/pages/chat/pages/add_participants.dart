import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/components/chat_tile_lita.dart';
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
  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selectedParticipants.add(category_id);
      });
    } else {
      setState(() {
        _selectedParticipants.remove(category_id);
      });
    }
  }
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
          directoryService.loading
              ? Center()
              : Expanded(
                  child: ListView.builder(
                      itemCount:
                          directoryService.residents.usersDirectory.length,
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
                          value: _selectedParticipants.contains(directoryService.residents.usersDirectory[i].id),
                          onChanged: (bool value) {

                            _onCategorySelected(value,
                                directoryService.residents.usersDirectory[i].id);

                          },
                        );
                      }),
                )
        ],
      ),
    );
  }
}
