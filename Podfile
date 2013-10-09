platform :osx, '10.8'

workspace 'oss-for-mac'
xcodeproj 'oss-for-mac'

pod 'CommonCrypto', '~> 1.1'
pod 'SSKeychain', '~> 1.2.1'
pod 'AFNetworking', '~> 1.3.3'
#pod 'ASIHTTPRequest', '1.8.1'
pod 'Reachability', '~> 3.1.1'
pod 'lua', '~> 5.2.1'
#pod 'AWSiOSSDK', '~> 1.6.1'
#pod 'iConsole', '~> 1.4'
#target :OSSTests, :exclusive => true do
#    pod 'Kiwi/XCTest'
#end
target 'oss-for-mac Tests', :exclusive => true do
    pod 'Kiwi'
end
target 'oss-for-mac Tests', :exclusive => true do
    pod 'Kiwi/SenTestingKit', '~> 2.2.2'
end