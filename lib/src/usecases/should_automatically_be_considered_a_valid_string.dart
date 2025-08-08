// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';

/// Maximum accepted letters-per-space ratio.
/// If a string has fewer letters per space than this value, it will be rejected.
/// For example, with a value of 4.0, "a b c d" (ratio of 1.0) would be rejected,
/// while "Hello world" (ratio of 10.0) would be accepted.
const double maxAcceptedLettersPerSpaceRatio = 4.0;

bool shouldAutomaticallyBeConsideredAValidString(
  String value, {
  bool shouldLog = false,
}) {
  if (value.isEmpty) return false;
  if (value.length > 220) return false;
  try {
    // Check space-to-letter ratio first - if it's too low, reject immediately
    final lettersPerSpaceRatio = calculateLettersPerSpaceRatio(value);
    if (lettersPerSpaceRatio < maxAcceptedLettersPerSpaceRatio) {
      return false;
    }
  } catch (error) {
    if (shouldLog) {
      print(
          'Error calculating letters per space ratio: "$error"\n\nString: "$value"');
    }
  }
  if (value.contains('   ')) return false;
  try {
    final isSentence = isSentencePattern(value);
    if (isSentence) return true;
    return false;
  } catch (error) {
    if (shouldLog) {
      print('Error checking sentence pattern: "$error"\n\nString: "$value"');
    }

    // If any error occurs, treat it as invalid
    return false;
  }
}

final RegExp sentencePatternRegex = RegExp(
    r'''(?:(?:[A-Za-z']{1,14} ?[-:,.?!]? ?)|\( ?(?:[A-Za-z']{1,14} ?[-:,.?!]? ?)+ ?\) ?)+''');

bool isSentencePattern(String value) {
  return sentencePatternRegex.allMatches(value).length == 1;
}

/// Calculates the ratio of letters (a-z, A-Z) to spaces in the given string.
/// Returns the average number of letters per space.
/// If there are no spaces, returns double.infinity.
/// If there are no letters, returns 0.0.
@visibleForTesting
double calculateLettersPerSpaceRatio(String value) {
  int letterCount = 0;
  int spaceCount = 0;

  for (final char in value.split('')) {
    if (RegExp(r'[a-zA-Z]').hasMatch(char)) {
      letterCount++;
    } else if (char == ' ') {
      spaceCount++;
    }
  }

  // If no spaces, the ratio is infinity (which is good - no excessive spacing)
  if (spaceCount == 0) {
    return double.infinity;
  }

  // If no letters, ratio is 0 (which is bad - all spaces)
  if (letterCount == 0) {
    return 0.0;
  }

  // Calculate letters per space
  return letterCount / spaceCount;
}
