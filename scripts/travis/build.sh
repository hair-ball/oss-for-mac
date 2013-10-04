#!/usr/bin/env sh

xcodebuild \
    -workspace oss-for-mac.xcworkspace \
    -scheme OSS \
    -sdk macosx10.8 \
    -configuration Debug \
    -arch x86_64 \
    clean \
    test