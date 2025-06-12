import 'package:gobabel_core/src/core/generated_files_reference/babel_text_dependencies.dart';

const String babelText =
    babelTextDependencies +
    r'''class Babel {
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
    final ArbState? cacheArbState = await _getCacheArbState();
    try {
      final ArbState apiState = await _fetchArbData();
      final isCacheUpToDate =
          cacheArbState != null &&
          cacheArbState.lastUpdatedAt.isAtSameMomentAs(apiState.lastUpdatedAt);
      if (isCacheUpToDate) {
        final cacheArb = await _getCacheArb();
        translationsMap =
            cacheArb ??
            await () async {
              final downloadLink = cacheArbState.selectedLanguage.downloadLink;
              final downloaded = await _downloadArb(downloadLink);
              await _setCacheArb(downloaded);
              return downloaded;
            }();
        _arbState = cacheArbState;
        _loading.complete();
      } else {
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
      if (cacheArbState != null) {
        final cacheArb = await _getCacheArb();
        if (cacheArb == null) {
          throw Exception('Failed to fetch languages: $e');
        }
        translationsMap = cacheArb;
        _arbState = cacheArbState;
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

  Future<ArbState?> _getCacheArbState() async {
    final arbJson = await _asyncPrefs.getString('cache_arb_state');
    if (arbJson == null) return null;
    return ArbState.fromMap(await jsonDecodeWithIsolate(arbJson));
  }

  Future<Map<String, String>> _downloadArb(String downloadLink) async {
    final response = await http.get(Uri.parse(downloadLink));
    if (response.statusCode != 200) {
      throw Exception('Failed to download arb json');
    }

    final decodedJson = jsonDecodeWithIsolate(response.body) as Map;
    return decodedJson.cast<String, String>();
  }

  Future<Map<String, String>?> _getCacheArb() async {
    final arbJson = await _asyncPrefs.getString('cache_arb');
    if (arbJson == null) return null;
    return (jsonDecodeWithIsolate(arbJson) as Map).cast<String, String>();
  }

  Future<void> _setCacheArb(Map<String, String> arbJson) async {
    await _asyncPrefs.setString(
      'cache_arb',
      await jsonEncodeWithIsolate(arbJson),
    );
  }

  Future<ArbState> _fetchArbData() async {
    final resp = await http.get(
      Uri(
        host: _gobabelRoute,
        path: '/labels/available_locales',
        queryParameters: {'projectShaIdentifier': _projectShaIdentifier},
      ),
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
    final downloadLink = selectedArb.downloadLink;
    final arb = await _downloadArb(downloadLink);

    await _setCacheArbState(_arbState);
    await _setCacheArb(arb);

    _arbState = _arbState.copyWith(selectedLanguageIndex: index);
  }

  String _getByKey(String key) {
    return translationsMap[key]!;
  }

''';
