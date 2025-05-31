import 'dart:io';
import 'dart:async';
import 'package:chalkdart/chalkstrings.dart';

/// Runs [action], showing a spinner plus [message] in the terminal until it
/// completes. Returns whatever [action] returns (or rethrows its error).
Future<T> runWithSpinner<T>(
  Future<T> Function() action, {
  Duration interval = const Duration(milliseconds: 120),
  // String message = 'Loading',
  //  String successMessage = 'Done!',
  required String successMessage,
  required String message,
}) async {
  const spinnerChars = ['|', '/', '-', '\\'];
  int idx = 0;

  // Start a periodic timer to update the spinner
  final timer = Timer.periodic(interval, (_) {
    stdout.write('\r${spinnerChars[idx % spinnerChars.length]} $message');
    idx++;
  });

  try {
    // Await the user-provided action
    final result = await action();
    return result;
  } catch (e) {
    // Rethrow after cleaning up spinner
    rethrow;
  } finally {
    // Stop spinner and clear line
    timer.cancel();
    stdout
      ..write('\r') // Move to line start
      ..write(' ' * (message.length + 4)) // Overwrite spinner+message
      ..write('\r'); // Move back again

    // Show success message
    stdout.writeln('✅ ${successMessage.green}');

    // end stdout
    // stdout.flush();
  }
}
