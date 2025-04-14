abstract class FileSystemComponent {
  String name;
  FileSystemComponent(this.name);
}

class FileItem extends FileSystemComponent {
  FileItem(super.name);
}

class Folder extends FileSystemComponent {
  List<FileSystemComponent> children = [];

  Folder(super.name);

  void add(FileSystemComponent component) {
    children.add(component);
  }
}
