import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_app/ChatMessagePage/ChatMessagePage.dart';

class ChatListItem extends StatefulWidget {
  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      leading: SizedBox(
        width: 60,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,),
        ),
      ),
      title: "Peter Parker".text.fontFamily(GoogleFonts.latoTextTheme().toString()).white.bold.size(16).make(),
      subtitle: "Sound good, when will you".text.fontFamily(GoogleFonts.latoTextTheme().toString()).white.italic.size(16).make(),
      trailing: "Aug 22".text.make(),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatMessagePage()));
      },
    );
  }
}