import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/chat/pages/chat_detail.dart';
import 'package:litadesarrollos/src/theme/theme.dart';

class ChatTile extends StatelessWidget {
  final String image, name, chatId, userId;

  const ChatTile({
    Key key,
    this.image,
    this.name,
    this.chatId,
    this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatDetailPage(
              token: userId,
              chatId: chatId,
              userId: userId,
              chatName: name,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: primaryLita,
        child: Center(
          child: Text(
            '${name.substring(0, 1)}',
            style: GoogleFonts.sourceSansPro(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ),
      ),
      title: Text(
        name,
        style: GoogleFonts.sourceSansPro(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
