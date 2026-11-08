#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

if ! command -v xcodebuild >/dev/null 2>&1; then
    echo 'Hata: macOS ve Xcode gerekir.' >&2
    exit 1
fi

xcodebuild \
    -project TabDemo.xcodeproj \
    -scheme TabDemo \
    -configuration Release \
    -sdk iphoneos \
    -destination 'generic/platform=iOS' \
    -derivedDataPath build/DerivedData \
    CODE_SIGNING_ALLOWED=NO \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGN_IDENTITY='' \
    build

mkdir -p build/package/Payload
rm -rf build/package/Payload/TabDemo.app
cp -R build/DerivedData/Build/Products/Release-iphoneos/TabDemo.app build/package/Payload/
rm -f build/TabDemo-unsigned.ipa
(cd build/package && /usr/bin/zip -qry ../TabDemo-unsigned.ipa Payload)
echo 'Oluşturuldu: build/TabDemo-unsigned.ipa (kurulum için ayrıca imzalanmalı)'
