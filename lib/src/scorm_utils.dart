import 'base_scorm.dart';

/// Contains utility methods
class ScormUtils {
  ScormUtils._();

  /// Takes a [Map] of `<String,String>` as [values] and executes [ScormAPI.setValue] on each Map-entry
  ///
  /// You can also pass a [keyPrefix] this String will be pre-pended to each key before setting value.
  /// Example use case: You need to set multiple values but all the keys start with a common `CMIElement`/key e.g. `cmi.core` or `cmi.interactions` or just `cmi`
  ///
  /// Returns a list of all the returns of [ScormAPI.setValue]
  static List<String> setValues(Map<String, String> values, {String keyPrefix = ""}) {
    final statuses = <String>[];
    values.forEach((key, value) {
      statuses.add(ScormAPI.setValue(keyPrefix + key, value));
    });
    return statuses;
  }
}
