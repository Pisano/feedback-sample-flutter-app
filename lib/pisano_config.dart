/// Reads config from `--dart-define` / `--dart-define-from-file`.
///
/// No real credentials are committed. Use a local-only defines file:
/// - Copy `pisano_defines.json.example` -> `pisano_defines.json`
/// - Fill your values
/// - Run:
///   flutter run --dart-define-from-file=pisano_defines.json
class PisanoConfig {
  static const String applicationId =
      String.fromEnvironment('PISANO_APP_ID', defaultValue: 'YOUR_APP_ID');
  static const String accessKey = String.fromEnvironment('PISANO_ACCESS_KEY',
      defaultValue: 'YOUR_ACCESS_KEY');
  /// Survey/channel code from Pisano panel (required for SDK init).
  static const String code =
      String.fromEnvironment('PISANO_CODE', defaultValue: 'YOUR_CODE');
  static const String apiUrl =
      String.fromEnvironment('PISANO_API_URL', defaultValue: 'YOUR_API_URL');
  static const String feedbackUrl = String.fromEnvironment('PISANO_FEEDBACK_URL',
      defaultValue: 'YOUR_FEEDBACK_URL');

  /// Optional. Pass empty string to disable.
  static const String eventUrlRaw =
      String.fromEnvironment('PISANO_EVENT_URL', defaultValue: '');

  static const bool debugLogging =
      String.fromEnvironment('PISANO_DEBUG_LOGGING', defaultValue: 'false') ==
          'true';

  static const String language =
      String.fromEnvironment('PISANO_LANGUAGE', defaultValue: 'tr');

  static String? get eventUrl => eventUrlRaw.trim().isEmpty ? null : eventUrlRaw;

  static bool get hasPlaceholders =>
      applicationId == 'YOUR_APP_ID' ||
      accessKey == 'YOUR_ACCESS_KEY' ||
      code == 'YOUR_CODE' ||
      apiUrl == 'YOUR_API_URL' ||
      feedbackUrl == 'YOUR_FEEDBACK_URL';

  static String debugSummary() {
    String describeSecret(String s, String placeholder) {
      if (s == placeholder) return '<placeholder>';
      if (s.isEmpty) return '<empty>';
      return 'set(len=${s.length})';
    }

    return 'appId=${describeSecret(applicationId, "YOUR_APP_ID")}, '
        'accessKey=${describeSecret(accessKey, "YOUR_ACCESS_KEY")}, '
        'code=${describeSecret(code, "YOUR_CODE")}, '
        'apiUrl=$apiUrl, '
        'feedbackUrl=$feedbackUrl, '
        'eventUrl=${eventUrl ?? ""}, '
        'language=$language';
  }
}

