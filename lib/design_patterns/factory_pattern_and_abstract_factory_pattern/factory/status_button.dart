import 'package:flutter/material.dart';

typedef StatusCallback = void Function(String);

abstract class StatusButton {
  Widget build(BuildContext context, StatusCallback callback);
}
