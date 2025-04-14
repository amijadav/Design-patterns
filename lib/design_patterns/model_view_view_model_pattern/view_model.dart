import 'model.dart';
import 'repo_pattern.dart';

abstract class ViewModel {
  static ViewModel? _instance;
  factory ViewModel() => _instance ??= _ViewModelImpl();
  Future<Model> getData();
}

class _ViewModelImpl implements ViewModel {
  final RepositoryPatternExample _repositoryPatternExample =
      RepositoryPatternExample();

  @override
  Future<Model> getData() async {
    return await _repositoryPatternExample.fetchData();
  }
}
