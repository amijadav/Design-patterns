extension type Title(String title) {}
extension type Author(String author) {}
extension type Summary(String summary) {}

class Model {
  final Title title;
  final Author author;
  final Summary summary;

  Model({
    required this.title,
    required this.author,
    required this.summary,
  });

  factory Model.exampleModel() => Model(
        title: Title('Model-view-view-model pattern'),
        author: Author('alex'),
        summary: Summary('This is MVVM Example.'),
      );
}
