import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class ChatName extends StatefulWidget {
  @override
  _ChatNameState createState() => _ChatNameState();
}

class _ChatNameState extends State<ChatName> {
  List _selectedParticipants = List();
  TextEditingController _controller = TextEditingController();

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
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Crear'),
          onPressed: () async {
            if (_controller.value.text != '' || _controller.value != null) {
              bool creado =
                  await chatService.createChat(_controller.value.text);
              if (creado == true) {
                int ok = await Alert.alert(context,
                    title: 'Listo',
                    content:
                        'El administrador debe autorizar el grupo. En breve te llegará una notificación',
                    ok: 'Entendido');
                if(ok == 0){

                  Navigator.pop(context);

                }


              }
            }
          },
          icon: Icon(FontAwesomeIcons.paperPlane)),
      body: Form(
        child: directoryService.loading
            ? Center()
            : Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .06),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Nombre'),
                      controller: _controller,
                      textInputAction: TextInputAction.done,
                      style: GoogleFonts.sourceSansPro(),
                    ),
                  ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: chatService.chatParticipants.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, int i) {
                          String image = '', name = '';
                          directoryService.residents.usersDirectory
                              .forEach((element) {
                            if (element.id == chatService.chatParticipants[i]) {
                              image = element.fullFile;
                              name = element.completeName;
                            }
                          });

                          return Container(
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width * .3,
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(image),
                                    ),
                                    Center(
                                      child: Text(
                                        '$name',
                                        style: GoogleFonts.sourceSansPro(),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  child: IconButton(
                                    onPressed: () {
                                      chatService.removeParticipant(
                                          chatService.chatParticipants[i]);
                                    },
                                    icon: Icon(CupertinoIcons.clear),
                                  ),
                                  top: (MediaQuery.of(context).size.height *
                                          .01) *
                                      -1,
                                  left: MediaQuery.of(context).size.width * .15,
                                )
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
      ),
    );
  }
}
