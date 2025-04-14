import 'package:flutter/material.dart';
import 'cupertino_button_widget.dart';
import '../factory/status_button.dart';

class CupertinoAvailableButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return CupertinoButtonWidget(
      color: Colors.green,
      onPressed: () => callback("Available"),
      text: "Set Available",
    );
  }
}

class CupertinoBusyButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return CupertinoButtonWidget(
      color: Colors.orange,
      onPressed: () => callback("Busy"),
      text: "Set Busy",
    );
  }
}

class CupertinoOfflineButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return CupertinoButtonWidget(
      color: Colors.red,
      onPressed: () => callback("Offline"),
      text: "Set Offline",
    );
  }
}
