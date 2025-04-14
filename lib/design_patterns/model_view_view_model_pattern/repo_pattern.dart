import 'dart:async';
import 'model.dart';

abstract class RepositoryPatternExample {
  static RepositoryPatternExample? _instance;
  factory RepositoryPatternExample() =>
      _instance ??= RepositoryPatternExampleImpl();
  Future<Model> fetchData();
}

class RepositoryPatternExampleImpl implements RepositoryPatternExample {
  @override
  Future<Model> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return Model.exampleModel();
  }
}
