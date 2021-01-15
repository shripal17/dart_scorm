@JS()
library scorm;

import 'dart:js';

import 'package:js/js.dart';

/// Main class for all the interaction with SCORM APIs
///
/// Begin with finding the API using the [findApi] method.
/// Check [apiFound] at any point of time.
///
/// Note: All methods/members are static because this package has been designed assuming that the consumer (your web app) will represent single SCORM resource
class ScormAPI {
  ScormAPI._();

  static int _tries = 0;
  static int _maxTries = 7;

  /// Indicates whether api was successfully found. All other methods will return null/false if api has not been found
  static bool get apiFound => _apiFound;

  static bool _apiFound = false;

  /// Traverses through hierarchy to find "API" and if found, sets the found API to current context so that it can be directly accessed via `API.LMSxyz`
  static bool _find(JsObject window) {
    while (window['API'] == null && window['parent'] != null && window['parent'] != window) {
      _tries++;
      if (_tries > _maxTries) {
        return false;
      }

      window = window['parent'];
    }

    if (window['API'] != null) {
      context['API'] = window['API'];
      return true;
    }

    return false;
  }

  /// Tries to find SCORM 1.2 API in the hierarchy up-to [maxTries] level. If it's not found in the current hierarchy, it tries to find it in the `opener`'s hierarchy
  ///
  /// Returns whether the SCORM API has been found. The API status can also be accessed at any point of time with [apiFound]
  ///
  /// Disclaimer: Finding the API from current window's opener hasn't been tested and might not work properly. Please create an issue if it doesn't work
  static bool findApi({int maxTries = 7}) {
    _maxTries = maxTries;
    final foundNormal = _find(context);
    var foundInOpener = false;

    if (!foundNormal && context['opener'] != null) {
      _tries = 0;
      foundInOpener = _find(context['opener']);
    }

    _apiFound = foundNormal || foundInOpener;

    return _apiFound;
  }

  /// Executes `LMSInitialize`
  static bool initialize({String message = ""}) => _apiFound ? _initialize(message) : false;

  /// Executes `LMSFinish`
  static bool finish({String message = ""}) => _apiFound ? _finish(message) : false;

  /// Executes `LMSGetValue`
  static String getValue(String key) => _apiFound ? _getValue(key) : null;

  /// Executes `LMSSetValue`
  static String setValue(String key, String value) => _apiFound ? _setValue(key, value) : null;

  /// Executes `LMSCommit`
  static bool commit({String message = ""}) => _apiFound ? _commit(message) : false;

  /// Executes `LMSGetLastError`
  static String getLastError() => _apiFound ? _getLastError() : null;

  /// Executes `LMSGetErrorString`
  static String getErrorString(String errorCode) => _apiFound ? _getErrorString(errorCode) : null;

  /// Executes `LMSGetDiagnostic`
  static String getDiagnosticMessage(String errorCode) => _apiFound ? _getDiagnosticMessage(errorCode) : null;
}

@JS("API.LMSInitialize")
external bool _initialize(String message);

@JS("API.LMSFinish")
external bool _finish(String message);

@JS("API.LMSGetValue")
external String _getValue(String key);

@JS("API.LMSSetValue")
external String _setValue(String key, String value);

@JS("API.LMSCommit")
external bool _commit(String message);

@JS("API.LMSGetLastError")
external String _getLastError();

@JS("API.LMSGetErrorString")
external String _getErrorString(String errorCode);

@JS("API.LMSGetDiagnostic")
external String _getDiagnosticMessage(String errorCode);
