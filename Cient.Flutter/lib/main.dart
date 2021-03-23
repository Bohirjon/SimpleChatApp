import 'package:flutter/material.dart';
import 'pages/chatViewWidget.dart';

main(List<String> args) => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(
        primaryColor: Color.fromRGBO(69, 103, 191, 1),
        accentColor: Color.fromRGBO(69, 103, 191, 1),
        buttonColor: Color.fromRGBO(69, 103, 191, 1),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(69, 103, 191, 1),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color.fromRGBO(69, 103, 191, 1),
        ),
      ),
      home: ChatViewWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
