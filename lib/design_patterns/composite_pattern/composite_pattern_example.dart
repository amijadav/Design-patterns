// file_system_service.dart
import 'package:flutter/material.dart';

import 'file_and_folder_class.dart';
import 'file_system_service.dart';

class CompositePatternExample extends StatelessWidget {
  const CompositePatternExample({super.key});

  @override
  Widget build(BuildContext context) {
    final fileSystemService = FileSystemService();
    final root = fileSystemService.initializeFileSystem();

    return Scaffold(
      appBar: AppBar(title: const Text('File System Explorer')),
      body: ChainOfResponsibility.buildNewNode(node: root, level: 0),
    );
  }
}

abstract class ChainOfResponsibility implements StatelessWidget {
  FileSystemComponent get root;
  int get level;

  factory ChainOfResponsibility.buildNewNode({
    required FileSystemComponent node,
    required int level,
  }) {
    return switch (node) {
      Folder() => FolderNode(level: level + 1, leaf: node),
      _ => GenericFileNode(level: level + 1, leaf: node),
    };
  }
}

class FolderNode extends StatelessWidget implements ChainOfResponsibility {
  const FolderNode({
    super.key,
    required this.level,
    required Folder leaf,
  }) : root = leaf;

  @override
  final int level;

  @override
  final Folder root;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericFolderNode(
          leaf: root,
          level: level,
        ),
        if (root.children.isEmpty)
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('EmptyFolder'),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: root.children.length,
            itemBuilder: (context, index) {
              final FileSystemComponent item = root.children[index];
              return ChainOfResponsibility.buildNewNode(
                node: item,
                level: level + 1,
              );
            },
          ),
      ],
    );
  }
}

class GenericFileNode extends StatelessWidget implements ChainOfResponsibility {
  const GenericFileNode({
    super.key,
    required this.level,
    required FileSystemComponent leaf,
  }) : root = leaf;

  @override
  final int level;

  @override
  final FileSystemComponent root;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 20.0),
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
        title: Text(root.name),
      ),
    );
  }
}

class GenericFolderNode extends StatelessWidget
    implements ChainOfResponsibility {
  const GenericFolderNode({
    super.key,
    required this.level,
    required Folder leaf,
  }) : root = leaf;

  @override
  final int level;

  @override
  final Folder root;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: level * 20.0),
      child: ListTile(
        leading: const Icon(Icons.folder, color: Colors.orange),
        title: Text(
          root.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
