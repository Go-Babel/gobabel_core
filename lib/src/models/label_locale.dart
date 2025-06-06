typedef LanguageCode = String;
typedef CountryCode = String;

class BabelSupportedLocales {
  final LanguageCode languageCode;
  final LanguageCode countryCode;
  final String displayName;

  /// Returns the flag emoji for the country code.
  ///
  /// For example, 'US' returns '🇺🇸', 'GB' returns '🇬🇧'.
  /// Returns '🏳️' if the country code doesn't have a corresponding flag emoji.
  String get flagEmoji {
    // Skip if country code doesn't have exactly 2 characters
    if (countryCode.length != 2) return '🏳️';

    // Convert country code to regional indicator symbols
    // Each uppercase letter is shifted to a Unicode regional indicator symbol
    // by adding an offset of 127397 to its ASCII value
    try {
      final int firstLetter = countryCode.codeUnitAt(0) + 127397;
      final int secondLetter = countryCode.codeUnitAt(1) + 127397;

      return String.fromCharCodes([firstLetter, secondLetter]);
    } catch (e) {
      return '🏳️';
    }
  }

  BabelSupportedLocales._(
    this.languageCode,
    this.countryCode,
    this.displayName,
  );
  static BabelSupportedLocales? fromLocale(
    LanguageCode languageCode, [
    CountryCode? countryCode,
  ]) {
    try {
      final uppercanseCountryCode = countryCode?.toUpperCase();
      return BabelSupportedLocales.values.firstWhere(
        (element) =>
            element.languageCode == languageCode &&
            (uppercanseCountryCode == null ||
                element.countryCode == uppercanseCountryCode),
      );
    } catch (e) {
      return null;
    }
  }

  factory BabelSupportedLocales.fromMap(Map map) {
    return BabelSupportedLocales.fromLocale(
      map['languageCode'],
      map['countryCode'],
    )!;
  }

  Map<String, dynamic> toMap() {
    return {'languageCode': languageCode, 'countryCode': countryCode};
  }

  @override
  String toString() => '${languageCode}_${countryCode}_$displayName';

  /// Returns null if could not cast. This function is to cast [BabelSupportedLocales.toString()]
  static BabelSupportedLocales? fromString(String? val) {
    final split = val?.contains('_') != true ? null : val!.split('_');
    if (split == null) return null;

    return BabelSupportedLocales.fromLocale(split.first, split[1]);
  }

