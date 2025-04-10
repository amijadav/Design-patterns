abstract class AuthException implements Exception {}

class InvalidTokenException implements AuthException {
  @override
  String toString() {
    return '';
  }
}

class InvalidNameException implements AuthException {
  @override
  String toString() {
    return '';
  }
}
class InvalidRoleException implements AuthException {
  @override
  String toString() {
    return '';
  }
}

class InvalidActionException implements AuthException {}
