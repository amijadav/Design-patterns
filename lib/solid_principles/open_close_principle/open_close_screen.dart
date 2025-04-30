import 'package:flutter/material.dart';

extension type const NotificationMessage._(String value) {
  factory NotificationMessage(String value) {
    if (value.isEmpty) throw EmptyMessageException;
    return NotificationMessage._(value);
  }
}

abstract class NotificationService {
  NotificationMessage send();
}

class EmailNotification extends NotificationService {
  @override
  NotificationMessage send() {
    return NotificationMessage("Email sent");
  }
}

class EmailSMSNotification extends EmailNotification {
  @override
  NotificationMessage send() {
    return NotificationMessage("SMS sent");
  }
}

class PushNotification extends NotificationService {
  @override
  NotificationMessage send() {
    return NotificationMessage("Push notification sent");
  }
}

class INAppNotification extends NotificationService {
  @override
  NotificationMessage send() {
    return NotificationMessage("App notification sent");
  }
}

class OpenClosedScreen extends StatefulWidget {
  const OpenClosedScreen({super.key});

  @override
  _OpenClosedScreenState createState() => _OpenClosedScreenState();
}

class _OpenClosedScreenState extends State<OpenClosedScreen> {
  String message = "";

  void _sendNotification(NotificationService service) {
    setState(() {
      message = service.send().value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Open/Closed Principle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _sendNotification(EmailNotification()),
                  child: const Text("Send Email"),
                ),
                ElevatedButton(
                  onPressed: () => _sendNotification(EmailSMSNotification()),
                  child: const Text("Send SMS"),
                ),
                ElevatedButton(
                  onPressed: () => _sendNotification(PushNotification()),
                  child: const Text("Send Push"),
                ),
                ElevatedButton(
                  onPressed: () => _sendNotification(INAppNotification()),
                  child: const Text("In-app Push"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyMessageException implements Exception {
  @override
  String toString() {
    return 'Notification message cannot be empty';
  }
}
