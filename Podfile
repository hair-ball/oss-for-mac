# Uncomment this line to define a global platform for your project
# platform :ios, "6.0"

platform :osx, '10.8'

workspace 'oss-for-mac'
xcodeproj 'oss-for-mac'

target "OSS" do
  pod 'CommonCrypto', '~> 1.1'
  pod 'SSKeychain', '~> 1.2.1'
  pod 'AFNetworking', '~> 2.0.2'
  pod 'Reachability', '~> 3.1.1'
end

target "oss-for-mac Tests" do
  pod 'Kiwi', '~> 2.2.3'
#  pod 'Kiwi/XCTest'
  pod 'Kiwi/SenTestingKit', '~> 2.2.3'
end
