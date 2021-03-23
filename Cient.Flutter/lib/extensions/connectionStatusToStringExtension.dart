import 'package:flutter2/viewModel/viewModel.dart';

extension ConnecionStatusToString on ConnectionStatus {
  String getString() {
    print(this);
    switch (this) {
      case ConnectionStatus.Connected:
        return "Connected";
        break;
      case ConnectionStatus.NotConnected:
        return "Not Connected";
        break;
      case ConnectionStatus.Connecting:
        return "Connecting";
        break;
      default:
        return "Unknown";
    }
  }
}
