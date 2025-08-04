import 'dart:io';

import 'package:path/path.dart' as p;

class FolderInfo {
  final String name;
  final String fullPath;

  FolderInfo({required this.name, required this.fullPath});

  @override
  String toString() => name; // Ensures `TreeSliver.defaultTreeNodeBuilder` displays only the name
}

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
    if (entity is File &&
        p.extension(entity.path) == '.dart' &&
        entity.path.contains('lib/')) {
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
    if (entity is File &&
        p.extension(entity.path) == '.dart' &&
        entity.path.contains('/lib/')) {
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

List<CodeBaseFolder> buildFolderTreeFromListOfFiles(Set<String> filePaths) {
  // Initialize the list of top-level folders
  final roots = <CodeBaseFolder>[];

  // Process each file path
  for (final filePath in filePaths) {
    // Split the path into parts (directories and file name)
    final parts = p.split(filePath);

    // Skip if the path doesn't contain at least one directory and a file
    if (parts.length < 2) continue;

    // Extract directories (exclude the file name)
    final directories = parts.sublist(0, parts.length - 1);

    // Start at the root level
    var currentLevel = roots;

    // Build the folder structure level-by-level
    for (final dir in directories) {
      // Check if the folder already exists at this level
      CodeBaseFolder? currentFolder;
      for (final folder in currentLevel) {
        if (folder.name == dir) {
          currentFolder = folder;
          break;
        }
      }

      // If not found, create a new folder and add it to the current level
      if (currentFolder == null) {
        currentFolder = CodeBaseFolder(name: dir, subFolders: []);
        currentLevel.add(currentFolder);
      }

      // Move to the subfolders of the current folder
      currentLevel = currentFolder.subFolders;
    }
  }

  return roots;
}
