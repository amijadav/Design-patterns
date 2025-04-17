import 'package:flutter/material.dart';
import '../factory/status_button.dart';
import 'material_button_widget.dart';

class AvailableButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return MaterialButtonWidget(
      onPressed: () => callback("Available"),
      color: Colors.green,
      text: "Set Available",
    );
  }
}

class BusyButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return MaterialButtonWidget(
      onPressed: () => callback("Busy"),
      color: Colors.orange,
      text: "Set Busy",
    );
  }
}

class OfflineButton implements StatusButton {
  @override
  Widget build(BuildContext context, StatusCallback callback) {
    return MaterialButtonWidget(
      onPressed: () => callback("Offline"),
      color: Colors.red,
      text: "Set Offline",
    );
  }
}
