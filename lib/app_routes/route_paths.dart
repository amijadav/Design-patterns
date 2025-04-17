extension type const ScreenPath(String value) {}

sealed class RoutePaths {
  static const ScreenPath login = ScreenPath('/login');
  static const ScreenPath home = ScreenPath('/home');
  static const ScreenPath modelViewPattern = ScreenPath('/modelViewPattern');
  static const ScreenPath factoryPattern = ScreenPath('/factoryPattern');
  static const ScreenPath mvvmPattern = ScreenPath('/mvvmPattern');
  static const ScreenPath blocPattern = ScreenPath('/blocPattern');
  static const ScreenPath decoratorPattern = ScreenPath('/decoratorPattern');
  static const ScreenPath pageControlButtons =
      ScreenPath('/pageControlButtons');
  static const ScreenPath compositePattern = ScreenPath('/compositePattern');
  static const ScreenPath blocPatternFlutter =
      ScreenPath('/blocPatternFlutter');
  static const ScreenPath builderPattern = ScreenPath('/builderPattern');
  static const ScreenPath singletonPattern = ScreenPath('/singletonPattern');
  static const ScreenPath abstractFactoryPattern =
      ScreenPath('/abstractFactoryPattern');
  static const ScreenPath observerPattern = ScreenPath('/observerPattern');
}
