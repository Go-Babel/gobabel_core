import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:gobabel_client/gobabel_client.dart';
import 'package:result_dart/result_dart.dart';

ResultDart<String, BabelException> generateSha1(String input) {
  try {
    var bytes = utf8.encode(input);
    var digest = sha1.convert(bytes);
    return digest.toString().toSuccess();
  } catch (error) {
    return BabelException(
      title: 'SHA1 Generation Error',
      description:
          'Error: $error\nFailed to generate SHA1 for input:\n"""$input"""',
    ).toFailure();
  }
}
