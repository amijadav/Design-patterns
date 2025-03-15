import '../../1_extensions/json_map.dart';
import '../../1_extensions/route_path.dart';

abstract class RouterAdapter {
  Future<void> clearAllAndGoTo({required RoutePath path, JsonMap? parameters});
  Future<void> goTo({required RoutePath path, JsonMap? parameters});
  Future<void> goBack();
}
