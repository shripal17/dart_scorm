#!/bin/bash

flutter clean
flutter pub get
#flutter pub run build_runner build --delete-conflicting-outputs
cd example
flutter build web --release --web-renderer html
rm ../scorm.zip
cd build/web
zip -r ../../../scorm.zip *
cd ../../..