  static List<BabelSupportedLocales> values = [
    BabelSupportedLocales.afZA,
    BabelSupportedLocales.arAE,
    BabelSupportedLocales.arBH,
    BabelSupportedLocales.arDZ,
    BabelSupportedLocales.arEG,
    BabelSupportedLocales.arIQ,
    BabelSupportedLocales.arJO,
    BabelSupportedLocales.arKW,
    BabelSupportedLocales.arLB,
    BabelSupportedLocales.arLY,
    BabelSupportedLocales.arMA,
    BabelSupportedLocales.arOM,
    BabelSupportedLocales.arQA,
    BabelSupportedLocales.arSA,
    BabelSupportedLocales.arSY,
    BabelSupportedLocales.arTN,
    BabelSupportedLocales.arYE,
    BabelSupportedLocales.azAZ,
    BabelSupportedLocales.beBY,
    BabelSupportedLocales.bgBG,
    BabelSupportedLocales.bsBA,
    BabelSupportedLocales.caES,
    BabelSupportedLocales.csCZ,
    BabelSupportedLocales.cyGB,
    BabelSupportedLocales.daDK,
    BabelSupportedLocales.deAT,
    BabelSupportedLocales.deCH,
    BabelSupportedLocales.deDE,
    BabelSupportedLocales.deLI,
    BabelSupportedLocales.deLU,
    BabelSupportedLocales.dvMV,
    BabelSupportedLocales.elGR,
    BabelSupportedLocales.enAU,
    BabelSupportedLocales.enBZ,
    BabelSupportedLocales.enCA,
    BabelSupportedLocales.enCB,
    BabelSupportedLocales.enGB,
    BabelSupportedLocales.enIE,
    BabelSupportedLocales.enJM,
    BabelSupportedLocales.enNZ,
    BabelSupportedLocales.enPH,
    BabelSupportedLocales.enTT,
    BabelSupportedLocales.enUS,
    BabelSupportedLocales.enZA,
    BabelSupportedLocales.enZW,
    BabelSupportedLocales.esAR,
    BabelSupportedLocales.esBO,
    BabelSupportedLocales.esCL,
    BabelSupportedLocales.esCO,
    BabelSupportedLocales.esCR,
    BabelSupportedLocales.esDO,
    BabelSupportedLocales.esEC,
    BabelSupportedLocales.esES,
    BabelSupportedLocales.esGT,
    BabelSupportedLocales.esHN,
    BabelSupportedLocales.esMX,
    BabelSupportedLocales.esNI,
    BabelSupportedLocales.esPA,
    BabelSupportedLocales.esPE,
    BabelSupportedLocales.esPR,
    BabelSupportedLocales.esPY,
    BabelSupportedLocales.esSV,
    BabelSupportedLocales.esUY,
    BabelSupportedLocales.esVE,
    BabelSupportedLocales.etEE,
    BabelSupportedLocales.euES,
    BabelSupportedLocales.faIR,
    BabelSupportedLocales.fiFI,
    BabelSupportedLocales.foFO,
    BabelSupportedLocales.frBE,
    BabelSupportedLocales.frCA,
    BabelSupportedLocales.frCH,
    BabelSupportedLocales.frFR,
    BabelSupportedLocales.frLU,
    BabelSupportedLocales.frMC,
    BabelSupportedLocales.glES,
    BabelSupportedLocales.guIN,
    BabelSupportedLocales.heIL,
    BabelSupportedLocales.hiIN,
    BabelSupportedLocales.hrBA,
    BabelSupportedLocales.hrHR,
    BabelSupportedLocales.huHU,
    BabelSupportedLocales.hyAM,
    BabelSupportedLocales.idID,
    BabelSupportedLocales.isIS,
    BabelSupportedLocales.itCH,
    BabelSupportedLocales.itIT,
    BabelSupportedLocales.jaJP,
    BabelSupportedLocales.kaGE,
    BabelSupportedLocales.kkKZ,
    BabelSupportedLocales.knIN,
    BabelSupportedLocales.koKR,
    BabelSupportedLocales.kokIN,
    BabelSupportedLocales.kyKG,
    BabelSupportedLocales.ltLT,
    BabelSupportedLocales.lvLV,
    BabelSupportedLocales.miNZ,
    BabelSupportedLocales.mkMK,
    BabelSupportedLocales.mnMN,
    BabelSupportedLocales.mrIN,
    BabelSupportedLocales.msBN,
    BabelSupportedLocales.msMY,
    BabelSupportedLocales.mtMT,
    BabelSupportedLocales.nbNO,
    BabelSupportedLocales.nlBE,
    BabelSupportedLocales.nlNL,
    BabelSupportedLocales.nnNO,
    BabelSupportedLocales.nsZA,
    BabelSupportedLocales.paIN,
    BabelSupportedLocales.plPL,
    BabelSupportedLocales.psAR,
    BabelSupportedLocales.ptBR,
    BabelSupportedLocales.ptPT,
    BabelSupportedLocales.quBO,
    BabelSupportedLocales.quEC,
    BabelSupportedLocales.quPE,
    BabelSupportedLocales.roRO,
    BabelSupportedLocales.ruRU,
    BabelSupportedLocales.saIN,
    BabelSupportedLocales.seFI,
    BabelSupportedLocales.seNO,
    BabelSupportedLocales.seSE,
    BabelSupportedLocales.skSK,
    BabelSupportedLocales.slSI,
    BabelSupportedLocales.sqAL,
    BabelSupportedLocales.srBA,
    BabelSupportedLocales.srSP,
    BabelSupportedLocales.svFI,
    BabelSupportedLocales.svSE,
    BabelSupportedLocales.swKE,
    BabelSupportedLocales.syrSY,
    BabelSupportedLocales.taIN,
    BabelSupportedLocales.teIN,
    BabelSupportedLocales.thTH,
    BabelSupportedLocales.tlPH,
    BabelSupportedLocales.tnZA,
    BabelSupportedLocales.trTR,
    BabelSupportedLocales.ttRU,
    BabelSupportedLocales.ukUA,
    BabelSupportedLocales.urPK,
    BabelSupportedLocales.uzUZ,
    BabelSupportedLocales.viVN,
    BabelSupportedLocales.xhZA,
    BabelSupportedLocales.zhCN,
    BabelSupportedLocales.zhHK,
    BabelSupportedLocales.zhMO,
    BabelSupportedLocales.zhSG,
    BabelSupportedLocales.zhTW,
    BabelSupportedLocales.zuZA,
  ];
  static BabelSupportedLocales afZA = BabelSupportedLocales._(
    'af',
    'ZA',
    'Afrikaans (South Africa)',
  );
  static BabelSupportedLocales arAE = BabelSupportedLocales._(
    'ar',
    'AE',
    'Arabic (U.A.E.)',
  );
  static BabelSupportedLocales arBH = BabelSupportedLocales._(
    'ar',
    'BH',
    'Arabic (Bahrain)',
  );
  static BabelSupportedLocales arDZ = BabelSupportedLocales._(
    'ar',
    'DZ',
    'Arabic (Algeria)',
  );
  static BabelSupportedLocales arEG = BabelSupportedLocales._(
    'ar',
    'EG',
    'Arabic (Egypt)',
  );
  static BabelSupportedLocales arIQ = BabelSupportedLocales._(
    'ar',
    'IQ',
    'Arabic (Iraq)',
  );
  static BabelSupportedLocales arJO = BabelSupportedLocales._(
    'ar',
    'JO',
    'Arabic (Jordan)',
  );
  static BabelSupportedLocales arKW = BabelSupportedLocales._(
    'ar',
    'KW',
    'Arabic (Kuwait)',
  );
  static BabelSupportedLocales arLB = BabelSupportedLocales._(
    'ar',
    'LB',
    'Arabic (Lebanon)',
  );
  static BabelSupportedLocales arLY = BabelSupportedLocales._(
    'ar',
    'LY',
    'Arabic (Libya)',
  );
  static BabelSupportedLocales arMA = BabelSupportedLocales._(
    'ar',
    'MA',
    'Arabic (Morocco)',
  );
  static BabelSupportedLocales arOM = BabelSupportedLocales._(
    'ar',
    'OM',
    'Arabic (Oman)',
  );
  static BabelSupportedLocales arQA = BabelSupportedLocales._(
    'ar',
    'QA',
    'Arabic (Qatar)',
  );
  static BabelSupportedLocales arSA = BabelSupportedLocales._(
    'ar',
    'SA',
    'Arabic (Saudi Arabia)',
  );
  static BabelSupportedLocales arSY = BabelSupportedLocales._(
    'ar',
    'SY',
    'Arabic (Syria)',
  );
  static BabelSupportedLocales arTN = BabelSupportedLocales._(
    'ar',
    'TN',
    'Arabic (Tunisia)',
  );
  static BabelSupportedLocales arYE = BabelSupportedLocales._(
    'ar',
    'YE',
    'Arabic (Yemen)',
  );
  static BabelSupportedLocales azAZ = BabelSupportedLocales._(
    'az',
    'AZ',
    'Azeri (Latin/Cyrillic) (Azerbaijan)',
  );
  static BabelSupportedLocales beBY = BabelSupportedLocales._(
    'be',
    'BY',
    'Belarusian (Belarus)',
  );
  static BabelSupportedLocales bgBG = BabelSupportedLocales._(
    'bg',
    'BG',
    'Bulgarian (Bulgaria)',
  );
  static BabelSupportedLocales bsBA = BabelSupportedLocales._(
    'bs',
    'BA',
    'Bosnian (Bosnia and Herzegovina)',
  );
  static BabelSupportedLocales caES = BabelSupportedLocales._(
    'ca',
    'ES',
    'Catalan (Spain)',
  );
  static BabelSupportedLocales csCZ = BabelSupportedLocales._(
    'cs',
    'CZ',
    'Czech (Czech Republic)',
  );
  static BabelSupportedLocales cyGB = BabelSupportedLocales._(
    'cy',
    'GB',
    'Welsh (United Kingdom)',
  );
  static BabelSupportedLocales daDK = BabelSupportedLocales._(
    'da',
    'DK',
    'Danish (Denmark)',
  );
  static BabelSupportedLocales deAT = BabelSupportedLocales._(
    'de',
    'AT',
    'German (Austria)',
  );
  static BabelSupportedLocales deCH = BabelSupportedLocales._(
    'de',
    'CH',
    'German (Switzerland)',
  );
  static BabelSupportedLocales deDE = BabelSupportedLocales._(
    'de',
    'DE',
    'German (Germany)',
  );
  static BabelSupportedLocales deLI = BabelSupportedLocales._(
    'de',
    'LI',
    'German (Liechtenstein)',
  );
  static BabelSupportedLocales deLU = BabelSupportedLocales._(
    'de',
    'LU',
    'German (Luxembourg)',
  );
  static BabelSupportedLocales dvMV = BabelSupportedLocales._(
    'dv',
    'MV',
    'Divehi (Maldives)',
  );
  static BabelSupportedLocales elGR = BabelSupportedLocales._(
    'el',
    'GR',
    'Greek (Greece)',
  );
  static BabelSupportedLocales enAU = BabelSupportedLocales._(
    'en',
    'AU',
    'English (Australia)',
  );
  static BabelSupportedLocales enBZ = BabelSupportedLocales._(
    'en',
    'BZ',
    'English (Belize)',
  );
  static BabelSupportedLocales enCA = BabelSupportedLocales._(
    'en',
    'CA',
    'English (Canada)',
  );
  static BabelSupportedLocales enCB = BabelSupportedLocales._(
    'en',
    'CB',
    'English (Caribbean)',
  );
  static BabelSupportedLocales enGB = BabelSupportedLocales._(
    'en',
    'GB',
    'English (United Kingdom)',
  );
  static BabelSupportedLocales enIE = BabelSupportedLocales._(
    'en',
    'IE',
    'English (Ireland)',
  );
  static BabelSupportedLocales enJM = BabelSupportedLocales._(
    'en',
    'JM',
    'English (Jamaica)',
  );
  static BabelSupportedLocales enNZ = BabelSupportedLocales._(
    'en',
    'NZ',
    'English (New Zealand)',
  );
  static BabelSupportedLocales enPH = BabelSupportedLocales._(
    'en',
    'PH',
    'English (Republic of the Philippines)',
  );
  static BabelSupportedLocales enTT = BabelSupportedLocales._(
    'en',
    'TT',
    'English (Trinidad and Tobago)',
  );
  static BabelSupportedLocales enUS = BabelSupportedLocales._(
    'en',
    'US',
    'English (United States)',
  );
  static BabelSupportedLocales enZA = BabelSupportedLocales._(
    'en',
    'ZA',
    'English (South Africa)',
  );
  static BabelSupportedLocales enZW = BabelSupportedLocales._(
    'en',
    'ZW',
    'English (Zimbabwe)',
  );
  static BabelSupportedLocales esAR = BabelSupportedLocales._(
    'es',
    'AR',
    'Spanish (Argentina)',
  );
  static BabelSupportedLocales esBO = BabelSupportedLocales._(
    'es',
    'BO',
    'Spanish (Bolivia)',
  );
  static BabelSupportedLocales esCL = BabelSupportedLocales._(
    'es',
    'CL',
    'Spanish (Chile)',
  );
  static BabelSupportedLocales esCO = BabelSupportedLocales._(
    'es',
    'CO',
    'Spanish (Colombia)',
  );
  static BabelSupportedLocales esCR = BabelSupportedLocales._(
    'es',
    'CR',
    'Spanish (Costa Rica)',
  );
  static BabelSupportedLocales esDO = BabelSupportedLocales._(
    'es',
    'DO',
    'Spanish (Dominican Republic)',
  );
  static BabelSupportedLocales esEC = BabelSupportedLocales._(
    'es',
    'EC',
    'Spanish (Ecuador)',
  );
  static BabelSupportedLocales esES = BabelSupportedLocales._(
    'es',
    'ES',
    'Spanish (Spain)',
  );
  static BabelSupportedLocales esGT = BabelSupportedLocales._(
    'es',
    'GT',
    'Spanish (Guatemala)',
  );
  static BabelSupportedLocales esHN = BabelSupportedLocales._(
    'es',
    'HN',
    'Spanish (Honduras)',
  );
  static BabelSupportedLocales esMX = BabelSupportedLocales._(
    'es',
    'MX',
    'Spanish (Mexico)',
  );
  static BabelSupportedLocales esNI = BabelSupportedLocales._(
    'es',
    'NI',
    'Spanish (Nicaragua)',
  );
  static BabelSupportedLocales esPA = BabelSupportedLocales._(
    'es',
    'PA',
    'Spanish (Panama)',
  );
  static BabelSupportedLocales esPE = BabelSupportedLocales._(
    'es',
    'PE',
    'Spanish (Peru)',
  );
  static BabelSupportedLocales esPR = BabelSupportedLocales._(
    'es',
    'PR',
    'Spanish (Puerto Rico)',
  );
  static BabelSupportedLocales esPY = BabelSupportedLocales._(
    'es',
    'PY',
    'Spanish (Paraguay)',
  );
  static BabelSupportedLocales esSV = BabelSupportedLocales._(
    'es',
    'SV',
    'Spanish (El Salvador)',
  );
  static BabelSupportedLocales esUY = BabelSupportedLocales._(
    'es',
    'UY',
    'Spanish (Uruguay)',
  );
  static BabelSupportedLocales esVE = BabelSupportedLocales._(
    'es',
    'VE',
    'Spanish (Venezuela)',
  );
  static BabelSupportedLocales etEE = BabelSupportedLocales._(
    'et',
    'EE',
    'Estonian (Estonia)',
  );
  static BabelSupportedLocales euES = BabelSupportedLocales._(
    'eu',
    'ES',
    'Basque (Spain)',
  );
  static BabelSupportedLocales faIR = BabelSupportedLocales._(
    'fa',
    'IR',
    'Farsi (Iran)',
  );
  static BabelSupportedLocales fiFI = BabelSupportedLocales._(
    'fi',
    'FI',
    'Finnish (Finland)',
  );
  static BabelSupportedLocales foFO = BabelSupportedLocales._(
    'fo',
    'FO',
    'Faroese (Faroe Islands)',
  );
  static BabelSupportedLocales frBE = BabelSupportedLocales._(
    'fr',
    'BE',
    'French (Belgium)',
  );
  static BabelSupportedLocales frCA = BabelSupportedLocales._(
    'fr',
    'CA',
    'French (Canada)',
  );
  static BabelSupportedLocales frCH = BabelSupportedLocales._(
    'fr',
    'CH',
    'French (Switzerland)',
  );
  static BabelSupportedLocales frFR = BabelSupportedLocales._(
    'fr',
    'FR',
    'French (France)',
  );
  static BabelSupportedLocales frLU = BabelSupportedLocales._(
    'fr',
    'LU',
    'French (Luxembourg)',
  );
  static BabelSupportedLocales frMC = BabelSupportedLocales._(
    'fr',
    'MC',
    'French (Principality of Monaco)',
  );
  static BabelSupportedLocales glES = BabelSupportedLocales._(
    'gl',
    'ES',
    'Galician (Spain)',
  );
  static BabelSupportedLocales guIN = BabelSupportedLocales._(
    'gu',
    'IN',
    'Gujarati (India)',
  );
  static BabelSupportedLocales heIL = BabelSupportedLocales._(
    'he',
    'IL',
    'Hebrew (Israel)',
  );
  static BabelSupportedLocales hiIN = BabelSupportedLocales._(
    'hi',
    'IN',
    'Hindi (India)',
  );
  static BabelSupportedLocales hrBA = BabelSupportedLocales._(
    'hr',
    'BA',
    'Croatian (Bosnia and Herzegovina)',
  );
  static BabelSupportedLocales hrHR = BabelSupportedLocales._(
    'hr',
    'HR',
    'Croatian (Croatia)',
  );
  static BabelSupportedLocales huHU = BabelSupportedLocales._(
    'hu',
    'HU',
    'Hungarian (Hungary)',
  );
  static BabelSupportedLocales hyAM = BabelSupportedLocales._(
    'hy',
    'AM',
    'Armenian (Armenia)',
  );
  static BabelSupportedLocales idID = BabelSupportedLocales._(
    'id',
    'ID',
    'Indonesian (Indonesia)',
  );
  static BabelSupportedLocales isIS = BabelSupportedLocales._(
    'is',
    'IS',
    'Icelandic (Iceland)',
  );
  static BabelSupportedLocales itCH = BabelSupportedLocales._(
    'it',
    'CH',
    'Italian (Switzerland)',
  );
  static BabelSupportedLocales itIT = BabelSupportedLocales._(
    'it',
    'IT',
    'Italian (Italy)',
  );
  static BabelSupportedLocales jaJP = BabelSupportedLocales._(
    'ja',
    'JP',
    'Japanese (Japan)',
  );
  static BabelSupportedLocales kaGE = BabelSupportedLocales._(
    'ka',
    'GE',
    'Georgian (Georgia)',
  );
  static BabelSupportedLocales kkKZ = BabelSupportedLocales._(
    'kk',
    'KZ',
    'Kazakh (Kazakhstan)',
  );
  static BabelSupportedLocales knIN = BabelSupportedLocales._(
    'kn',
    'IN',
    'Kannada (India)',
  );
  static BabelSupportedLocales koKR = BabelSupportedLocales._(
    'ko',
    'KR',
    'Korean (Korea)',
  );
  static BabelSupportedLocales kokIN = BabelSupportedLocales._(
    'kok',
    'IN',
    'Konkani (India)',
  );
  static BabelSupportedLocales kyKG = BabelSupportedLocales._(
    'ky',
    'KG',
    'Kyrgyz (Kyrgyzstan)',
  );
  static BabelSupportedLocales ltLT = BabelSupportedLocales._(
    'lt',
    'LT',
    'Lithuanian (Lithuania)',
  );
  static BabelSupportedLocales lvLV = BabelSupportedLocales._(
    'lv',
    'LV',
    'Latvian (Latvia)',
  );
  static BabelSupportedLocales miNZ = BabelSupportedLocales._(
    'mi',
    'NZ',
    'Maori (New Zealand)',
  );
  static BabelSupportedLocales mkMK = BabelSupportedLocales._(
    'mk',
    'MK',
    'FYRO Macedonian (Former Yugoslav Republic of Macedonia)',
  );
  static BabelSupportedLocales mnMN = BabelSupportedLocales._(
    'mn',
    'MN',
    'Mongolian (Mongolia)',
  );
  static BabelSupportedLocales mrIN = BabelSupportedLocales._(
    'mr',
    'IN',
    'Marathi (India)',
  );
  static BabelSupportedLocales msBN = BabelSupportedLocales._(
    'ms',
    'BN',
    'Malay (Brunei Darussalam)',
  );
  static BabelSupportedLocales msMY = BabelSupportedLocales._(
    'ms',
    'MY',
    'Malay (Malaysia)',
  );
  static BabelSupportedLocales mtMT = BabelSupportedLocales._(
    'mt',
    'MT',
    'Maltese (Malta)',
  );
  static BabelSupportedLocales nbNO = BabelSupportedLocales._(
    'nb',
    'NO',
    'Norwegian (Bokm?l) (Norway)',
  );
  static BabelSupportedLocales nlBE = BabelSupportedLocales._(
    'nl',
    'BE',
    'Dutch (Belgium)',
  );
  static BabelSupportedLocales nlNL = BabelSupportedLocales._(
    'nl',
    'NL',
    'Dutch (Netherlands)',
  );
  static BabelSupportedLocales nnNO = BabelSupportedLocales._(
    'nn',
    'NO',
    'Norwegian (Nynorsk) (Norway)',
  );
  static BabelSupportedLocales nsZA = BabelSupportedLocales._(
    'ns',
    'ZA',
    'Northern Sotho (South Africa)',
  );
  static BabelSupportedLocales paIN = BabelSupportedLocales._(
    'pa',
    'IN',
    'Punjabi (India)',
  );
  static BabelSupportedLocales plPL = BabelSupportedLocales._(
    'pl',
    'PL',
    'Polish (Poland)',
  );
  static BabelSupportedLocales psAR = BabelSupportedLocales._(
    'ps',
    'AR',
    'Pashto (Afghanistan)',
  );
  static BabelSupportedLocales ptBR = BabelSupportedLocales._(
    'pt',
    'BR',
    'Portuguese (Brazil)',
  );
  static BabelSupportedLocales ptPT = BabelSupportedLocales._(
    'pt',
    'PT',
    'Portuguese (Portugal)',
  );
  static BabelSupportedLocales quBO = BabelSupportedLocales._(
    'qu',
    'BO',
    'Quechua (Bolivia)',
  );
  static BabelSupportedLocales quEC = BabelSupportedLocales._(
    'qu',
    'EC',
    'Quechua (Ecuador)',
  );
  static BabelSupportedLocales quPE = BabelSupportedLocales._(
    'qu',
    'PE',
    'Quechua (Peru)',
  );
  static BabelSupportedLocales roRO = BabelSupportedLocales._(
    'ro',
    'RO',
    'Romanian (Romania)',
  );
  static BabelSupportedLocales ruRU = BabelSupportedLocales._(
    'ru',
    'RU',
    'Russian (Russia)',
  );
  static BabelSupportedLocales saIN = BabelSupportedLocales._(
    'sa',
    'IN',
    'Sanskrit (India)',
  );
  static BabelSupportedLocales seFI = BabelSupportedLocales._(
    'se',
    'FI',
    'Sami (Northern) (Finland)',
  );
  static BabelSupportedLocales seNO = BabelSupportedLocales._(
    'se',
    'NO',
    'Sami (Northern) (Norway)',
  );
  static BabelSupportedLocales seSE = BabelSupportedLocales._(
    'se',
    'SE',
    'Sami (Northern) (Sweden)',
  );
  static BabelSupportedLocales skSK = BabelSupportedLocales._(
    'sk',
    'SK',
    'Slovak (Slovakia)',
  );
  static BabelSupportedLocales slSI = BabelSupportedLocales._(
    'sl',
    'SI',
    'Slovenian (Slovenia)',
  );
  static BabelSupportedLocales sqAL = BabelSupportedLocales._(
    'sq',
    'AL',
    'Albanian (Albania)',
  );
  static BabelSupportedLocales srBA = BabelSupportedLocales._(
    'sr',
    'BA',
    'Serbian (Latin/Cyrillic) (Bosnia and Herzegovina)',
  );
  static BabelSupportedLocales srSP = BabelSupportedLocales._(
    'sr',
    'SP',
    'Serbian (Latin/Cyrillic) (Serbia and Montenegro)',
  );
  static BabelSupportedLocales svFI = BabelSupportedLocales._(
    'sv',
    'FI',
    'Swedish (Finland)',
  );
  static BabelSupportedLocales svSE = BabelSupportedLocales._(
    'sv',
    'SE',
    'Swedish (Sweden)',
  );
  static BabelSupportedLocales swKE = BabelSupportedLocales._(
    'sw',
    'KE',
    'Swahili (Kenya)',
  );
  static BabelSupportedLocales syrSY = BabelSupportedLocales._(
    'syr',
    'SY',
    'Syriac (Syria)',
  );
  static BabelSupportedLocales taIN = BabelSupportedLocales._(
    'ta',
    'IN',
    'Tamil (India)',
  );
  static BabelSupportedLocales teIN = BabelSupportedLocales._(
    'te',
    'IN',
    'Telugu (India)',
  );
  static BabelSupportedLocales thTH = BabelSupportedLocales._(
    'th',
    'TH',
    'Thai (Thailand)',
  );
  static BabelSupportedLocales tlPH = BabelSupportedLocales._(
    'tl',
    'PH',
    'Tagalog (Philippines)',
  );
  static BabelSupportedLocales tnZA = BabelSupportedLocales._(
    'tn',
    'ZA',
    'Tswana (South Africa)',
  );
  static BabelSupportedLocales trTR = BabelSupportedLocales._(
    'tr',
    'TR',
    'Turkish (Turkey)',
  );
  static BabelSupportedLocales ttRU = BabelSupportedLocales._(
    'tt',
    'RU',
    'Tatar (Russia)',
  );
  static BabelSupportedLocales ukUA = BabelSupportedLocales._(
    'uk',
    'UA',
    'Ukrainian (Ukraine)',
  );
  static BabelSupportedLocales urPK = BabelSupportedLocales._(
    'ur',
    'PK',
    'Urdu (Islamic Republic of Pakistan)',
  );
  static BabelSupportedLocales uzUZ = BabelSupportedLocales._(
    'uz',
    'UZ',
    'Uzbek (Latin) (Uzbekistan)',
  );
  static BabelSupportedLocales viVN = BabelSupportedLocales._(
    'vi',
    'VN',
    'Vietnamese (Viet Nam)',
  );
  static BabelSupportedLocales xhZA = BabelSupportedLocales._(
    'xh',
    'ZA',
    'Xhosa (South Africa)',
  );
  static BabelSupportedLocales zhCN = BabelSupportedLocales._(
    'zh',
    'CN',
    'Chinese (Simplified)',
  );
  static BabelSupportedLocales zhHK = BabelSupportedLocales._(
    'zh',
    'HK',
    'Chinese (Hong Kong)',
  );
  static BabelSupportedLocales zhMO = BabelSupportedLocales._(
    'zh',
    'MO',
    'Chinese (Macau)',
  );
  static BabelSupportedLocales zhSG = BabelSupportedLocales._(
    'zh',
    'SG',
    'Chinese (Singapore)',
  );
  static BabelSupportedLocales zhTW = BabelSupportedLocales._(
    'zh',
    'TW',
    'Chinese (Taiwan)',
  );
  static BabelSupportedLocales zuZA = BabelSupportedLocales._(
    'zu',
    'ZA',
    'Zulu (South Africa)',
  );

  @override
  bool operator ==(covariant BabelSupportedLocales other) {
    if (identical(this, other)) return true;

    return other.languageCode == languageCode &&
        other.countryCode == countryCode &&
        other.displayName == displayName;
  }

  @override
  int get hashCode =>
      languageCode.hashCode ^ countryCode.hashCode ^ displayName.hashCode;

  /// Returns the language name from the [displayName].
  ///
  /// For example, "Gujarati (India)" => "Gujarati"
  String get languageName =>
      displayName.contains('(')
          ? displayName.split('(').first.trim()
          : displayName;

  /// Returns the country name from the [displayName].
  ///
  /// For example, "Gujarati (India)" => "India"
  /// Returns an empty string if no country name is found.
  String get countryName {
    if (displayName.contains('(') && displayName.contains(')')) {
      final startIndex = displayName.indexOf('(') + 1;
      final endIndex = displayName.lastIndexOf(')');
      if (startIndex < endIndex) {
        return displayName.substring(startIndex, endIndex).trim();
      }
    }
    return '';
  }
}
