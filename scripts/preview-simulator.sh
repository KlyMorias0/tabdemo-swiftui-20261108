#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

xcrun simctl list devices available --json > build/simulator-devices.json
TABDEMO_DEVICE=$(python3 - <<'PY'
import json
with open('build/simulator-devices.json') as file:
    runtimes = json.load(file)['devices']
devices = [d for runtime, entries in runtimes.items()
           if 'iOS-26-' in runtime for d in entries
           if d['name'].startswith('iPhone') and d['isAvailable']]
if not devices:
    raise SystemExit('No available iOS 26 iPhone simulator.')
devices.sort(key=lambda d: (d['name'] != 'iPhone 17 Pro', d['name']))
print(devices[0]['udid'])
PY
)

if ! xcrun simctl list devices booted | /usr/bin/grep -q "$TABDEMO_DEVICE"; then
    xcrun simctl boot "$TABDEMO_DEVICE"
fi
xcrun simctl bootstatus "$TABDEMO_DEVICE" -b

xcodebuild -project TabDemo.xcodeproj -scheme TabDemo \
    -configuration Debug -sdk iphonesimulator \
    -destination "id=$TABDEMO_DEVICE" \
    -derivedDataPath build/Simulator \
    CODE_SIGNING_ALLOWED=NO build

xcrun simctl ui "$TABDEMO_DEVICE" appearance dark
xcrun simctl status_bar "$TABDEMO_DEVICE" override \
    --time '9:20' --dataNetwork wifi --wifiMode active --wifiBars 3 \
    --cellularMode active --cellularBars 4 --batteryState charged --batteryLevel 83
xcrun simctl install "$TABDEMO_DEVICE" build/Simulator/Build/Products/Debug-iphonesimulator/TabDemo.app
xcrun simctl launch "$TABDEMO_DEVICE" com.example.TabDemo
sleep 3
xcrun simctl io "$TABDEMO_DEVICE" screenshot build/TabDemo-iOS26.png
