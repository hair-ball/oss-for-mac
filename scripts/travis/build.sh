#!/usr/bin/env sh

echo "xcodebuild -list"
xcodebuild -list
echo "xcodebuild -project oss-for-mac.xcodeproj -list"
xcodebuild -project oss-for-mac.xcodeproj -list
echo "xcodebuild -workspace oss-for-mac.xcworkspace -list"
xcodebuild -workspace oss-for-mac.xcworkspace -list
echo "xcodebuild -workspace oss-for-mac.xcworkspace -scheme OSS -sdk macosx10.8 clean test"
xcodebuild -workspace oss-for-mac.xcworkspace -scheme OSS -sdk macosx10.8 clean test