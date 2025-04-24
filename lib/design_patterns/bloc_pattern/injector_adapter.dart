import 'package:get_it/get_it.dart';

typedef DependencyFactory<T extends Object> = T Function();

abstract class InjectorAdapter {
  static InjectorAdapter? _instance;
  factory InjectorAdapter() => _instance ??= InjectorAdapterImpl();

  T get<T extends Object>();
  void registerDependency<T extends Object>(DependencyFactory<T> factory);
  void registerSingletonDependency<T extends Object>(
      DependencyFactory<T> factory);
}

class InjectorAdapterImpl implements InjectorAdapter {
  InjectorAdapterImpl() {
    // GetIt.instance.reset();
  }

  @override
  T get<T extends Object>() {
    return GetIt.instance.get<T>();
  }

  @override
  void registerDependency<T extends Object>(DependencyFactory<T> factory) {
    return GetIt.instance.registerFactory<T>(factory);
  }

  @override
  void registerSingletonDependency<T extends Object>(
      DependencyFactory<T> factory) {
    return GetIt.instance.registerLazySingleton<T>(factory);
  }
}
