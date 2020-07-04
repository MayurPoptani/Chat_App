import 'package:chat_app/Database/functions.dart';
import 'package:chat_app/MainPagesScreen/screens/MainPagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.ralewayTextTheme(ThemeData.dark().textTheme),
        primaryTextTheme: GoogleFonts.ralewayTextTheme(ThemeData.dark().textTheme),
        bottomAppBarColor: ThemeData.dark().appBarTheme.color,
      ),
      home: MainPagesScreen(),
    );
  }
}