import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter2/viewModel/viewModel.dart';
import 'package:flutter2/extensions/connectionStatusToStringExtension.dart';

class ChatViewWidget extends StatelessWidget {
  final _vieWModel = ViewModel();

  ChatViewWidget() {
    _vieWModel.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Text(""),
      ),
      appBar: AppBar(
        title: Column(
          children: [
            Text("Chat app"),
            StreamBuilder(
              stream: _vieWModel.statusSubject,
              builder: (context, AsyncSnapshot<ConnectionStatus> snapshot) {
                return Text(
                  snapshot.data.getString(),
                  style: TextStyle(fontSize: 10),
                );
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          _getChatListView(context),
          _getSenderWiget(context),
        ],
      ),
    );
  }

  _getSenderWiget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.camera_alt_rounded),
          onPressed: () {},
        ),
        Expanded(
          child: Container(
            height: 30,
            child: TextField(
              onChanged: _vieWModel.messageSubject.sink.add,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                hintText: "Start typing...",
                filled: true,
                hintStyle: TextStyle(
                  color: Color.fromRGBO(194, 194, 194, 1),
                ),
                fillColor: Color.fromRGBO(238, 238, 238, 1),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(13)),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            _vieWModel.sendMessage();
            FocusScope.of(context).unfocus();
          },
        ),
      ],
    );
  }

  _getChatListView(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _vieWModel.messagesSubject.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var message = snapshot.data[index];
                return _getChatItemWidget(message);
              },
            );
          } else {
            return StreamBuilder<Object>(
                stream: _vieWModel.messageSubject.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data);
                  } else {
                    return Text("asd");
                  }
                });
          }
        },
      ),
    );
  }

  _getChatItemWidget(String message) {
    return Container(
      height: 24,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.grey,
      child: Text(message),
    );
  }
}
