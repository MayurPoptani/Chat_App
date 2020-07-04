import 'package:chat_app/ChatMessagePage/widgets/MessageWidget.dart';
import 'package:chat_app/Database/models/ChatItem.dart';
import 'package:chat_app/Database/models/MessageItem.dart';
import 'package:chat_app/Database/variables.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessagePage extends StatefulWidget {
  final ChatItem chatItem;
  const ChatMessagePage(this.chatItem, {Key key}) : super(key: key);
  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  
  TextEditingController inputController;
  List<MessageItem> msgs = [];
  
  @override
  void initState() {
    inputController = TextEditingController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateList(msgs.length);
    });
  }
  
  void updateList(int afterNumber) {
    db.query(MessageTable, 
      orderBy: MessageItem.DATETIME,
      groupBy: MessageItem.DATETIME+"",
      limit: 10, offset: afterNumber,
      where: MessageItem.RECIEVER_ID+"=?", whereArgs: [widget.chatItem.id],
    ).then((value) {
      msgs.insertAll(0, value.reversed.toList().map((e) => MessageItem.fromMap(e)).toList());
      if(mounted) setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            "Conversation with".text.bold.size(18).make().objectBottomLeft(),
            widget.chatItem.reciever.text.size(16).make().objectBottomLeft(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16),
                reverse: true,
                itemCount: msgs.length,
                itemBuilder: (_, i) {
                  return MessageWidget(msgs[i]);
                }
              ),
            ),
            messageInputWidget(),
          ],
        ),
      ),
    );
  }
  
  Widget messageInputWidget() {
    return TextFormField(
      controller: inputController,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.black, width: 0, style: BorderStyle.none)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        hintText: "Say something...",
        fillColor: Colors.black,
        filled: true,
        focusColor: Colors.white,
        suffixIcon: IconButton(icon: Icon(Icons.arrow_forward, color: Colors.white), onPressed: () async {
          await MessageItem.addMessageItem(db, widget.chatItem.id, inputController.text.trim());
          updateList(msgs.length);
        }),
      ),
    );
  }
  
  Widget appBar() {
    return AppBar(
      title: "Welcome".text.make(),
      centerTitle: true,
      actions: [
        Builder(
          builder: (_) => IconButton(icon: Icon(Icons.menu), onPressed: () {
            Scaffold.of(_).showSnackBar(SnackBar(content: "Dummy Menu Button".text.make(), behavior: SnackBarBehavior.floating, duration: Duration(milliseconds: 1000),));
          })
        ),
      ],
    );
  }
}