import 'package:flutter/material.dart';

extension type CallResult(String value) {}
extension type MessageResult(String value) {}
extension type PhotoResult(String value) {}
extension type FinalResult(String value) {}

abstract class Caller {
  CallResult makeCall();
}

abstract class Messenger {
  MessageResult sendMessage();
}

abstract class PhotoTaker {
  PhotoResult takePhoto();
}

class BasicPhone implements Caller, Messenger {
  @override
  CallResult makeCall() {
    return CallResult("Basic phone: Making a call");
  }

  @override
  MessageResult sendMessage() {
    return MessageResult("Basic phone: Sending SMS");
  }
}

class Smartphone implements Caller, Messenger, PhotoTaker {
  @override
  CallResult makeCall() {
    return CallResult("Smartphone: Making a call");
  }

  @override
  MessageResult sendMessage() {
    return MessageResult("Smartphone: Sending message");
  }

  @override
  PhotoResult takePhoto() {
    return PhotoResult("Smartphone: Taking photo");
  }
}

class InterfaceSegregationScreen extends StatefulWidget {
  const InterfaceSegregationScreen({super.key});

  @override
  _InterfaceSegregationScreenState createState() =>
      _InterfaceSegregationScreenState();
}

class _InterfaceSegregationScreenState
    extends State<InterfaceSegregationScreen> {
  FinalResult result = FinalResult("");
  final BasicPhone basicPhone = BasicPhone();
  final Smartphone smartphone = Smartphone();

  void _callFromBasicPhone() {
    setState(() => result = FinalResult(basicPhone.makeCall().value));
  }

  void _messageFromBasicPhone() {
    setState(() => result = FinalResult(basicPhone.sendMessage().value));
  }

  void _callFromSmartphone() {
    setState(() => result = FinalResult(smartphone.makeCall().value));
  }

  void _messageFromSmartphone() {
    setState(() => result = FinalResult(smartphone.sendMessage().value));
  }

  void _photoFromSmartphone() {
    setState(() => result = FinalResult(smartphone.takePhoto().value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Interface Segregation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result.value, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text(
              "Basic Phone:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _callFromBasicPhone,
                  child: const Text("Call"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _messageFromBasicPhone,
                  child: const Text("Message"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Smartphone:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _callFromSmartphone,
                  child: const Text("Call"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _messageFromSmartphone,
                  child: const Text("Message"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _photoFromSmartphone,
                  child: const Text("Photo"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
