import 'package:flutter/material.dart';
import 'viewModel/chatViewWidget.dart';

main(List<String> args) => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      home: ChatViewWidget(),
      debugShowCheckedModeBanner: true,
    );
  }
}
