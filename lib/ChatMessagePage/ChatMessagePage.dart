import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessagePage extends StatefulWidget {
  @override
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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