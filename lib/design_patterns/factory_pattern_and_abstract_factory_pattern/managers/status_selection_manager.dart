abstract class StatusSelectionManager {
  static final StatusSelectionManager _instance = StatusSelectionManagerIMPL();
  factory StatusSelectionManager() => _instance;

  String get selectedStatus;
  set selectedStatus(String status);
}

class StatusSelectionManagerIMPL implements StatusSelectionManager {
  String _selectedStatus = "Unknown";

  @override
  String get selectedStatus => _selectedStatus;

  @override
  set selectedStatus(String status) {
    _selectedStatus = status;
  }
}

abstract class StatusState {
  String get status;
}

class AvailableState implements StatusState {
  @override
  String get status => "Available";
}

class BusyState implements StatusState {
  @override
  String get status => "Busy";
}

class OfflineState implements StatusState {
  @override
  String get status => "Offline";
}
