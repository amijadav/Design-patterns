import '../widgets/material_buttons.dart';
import 'status_button.dart';

abstract class StatusButtonFactory {
  StatusButton createAvailableButton();
  StatusButton createBusyButton();
  StatusButton createOfflineButton();

  static StatusButtonFactory getFactory() {
    return MaterialButtonFactory();
  }

  static StatusButtonFactory getAbstractFactory({bool useCupertino = false}) {
    return useCupertino ? CupertinoButtonFactory() : MaterialButtonFactory();
  }

  static StatusButton createSingleButton(String type) {
    switch (type.toLowerCase()) {
      case 'available':
        return AvailableButton();
      case 'busy':
        return BusyButton();
      case 'offline':
        return OfflineButton();
      default:
        throw Exception("Invalid button type");
    }
  }
}

class MaterialButtonFactory implements StatusButtonFactory {
  @override
  StatusButton createAvailableButton() => AvailableButton();

  @override
  StatusButton createBusyButton() => BusyButton();

  @override
  StatusButton createOfflineButton() => OfflineButton();
}

class CupertinoButtonFactory implements StatusButtonFactory {
  @override
  StatusButton createAvailableButton() => AvailableButton();

  @override
  StatusButton createBusyButton() => BusyButton();

  @override
  StatusButton createOfflineButton() => OfflineButton();
}
