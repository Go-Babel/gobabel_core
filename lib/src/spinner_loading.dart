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
    timer.cancel();
    stopwatch.stop();
    final totalTime = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1);
    stdout
      ..write('\r')
      ..write(' ' * (message.length + 15))
      ..write('\r');
    stdout.writeln('✅ ${successMessage.green} (${totalTime}s)');
    return result;
  } catch (e) {
    timer.cancel();
    stopwatch.stop();
    final totalTime = (stopwatch.elapsedMilliseconds / 1000).toStringAsFixed(1);
    stdout
      ..write('\r')
      ..write(' ' * (message.length + 15))
      ..write('\r');
    stdout.writeln('❌ $message (${totalTime}s)');
    rethrow;
  } finally {
    // Clean up
    timer.cancel();
    stopwatch.stop();
  }
}
