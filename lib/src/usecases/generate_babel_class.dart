import 'package:gobabel_core/gobabel_core.dart';

String generateBabelClass({
  required BigInt projectShaIdentifier,
  required Set<BabelFunctionDeclaration> declarationFunctions,
}) {
  final StringBuffer fileContent = StringBuffer(babelText);
  for (final BabelFunctionDeclaration d in declarationFunctions) {
    fileContent.write('$d\n');
  }

  fileContent.write('}');

  return fileContent
      .toString()
      .replaceAll(
        r"const String _gobabelRoute = 'http://localhost:8080';",
        "const String _gobabelRoute = 'https://gobabel.dev';",
      )
      .replaceAll(
        r"const String _projectIdentifier = '';",
        "const String _projectIdentifier = '$projectShaIdentifier';",
      );
}

final babelText =
    r'''// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, deprecated_member_use, avoid_web_libraries_in_flutter, unused_element, depend_on_referenced_packages, unintended_html_in_doc_comment
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:gobabel_core/gobabel_core.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String _gobabelRoute = 'http://localhost:8080';
const String _projectIdentifier =
    '325439440403537605558364609031590613901966306984930054075442972529951867760824221376735455794372';

typedef _TranslationKey = String;
typedef _TranslationContent = String;

class ArbState {
  final int selectedLanguageIndex;
  final List<ArbData> arbData;
  const ArbState({required this.selectedLanguageIndex, required this.arbData});

  ArbData get selectedLanguage {
    if (selectedLanguageIndex < 0 || selectedLanguageIndex >= arbData.length) {
      throw Exception('Invalid selected language index');
    }
    return arbData[selectedLanguageIndex];
  }

  ArbState copyWith({int? selectedLanguageIndex, List<ArbData>? arbData}) {
    return ArbState(
      selectedLanguageIndex:
          selectedLanguageIndex ?? this.selectedLanguageIndex,
      arbData: arbData ?? this.arbData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'selectedLanguageIndex': selectedLanguageIndex,
      'arbData': arbData.map((x) => x.toMap()).toList(),
    };
  }

  factory ArbState.fromMap(Map<String, dynamic> map) {
    return ArbState(
      selectedLanguageIndex: map['selectedLanguageIndex'] as int,
      arbData: List<ArbData>.from(
        (map['arbData'] as List).map<ArbData>(
          (x) => ArbData.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
  factory ArbState.fromMapApi(Map map) {
    BabelSupportedLocales? getUserLocale() {
      final locale = ui.PlatformDispatcher.instance.locale;

      return BabelSupportedLocales.fromLocale(
        locale.languageCode,
        locale.countryCode,
      );
    }

    int defineIndex(List<ArbData> translations) {
      final userLocale = getUserLocale();
      final userLocaleIndex = translations.indexWhere(
        (translation) => translation.locale == userLocale,
      );
      final englishUSIndex = translations.indexWhere(
        (translation) => translation.locale == BabelSupportedLocales.enUS,
      );
      final englishEnglandIndex = translations.indexWhere(
        (translation) => translation.locale == BabelSupportedLocales.enGB,
      );
      final anyEnglishIndex = translations.indexWhere(
        (translation) => translation.locale.languageCode.toLowerCase() == 'en',
      );
      // Priority order:
      // 1. User device locale
      // 2. English US
      // 3. English UK
      // 4. Any English
      // 5. First language
      final initialIndex = userLocaleIndex != -1
          ? userLocaleIndex
          : englishUSIndex != -1
          ? englishUSIndex
          : englishEnglandIndex != -1
          ? englishEnglandIndex
          : anyEnglishIndex != -1
          ? anyEnglishIndex
          : 0;
      return initialIndex;
    }

    final languages = List<ArbData>.from(
      (map['languages'] as List).map<ArbData>(
        (x) => ArbData.fromApiMap(x as Map<String, dynamic>),
      ),
    );
    return ArbState(
      selectedLanguageIndex: defineIndex(languages),
      arbData: languages,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArbState.fromJson(String source) =>
      ArbState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ArbState(selectedLanguageIndex: $selectedLanguageIndex, arbData: $arbData)';

  @override
  bool operator ==(covariant ArbState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.selectedLanguageIndex == selectedLanguageIndex &&
        listEquals(other.arbData, arbData);
  }

  @override
  int get hashCode => selectedLanguageIndex.hashCode ^ arbData.hashCode;
}

class ArbData {
  final BabelSupportedLocales locale;
  final String downloadLink;
  const ArbData({required this.locale, required this.downloadLink});

  @override
  String toString() => 'ArbData(locale: $locale, downloadLink: $downloadLink)';

  @override
  bool operator ==(covariant ArbData other) {
    if (identical(this, other)) return true;

    return other.locale == locale && other.downloadLink == downloadLink;
  }

  @override
  int get hashCode => locale.hashCode ^ downloadLink.hashCode;

  ArbData copyWith({BabelSupportedLocales? locale, String? downloadLink}) {
    return ArbData(
      locale: locale ?? this.locale,
      downloadLink: downloadLink ?? this.downloadLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locale': locale.toMap(),
      'downloadLink': downloadLink,
    };
  }

  factory ArbData.fromMap(Map<String, dynamic> map) {
    return ArbData(
      locale: BabelSupportedLocales.fromMap(
        map['locale'] as Map<String, dynamic>,
      ),
      downloadLink: map['downloadLink'] as String,
    );
  }

  factory ArbData.fromApiMap(Map map) {
    return ArbData(
      locale: BabelSupportedLocales.fromMap(map),
      downloadLink: map['downloadLink'] as String,
    );
  }

  factory ArbData.fromApiJson(String source) =>
      ArbData.fromApiMap(json.decode(source) as Map);

  String toJson() => json.encode(toMap());

  factory ArbData.fromJson(String source) =>
      ArbData.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ====== ENCODE ======
Future<String> jsonEncodeWithIsolate(dynamic data) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_encodeEntry, [data, receivePort.sendPort]);
  return await receivePort.first;
}

void _encodeEntry(List<dynamic> args) {
  final data = args[0];
  final sendPort = args[1] as SendPort;

  try {
    final result = jsonEncode(data);
    sendPort.send(result);
  } catch (e) {
    sendPort.send('Encode Error: $e');
  }
}

// ====== DECODE ======
Future<dynamic> jsonDecodeWithIsolate(String jsonString) async {
  final receivePort = ReceivePort();
  await Isolate.spawn(_decodeEntry, [jsonString, receivePort.sendPort]);
  return await receivePort.first;
}

void _decodeEntry(List<dynamic> args) {
  final jsonString = args[0] as String;
  final sendPort = args[1] as SendPort;

  try {
    final result = jsonDecode(jsonString);
    sendPort.send(result);
  } catch (e) {
    sendPort.send('Decode Error: $e');
  }
}

class Babel {
  static Babel? _instance;
  late final SharedPreferencesAsync _asyncPrefs;
  // Singleton pattern, avoid self instance
  Babel._();
  static Babel get instance => _instance ??= Babel._();
  static Babel get i => _instance ??= Babel._();

  Map<String, String> translationsMap = {};

  late ArbState _arbState;
  final Completer<void> _loading = Completer();
  ArbData get selectedArb {
    if (_loading.isCompleted == false) {
      throw Exception('Babel is not initialized yet');
    }
    return _arbState.selectedLanguage;
  }

  List<ArbData> get allLanguages {
    if (_loading.isCompleted == false) {
      throw Exception('Babel is not initialized yet');
    }
    return _arbState.arbData;
  }

  Future<void> initialize({SharedPreferencesAsync? prefs}) async {
    _asyncPrefs = prefs ?? SharedPreferencesAsync();
    final ArbState? cacheArbState = await _getArbStateByCache();
    try {
      final ArbState apiState = await _fetchArbStateByApi();

      // Check if cache is up to date by comparing download links
      final isCacheUpToDate =
          cacheArbState != null &&
          cacheArbState.selectedLanguage.downloadLink ==
              apiState.selectedLanguage.downloadLink;

      if (isCacheUpToDate) {
        // Cache is up to date, try to use cached ARB data
        final cacheArb = await _getCacheArb();
        if (cacheArb != null) {
          // We have cached ARB data, use it
          translationsMap = cacheArb;
          _arbState = cacheArbState;
        } else {
          // Cache state exists but ARB data is missing, download it
          final downloaded = await _downloadArb(
            cacheArbState.selectedLanguage.downloadLink,
          );
          await _setCacheArb(downloaded);
          translationsMap = downloaded;
          _arbState = cacheArbState;
        }
        _loading.complete();
      } else {
        // Cache is outdated or doesn't exist, download fresh data
        _arbState = apiState;
        final arbJson = await _downloadArb(
          apiState.selectedLanguage.downloadLink,
        );
        await _setCacheArb(arbJson);
        await _setCacheArbState(apiState);
        translationsMap = arbJson;
        _loading.complete();
      }
    } catch (e) {
      // On error, fall back to cache if available
      if (cacheArbState != null) {
        final cacheArb = await _getCacheArb();
        if (cacheArb != null) {
          translationsMap = cacheArb;
          _arbState = cacheArbState;
          _loading.complete();
        } else {
          throw Exception(
            'Failed to fetch languages and no valid cache available: $e',
          );
        }
      } else {
        throw Exception('Failed to fetch languages: $e');
      }
    }
  }

  Future<void> _setCacheArbState(ArbState state) async {
    await _asyncPrefs.setString(
      'cache_arb_state',
      await jsonEncodeWithIsolate(state.toMap()),
    );
  }

  Future<ArbState?> _getArbStateByCache() async {
    try {
      final arbJson = await _asyncPrefs.getString('cache_arb_state');
      if (arbJson == null) return null;

      final decoded = await jsonDecodeWithIsolate(arbJson);
      if (decoded is Map<String, dynamic>) {
        return ArbState.fromMap(decoded);
      }
      return null;
    } catch (e) {
      // If cache is corrupted, return null to trigger re-fetch
      return null;
    }
  }

  Future<Map<String, String>> _downloadArb(String downloadLink) async {
    final client = http.Client();
    try {
      // Create a streamed request for efficient memory usage with large files
      final request = http.Request('GET', Uri.parse(downloadLink));
      request.headers['Accept'] = 'application/json';

      // Send the request and get a streamed response
      final streamedResponse = await client.send(request);

      if (streamedResponse.statusCode == 200) {
        // Stream the response data
        final List<int> bytes = [];

        // Read the stream chunk by chunk
        await for (final chunk in streamedResponse.stream) {
          bytes.addAll(chunk);
        }

        // Decode the JSON from accumulated bytes
        final String jsonString = utf8.decode(bytes);
        final dynamic decodedJson = await jsonDecodeWithIsolate(jsonString);

        if (decodedJson is Map) {
          final Map<String, String> result = {};
          decodedJson.forEach((key, value) {
            if (key is String) {
              result[key] =
                  value?.toString() ?? ''; // Convert null to empty string
            }
          });
          return result;
        } else {
          throw Exception('Downloaded data is not a valid JSON object');
        }
      } else if (streamedResponse.statusCode == 202) {
        // 202 Accepted means the file is still being processed
        // Wait a bit and retry
        await Future.delayed(const Duration(seconds: 2));

        // Retry the request
        return _downloadArb(downloadLink);
      } else {
        throw Exception(
          'Failed to download ARB file. Status: ${streamedResponse.statusCode}',
        );
      }
    } catch (e) {
      // Re-throw the exception with more context if needed
      if (e is Exception) {
        rethrow;
      }
      throw Exception(
        'An unexpected error occurred while downloading ARB file: $e',
      );
    } finally {
      // Always close the client to free resources
      client.close();
    }
  }

  Future<Map<String, String>?> _getCacheArb() async {
    try {
      final arbJson = await _asyncPrefs.getString('cache_arb');
      if (arbJson == null) return null;

      final decoded = await jsonDecodeWithIsolate(arbJson);
      if (decoded is Map) {
        return decoded.cast<String, String>();
      }
      return null;
    } catch (e) {
      // If cache is corrupted, return null to trigger re-download
      return null;
    }
  }

  Future<void> _setCacheArb(Map<String, String> arbJson) async {
    await _asyncPrefs.setString(
      'cache_arb',
      await jsonEncodeWithIsolate(arbJson),
    );
  }

  Future<ArbState> _fetchArbStateByApi() async {
    final url = '$_gobabelRoute/publicProject';
    final resp = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'method': 'getProjectLanguages',
        'projectShaIdentifier': _projectIdentifier,
      }),
    );

    if (resp.statusCode != 200) {
      throw Exception('Failed to fetch languages');
    }

    final map = (await jsonDecodeWithIsolate(resp.body)) as Map;
    return ArbState.fromMapApi(map);
  }

  Future<void> changeSelectedLanguage(BabelSupportedLocales language) async {
    final index = allLanguages.indexWhere(
      (element) => element.locale == language,
    );
    if (index == -1) {
      throw Exception(
        'Language not found. Needs to be in [ Babel.allLanguages ]',
      );
    }

    // Update the state with new language index first
    _arbState = _arbState.copyWith(selectedLanguageIndex: index);

    // Get the download link for the newly selected language
    final downloadLink = _arbState.selectedLanguage.downloadLink;

    // Download the ARB data for the new language
    final arb = await _downloadArb(downloadLink);

    // Update translations map with new language data
    translationsMap = arb;

    // Save both the updated state and ARB data to cache
    await _setCacheArbState(_arbState);
    await _setCacheArb(arb);
  }

  String _getByKey(String key) {
    return translationsMap[key]!;
  }
}
''';
