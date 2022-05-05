/// Api constants for endpoints and other network related fields

class ApiConstants {
  static const httpsScheme = 'https';

  /// LodgifyTest Api constants
  static const lodgifyTestApiHost = 'gist.githubusercontent.com';
  static const huvberStrings = '/huvber/ba0d534f68e34f1be86d7fe7eff92c96';
  static const urlType = '/raw';
  static const identifierNumbers = '/508f46dbf6535f830aa92cf97359853c5700bab1';

  /// Api request related options
  static const receiveTimeout = 5000;
  static const sendTimeout = 3000;
  static const connectTimeout = 10000;

  // Base Uris

  /// Lodgify
  static get rapturesBaseUri =>
      Uri(scheme: httpsScheme, host: lodgifyTestApiHost, path: '/');

  static get fetchMockProgress => Uri(
        scheme: httpsScheme,
        host: lodgifyTestApiHost,
        path: '$huvberStrings$urlType$identifierNumbers/mock-progress',
      );
}
