import 'dart:async';

import 'package:chat_app/Database/models/ChatItem.dart';
import 'package:chat_app/Database/models/MessageItem.dart';
import 'package:chat_app/Database/variables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_app/ChatMessagePage/screens/ChatMessagePage.dart';

class ChatListItem extends StatefulWidget {
  final ChatItem chatItem;
  const ChatListItem(this.chatItem, {Key key}) : super(key: key);
  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  
  bool loadingLastMsg = true;
  MessageItem lastMsg;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => refreshLastMsg());
  }
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(60),
        child: Container(
          width: 56, height: 56,
          padding: EdgeInsets.only(top: 8),
          color: Colors.white,
          child: Hero(
            tag: widget.chatItem.id,
            child: Image.asset("assets/avatars/"+(widget.chatItem.id%6).toString()+".png"),
          ),
        ),
      ),
      title: Text(widget.chatItem.reciever.toString(), 
                  style: TextStyle(fontFamily: GoogleFonts.latoTextTheme().toString(), fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  softWrap: true, maxLines: 1, overflow: TextOverflow.clip,),
      subtitle: Text(loadingLastMsg?"Loading...":(lastMsg==null?"No Messages Yet":lastMsg.message),
                  style: TextStyle(fontFamily: GoogleFonts.latoTextTheme().toString(), fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
                  softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,),
      trailing: Text(loadingLastMsg?"":(lastMsg==null?"":DateFormat(DateFormat.ABBR_MONTH_DAY).format(lastMsg.dateTime)),
                  style: TextStyle(fontFamily: GoogleFonts.latoTextTheme().toString(), fontSize: 16, color: Colors.white),
                  softWrap: true, maxLines: 1, overflow: TextOverflow.clip,),
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChatMessagePage(widget.chatItem)));
        print("Refreshing List");
        refreshLastMsg();
      },
    );
  }
  
  void refreshLastMsg() async {
    try {
      db.rawQuery("SELECT * FROM "+MessageTable+" WHERE "+MessageItem.RECIEVER_ID+"="+widget.chatItem.id.toString()+" ORDER BY "+MessageItem.DATETIME+" DESC LIMIT 1")
      .then((value) {
        if(value==null || value.length==0) {}
        else lastMsg = MessageItem.fromMap(value.last);
        setState(() => loadingLastMsg = false);
      });
    } on DatabaseException catch (e) {
      print("DatabaseException E = "+e.toString());
      setState(() => loadingLastMsg = false);
    } on Exception catch (e) {
      print("UnknownException E = "+e.toString());
      setState(() => loadingLastMsg = false);
    }
  }
}