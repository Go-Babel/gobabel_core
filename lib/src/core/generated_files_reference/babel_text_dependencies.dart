const String babelTextDependencies =
    r'''// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, deprecated_member_use, avoid_web_libraries_in_flutter, unused_element, depend_on_referenced_packages, unintended_html_in_doc_comment
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui' as ui;
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gobabel_core/gobabel_core.dart';

const String _gobabelRoute = 'http://localhost:8080';
const String _projectIdentifier = '';

typedef _TranslationKey = String;
typedef _TranslationContent = String;

class ArbState {
  final DateTime lastUpdatedAt;
  final int selectedLanguageIndex;
  final List<ArbData> arbData;
  const ArbState({
    required this.lastUpdatedAt,
    required this.selectedLanguageIndex,
    required this.arbData,
  });

  ArbData get selectedLanguage {
    if (selectedLanguageIndex < 0 || selectedLanguageIndex >= arbData.length) {
      throw Exception('Invalid selected language index');
    }
    return arbData[selectedLanguageIndex];
  }

  ArbState copyWith({
    DateTime? lastUpdatedAt,
    int? selectedLanguageIndex,
    List<ArbData>? arbData,
  }) {
    return ArbState(
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      selectedLanguageIndex:
          selectedLanguageIndex ?? this.selectedLanguageIndex,
      arbData: arbData ?? this.arbData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastUpdatedAt': lastUpdatedAt.millisecondsSinceEpoch,
      'selectedLanguageIndex': selectedLanguageIndex,
      'arbData': arbData.map((x) => x.toMap()).toList(),
    };
  }

  factory ArbState.fromMap(Map<String, dynamic> map) {
    return ArbState(
      lastUpdatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['lastUpdatedAt'] as int,
      ),
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
      final initialIndex =
          userLocaleIndex != -1
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
      lastUpdatedAt: DateTime.parse(map['updatedAt'] as String),
      arbData: languages,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArbState.fromJson(String source) =>
      ArbState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ArbState(lastUpdatedAt: $lastUpdatedAt, selectedLanguageIndex: $selectedLanguageIndex, arbData: $arbData)';

  @override
  bool operator ==(covariant ArbState other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.lastUpdatedAt == lastUpdatedAt &&
        other.selectedLanguageIndex == selectedLanguageIndex &&
        listEquals(other.arbData, arbData);
  }

  @override
  int get hashCode =>
      lastUpdatedAt.hashCode ^
      selectedLanguageIndex.hashCode ^
      arbData.hashCode;
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

''';
