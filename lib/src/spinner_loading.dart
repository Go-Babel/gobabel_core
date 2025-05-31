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
  final stopwatch = Stopwatch()..start();

  // Start a periodic timer to update the spinner
  final timer = Timer.periodic(interval, (_) {
    final seconds = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1);
    stdout.write(
      '\r${spinnerChars[idx % spinnerChars.length]} [ ${seconds}s ] $message',
    );
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
    stopwatch.stop();
    final totalTime = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1);
    stdout
      ..write('\r')
      ..write(' ' * (message.length + 10)) // Increased padding for timer
      ..write('\r');

    // Show success message with total time
    stdout.writeln('✅ ${successMessage.green} (${totalTime}s)');

    // end stdout
    // stdout.flush();
  }
}
