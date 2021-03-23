import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:signalr_core/signalr_core.dart';

class ViewModel {
  HubConnection _hubConnection;
  ViewModel() {
    _hubConnection = HubConnectionBuilder()
        .withUrl("http://192.168.1.43:5001/chatting", HttpConnectionOptions())
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

  final list = <String>[];
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
  final messagesSubject = PublishSubject<List<String>>();

  connect() async {
    try {
      await _hubConnection.start();
    } catch (error) {
      print(error);
    }
  }

  disconnect() async {
    await _hubConnection.stop();
  }

  sendMessage() async {
    if (messageSubject.valueWrapper.value != null) {
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
