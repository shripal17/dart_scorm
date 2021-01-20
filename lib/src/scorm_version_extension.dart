import 'scorm_js_api.dart';
import 'scorm_version.dart';

extension ScormVersionExtension on ScormVersion {
  /// Name of the JavaScript object to search
  String get objectName {
    switch (this) {
      case ScormVersion.v1_2:
        return "API";
        break;

      case ScormVersion.v2004:
        return "API_1484_11";
        break;
    }
    return "API";
  }

  bool Function(String) get initialize => this == ScormVersion.v1_2 ? API_v1_2.initialize : API_v2004.initialize;

  bool Function(String) get finish => this == ScormVersion.v1_2 ? API_v1_2.finish : API_v2004.terminate;

  bool Function(String) get terminate => this == ScormVersion.v1_2 ? API_v1_2.finish : API_v2004.terminate;

  String Function(String) get getValue => this == ScormVersion.v1_2 ? API_v1_2.getValue : API_v2004.getValue;

  String Function(String, String) get setValue => this == ScormVersion.v1_2 ? API_v1_2.setValue : API_v2004.setValue;

  bool Function(String) get commit => this == ScormVersion.v1_2 ? API_v1_2.commit : API_v2004.commit;

  String Function() get getLastError => this == ScormVersion.v1_2 ? API_v1_2.getLastError : API_v2004.getLastError;

  String Function(String) get getErrorString => this == ScormVersion.v1_2 ? API_v1_2.getErrorString : API_v2004.getErrorString;

  String Function(String) get getDiagnosticMessage => this == ScormVersion.v1_2 ? API_v1_2.getDiagnosticMessage : API_v2004.getDiagnosticMessage;
}
