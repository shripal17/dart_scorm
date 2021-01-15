# scorm

[![Pub](https://img.shields.io/pub/v/scorm.svg)](https://pub.dev/packages/scorm)

A simple package which lets you conveniently consume SCORM 1.2 APIs in your dart/flutter web app. Also handles finding of the SCORM 'API' object in the view hierarchy.

This opens a new scope for Dart/Flutter Web: Beautiful, interactive course content creation

## Installation
Refer [here](https://pub.dev/packages/scorm/install)

## Getting Started

1. `import package:scorm/scorm.dart;`
2. Before doing anything, you need to first find the SCORM API using [ScormAPI.findApi](https://pub.dev/documentation/scorm/latest/scorm/ScormAPI/findApi.html), returns status whether SCORM API was found.
3. If the API is not found, other methods will return false/null
4. Use other methods like `initialize`, `setValue`, `getValue`, `commit`, `finish`, etc. according to your needs.
5. **BONUS**: [Utility methods for SCORM](https://pub.dev/documentation/scorm/latest/scorm/ScormUtils-class.html)

## Example

A complete example to run a Flutter web app as a SCORM 1.2 package can be found in the [example folder](https://github.com/shripal17/dart_scorm/example)

To test it in LMS platforms, just build release version of the [example app](https://github.com/shripal17/dart_scorm/example) and create a zip file of the example/build/web folder.

See [example/web/imsmanifest.xml](https://github.com/shripal17/dart_scorm/blob/main/example/web/imsmanifest.xml) for the resource declaration.

### TLDR
- The flutter app can be run in an `iframe` with the [example/web/flutter-app.html](https://github.com/shripal17/dart_scorm/blob/main/example/web/flutter-app.html) as `src`
- [example/web/flutter-app.js](https://github.com/shripal17/dart_scorm/blob/main/example/web/flutter-app.js) creates a custom HTMLElement **for testing**, which is used in [example/web/index.html](https://github.com/shripal17/dart_scorm/blob/main/example/web/index.html)
- [example/web/index.html](https://github.com/shripal17/dart_scorm/blob/main/example/web/index.html) contains [simplify-scorm](https://github.com/gabrieldoty/simplify-scorm) for emulation of the SCORM API

### References
[Official SCORM Docs](https://scorm.com/scorm-explained/technical-scorm/scorm-12-overview-for-developers)

[Create SCORM Package from scratch](https://myelearningworld.com/3-best-ways-to-create-a-scorm-content-package/)

## License

--------

    Copyright 2021 Shripal Jain

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
