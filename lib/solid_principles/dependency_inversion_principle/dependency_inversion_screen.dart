import 'package:flutter/material.dart';

extension type Message(String value) {}
extension type Type(String value) {}

abstract class MessageSender {
  Message sendMessage();
}

class SMSMessageSender implements MessageSender {
  @override
  Message sendMessage() {
    return Message("SMS sent: Hello!");
  }
}

class EmailMessageSender implements MessageSender {
  @override
  Message sendMessage() {
    return Message("Email sent: Hello!");
  }
}

class PushNotificationSender implements MessageSender {
  @override
  Message sendMessage() {
    return Message("Push notification sent: Hello!");
  }
}

class ServiceProvider {
  static final Map<String, MessageSender> _messageSenders = {
    'sms': SMSMessageSender(),
    'email': EmailMessageSender(),
    'push': PushNotificationSender(),
  };

  static Message sendMessage(Type type) {
    final sender = _messageSenders[type.value];
    if (sender != null) {
      return sender.sendMessage();
    } else {
      return Message("Error: Unknown message type");
    }
  }
}

class DependencyInversionScreen extends StatefulWidget {
  const DependencyInversionScreen({super.key});

  @override
  _DependencyInversionScreenState createState() =>
      _DependencyInversionScreenState();
}

class _DependencyInversionScreenState extends State<DependencyInversionScreen> {
  String resultMessage = '';

  void _sendMessage(String messageType) {
    setState(() {
      resultMessage = ServiceProvider.sendMessage(Type(messageType)).value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 270),
        child: Column(
          children: [
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _sendMessage('sms'),
                  child: const Text("Send SMS"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _sendMessage('email'),
                  child: const Text("Send Email"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _sendMessage('push'),
                  child: const Text("Send Push Notification"),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
