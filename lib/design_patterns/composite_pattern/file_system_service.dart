import 'file_and_folder_class.dart';

class FileSystemService {
  Folder initializeFileSystem() {
    Folder downloads = Folder("Downloads");
    FileItem file1 = FileItem("Document.pdf");
    FileItem file2 = FileItem("Video.mp4");
    downloads.add(file1);
    downloads.add(file2);

    Folder pictures = Folder("Pictures");
    FileItem file3 = FileItem("Image.png");
    pictures.add(file3);

    Folder root = Folder("Root");
    root.add(downloads);
    root.add(pictures);

    return root;
  }
}
