#!/bin/sh
flutter clean
flutter pub get
flutter build ios
flutter run --release