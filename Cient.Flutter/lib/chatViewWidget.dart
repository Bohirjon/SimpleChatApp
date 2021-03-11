import 'package:flutter/material.dart';
import 'package:flutter2/viewModel/viewModel.dart';

class ChatViewWidget extends StatelessWidget {
  final _vieWModel = ViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat app"),
        leading: StreamBuilder(
          stream: _vieWModel.statusSubject.stream,
          builder: (context, snapshot) => _getStatusWidget(snapshot.data),
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

  _getStatusWidget(ConnectionStatus connectionStatus) {
    switch (connectionStatus) {
      case ConnectionStatus.Connecting:
        return Text("Connecting");
        break;
      case ConnectionStatus.NotConnected:
        return IconButton(
          icon: Icon(Icons.refresh),
          onPressed: _vieWModel.connect,
        );
      case ConnectionStatus.Connected:
        return Icon(Icons.connect_without_contact_outlined);
    }
    return Text(connectionStatus.toString());
  }

  _getSenderWiget(BuildContext context) {
    return Text("data");
  }

  _getChatListView(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _vieWModel.messagesSubject.stream,
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                var message = snapshot.data[index];
                return _getChatItemWidget(message);
              },
            );
          } else {
            return Text("Empty");
          }
        },
      ),
    );
  }

  _getChatItemWidget(String message) {
    return ListTile(
      title: Text(message),
    );
  }
}
