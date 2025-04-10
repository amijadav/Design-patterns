abstract class StringUtils {
  factory StringUtils() => throw UnimplementedError();

  static bool isStringEmptyOrWhiteSpaced(String? value) {
    return value == null || value.trim().isEmpty;
  }
}
