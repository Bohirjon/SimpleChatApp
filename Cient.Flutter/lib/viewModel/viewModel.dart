import 'dart:core';
import 'package:flutter2/models/message.dart';
import 'package:rxdart/subjects.dart';
import 'package:signalr_core/signalr_core.dart';

const List<int> retryPolicy = [
  2000,
  2000,
  2000,
];

class ViewModel {
  HubConnection _hubConnection;
  ViewModel() {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          "http://192.168.1.71:5001/chatting",
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ),
        )
        .withAutomaticReconnect()
        .build();
    _hubConnection.onclose(
        (exception) => statusSubject.add(ConnectionStatus.NotConnected));
    _hubConnection.onreconnected(
        (connectionId) => statusSubject.add(ConnectionStatus.Connected));
    _hubConnection.onreconnecting(
        (exception) => statusSubject.add(ConnectionStatus.Connecting));
    _hubConnection.on("ReceiveMessage", _onMessageReceive);
  }

  final list = <Message>[];
  void _onMessageReceive(arguments) {
    try {
      var listOfArgs = arguments as List;
      var message = listOfArgs.first;
      list.add(message);
    } catch (e) {
      print(e);
    }
    messagesSubject.sink.add(list);
  }

  final messageSubject = BehaviorSubject<String>();
  final statusSubject = BehaviorSubject.seeded(ConnectionStatus.NotConnected);
  final messagesSubject = PublishSubject<List<Message>>();

  connect() async {
    try {
      await _hubConnection.start();
      statusSubject.sink.add(ConnectionStatus.Connected);
    } catch (error) {
      print(error);
    }
  }

  disconnect() async {
    await _hubConnection.stop();
  }

  sendMessage() async {
    if (messageSubject.valueWrapper.value != null) {
      var message = Message();
      message.senderName = "Bohirjon Akhmedov";
      message.message = messageSubject.valueWrapper.value;
      _hubConnection
          .invoke("SendMessage", args: [messageSubject.valueWrapper.value]);
      messageSubject.add("");
      print("sent");
    } else {
      print("it was null");
    }
  }

  void dispose() {
    messageSubject.close();
    statusSubject.close();
    messagesSubject.close();
    _hubConnection.stop();
  }
}

enum ConnectionStatus { Connected, NotConnected, Connecting }
