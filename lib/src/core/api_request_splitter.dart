import 'package:gobabel_core/gobabel_core.dart';

/// Utility functions for splitting API requests into manageable chunks
/// to prevent overloading the API.
///
/// Splits a map of strings into smaller groups based on two conditions:
/// 1. Each group should not have more than 300 keys
/// 2. The sum of all string lengths in a group should not exceed 36,000 characters
///
/// The function will create groups respecting whichever limit is reached first.
///
/// @param inputMap The original map to be split into groups
/// @return A list of maps, each representing a manageable group for API requests
List<Map<String, String>> splitIntoManageableGroupsForApi(
  Map<String, String> inputMap,
) {
  if (inputMap.isEmpty) return [];
  if (inputMap.length <= 1) return [Map.from(inputMap)];

  final List<Map<String, String>> groups = [];
  Map<String, String> currentGroup = {};
  int currentGroupCharCount = 0;

  // Sort entries by length to optimize grouping (optional)
  final entries = inputMap.entries.toList();

  for (final entry in entries) {
    final keyLength = entry.key.length;
    final valueLength = entry.value.length;
    final entryLength = keyLength + valueLength;

    // Check if adding this entry would exceed either limit
    if (currentGroup.length >= (100 * kRequestMaxKeyMultiplaier) ||
        currentGroupCharCount + entryLength >
            (12000 * kRequestMaxKeyMultiplaier)) {
      // Current group is full, add it to groups and start a new one
      groups.add(Map.from(currentGroup));
      currentGroup = {};
      currentGroupCharCount = 0;
    }

    // Add entry to current group
    currentGroup[entry.key] = entry.value;
    currentGroupCharCount += entryLength;
  }

  // Add the last group if it's not empty
  if (currentGroup.isNotEmpty) {
    groups.add(Map.from(currentGroup));
  }

  return groups;
}
