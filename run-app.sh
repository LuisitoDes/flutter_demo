#!/bin/sh
rm ios/Podfile
pod install
flutter clean
flutter build ios
flutter run --release