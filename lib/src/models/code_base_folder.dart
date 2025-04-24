import 'dart:io';
import 'package:path/path.dart' as p;

class CodeBaseFolder {
  final String name;
  final List<CodeBaseFolder> subFolders;

  const CodeBaseFolder({required this.name, required this.subFolders});

  Set<String> listAllFolders() {
    final allFolders = <String>{};
    final root = '$name/';
    allFolders.add(root);
    for (final subFolder in subFolders) {
      allFolders.addAll(subFolder.listAllFolders().map((e) => '$root$e'));
    }
    return allFolders;
  }
}

/// Recursively builds a [CodeBaseFolder] representing the directory tree rooted
/// at [dir], including only directories that contain at least one .dart file
/// (directly or in any of their subdirectories).
///
///
/// Returns `null` if [dir] and all its descendants contain no .dart files.
Future<CodeBaseFolder?> buildFolderTree(Directory dir) async {
  final folderName = p.basename(dir.path);
  bool hasDartFile = false;
  final children = <CodeBaseFolder>[];

  await for (final entity in dir.list(followLinks: false)) {
    if (entity is File && p.extension(entity.path) == '.dart') {
      hasDartFile = true;
    } else if (entity is Directory) {
      final child = await buildFolderTree(entity);
      if (child != null) {
        children.add(child);
      }
    }
  }

  if (hasDartFile || children.isNotEmpty) {
    return CodeBaseFolder(name: folderName, subFolders: children);
  }
  return null;
}

/// Synchronous variant that filters similarly.
CodeBaseFolder? buildFolderTreeSync(Directory dir) {
  final folderName = p.basename(dir.path);
  bool hasDartFile = false;
  final children = <CodeBaseFolder>[];

  for (final entity in dir.listSync(followLinks: false)) {
    if (entity is File && p.extension(entity.path) == '.dart') {
      hasDartFile = true;
    } else if (entity is Directory) {
      final child = buildFolderTreeSync(entity);
      if (child != null) {
        children.add(child);
      }
    }
  }

  if (hasDartFile || children.isNotEmpty) {
    return CodeBaseFolder(name: folderName, subFolders: children);
  }
  return null;
}
