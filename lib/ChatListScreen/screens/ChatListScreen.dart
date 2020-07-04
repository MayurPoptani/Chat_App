import 'package:chat_app/ChatListScreen/widgets/ChatListItem.dart';
import 'package:chat_app/ChatMessagePage/screens/ChatMessagePage.dart';
import 'package:chat_app/Database/models/ChatItem.dart';
import 'package:chat_app/Database/variables.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatListScreen extends StatefulWidget {
  ChatListScreen({Key key}) : super(key: key);
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> with AutomaticKeepAliveClientMixin {
  
  List<ChatItem> chats = [];
  
  @override
  void initState() {
    super.initState();
    refreshChatsList();
  }
      
      @override
      Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
          body: Container(
            // padding: EdgeInsets.only(top: 32, left: 16, right: 16),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeightBox(32),
                ("Messages ("+(chats==null?0:chats.length.toString())+")").text.semiBold.size(18).make(),
                HeightBox(16),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: chats.length,
                    itemBuilder: (_, i) {
                      return ChatListItem(chats[i]);
                    } 
                  ),
                ),
              ],
            ),
          ),
        );
      }
      
      void refreshChatsList() async {
        db.query(ChatTable).then((value) {
          chats = (value.map((e) => ChatItem.fromMap(e))).toList();
          setState(() {});
        });
      }
    
      @override bool get wantKeepAlive => true;
    
  
}