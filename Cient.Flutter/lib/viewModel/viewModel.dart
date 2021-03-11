import 'dart:core';
import 'package:rxdart/subjects.dart';
import 'package:signalr_core/signalr_core.dart';

class ViewModel {
  HubConnection _hubConnection;
  ViewModel() {
    _hubConnection = HubConnectionBuilder()
        .withUrl("http://192.168.1.37:5001/chatting",
            HttpConnectionOptions(logging: newMethod))
        .build();
    _hubConnection.onclose(
        (exception) => statusSubject.add(ConnectionStatus.NotConnected));
    _hubConnection.onreconnected(
        (connectionId) => statusSubject.add(ConnectionStatus.Connected));
    _hubConnection.onreconnecting(
        (exception) => statusSubject.add(ConnectionStatus.Connecting));
    _hubConnection.on("ReceiveMessage", _onMessageReceive);
    _onMessageReceive("Yahshi yahshi rahmat");
  }

  void newMethod(level, message) {
    var log = level.toString() + "" + message;
    print(log);
  }

  void _onMessageReceive(message) {
    _messagesStore.add(message);
    messagesSubject.add(_messagesStore);
  }

  final List<String> _messagesStore = [
    "Salom",
    "Salom siz yahsimi",
    "Ha uzingiz qando ",
    "Qayrdasiz ?",
    "Man uyda sizchi?"
  ];

  final messageSubject = BehaviorSubject<String>();
  final statusSubject = BehaviorSubject.seeded(ConnectionStatus.NotConnected);
  final messagesSubject = BehaviorSubject<List<String>>.seeded(List.empty());

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

  sendMessage() {
    _hubConnection
        .invoke("SendMessage", args: [messageSubject.valueWrapper.value]);
  }

  void dispose() {
    messageSubject.close();
    statusSubject.close();
    messagesSubject.close();
    _hubConnection.stop();
  }
}

enum ConnectionStatus { Connected, NotConnected, Connecting }
