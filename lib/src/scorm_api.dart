import 'dart:html';
import 'dart:js';

import 'scorm_version.dart';
import 'scorm_version_extension.dart';

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

  static ScormVersion? _version = null;

  /// The found/specified SCORM version
  static ScormVersion? get version => _version;

  /// Traverses through hierarchy to find "API" or " and if found, sets the found API to current context so that it can be directly accessed
  static bool _search(JsObject window) {
    dynamic _window = _convert(window);
    while (_window[_version!.objectName] == null && _window['parent'] != null && _window['parent'] != window) {
      _tries++;
      if (_tries > _maxTries) {
        return false;
      }

      // go up the tree
      _window = _convert(_window['parent']);
    }

    // api found? - reference found API object in current context
    if (_window[_version!.objectName] != null) {
      context[_version!.objectName] = _window[_version!.objectName];
      return true;
    }

    return false;
  }

  /// Checks if given object is [Window], if yes, returns it's JsObject for searching the API
  static JsObject _convert(dynamic object) {
    if (object is Window) {
      return JsObject.fromBrowserObject(object);
    }
    return object;
  }

  static bool _findVersion({int maxTries = 7}) {
    _maxTries = maxTries;
    final foundNormal = _search(context);
    var foundInOpener = false;

    if (!foundNormal && context['opener'] != null) {
      _tries = 0;
      foundInOpener = _search(context['opener']);
    }

    _apiFound = foundNormal || foundInOpener;

    return _apiFound;
  }

  /// Tries to find SCORM API in the hierarchy up-to [maxTries] level. If it's not found in the current hierarchy, it tries to find it in the `opener`'s hierarchy
  ///
  /// If a [version] is specified, then will search only for that specific version, else will try to find both versions (preference is given to v2004)
  ///
  /// Returns whether the SCORM API has been found. The API status can also be accessed at any point of time with [apiFound]
  static bool findApi({ScormVersion? version, int maxTries = 7}) {
    if (version == null) {
      _version = ScormVersion.v2004;
      if (_findVersion(maxTries: maxTries)) {
        return true;
      } else {
        _version = ScormVersion.v1_2;
        return _findVersion(maxTries: maxTries);
      }
    } else {
      _version = version;
      return _findVersion(maxTries: _maxTries);
    }
  }

  /// Executes `Initialize`
  static bool initialize({String message = ""}) => _apiFound ? _version!.initialize(message) : false;

  /// Executes `Finish/Terminate`
  static bool finish({String message = ""}) => _apiFound ? _version!.finish(message) : false;

  /// Executes `Finish/Terminate`
  static bool terminate({String message = ""}) => _apiFound ? _version!.terminate(message) : false;

  /// Executes `GetValue`
  static String? getValue(String key) => _apiFound ? _version!.getValue(key) : null;

  /// Executes `SetValue`
  static String? setValue(String key, String value) => _apiFound ? _version!.setValue(key, value) : null;

  /// Executes `Commit`
  static bool commit({String message = ""}) => _apiFound ? _version!.commit(message) : false;

  /// Executes `GetLastError`
  static String? getLastError() => _apiFound ? _version!.getLastError() : null;

  /// Executes `GetErrorString`
  static String? getErrorString(String errorCode) => _apiFound ? _version!.getErrorString(errorCode) : null;

  /// Executes `GetDiagnostic`
  static String? getDiagnosticMessage(String errorCode) => _apiFound ? _version!.getDiagnosticMessage(errorCode) : null;
}
