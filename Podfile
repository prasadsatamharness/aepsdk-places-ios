# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

# don't warn me
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

workspace 'AEPPlaces'
project 'AEPPlaces.xcodeproj'

pod 'SwiftLint', '0.52.0'

# ==================
# SHARED POD GROUPS
# ==================
# development against main branches of dependencies
def dev_main
    pod 'AEPCore'
    pod 'AEPServices'
    pod 'AEPRulesEngine'
end

# development against dev branches of dependencies
def dev_dev
    pod 'AEPCore', :git => 'https://github.com/adobe/aepsdk-core-ios.git', :branch => 'staging'
    pod 'AEPServices', :git => 'https://github.com/adobe/aepsdk-core-ios.git', :branch => 'staging'
    pod 'AEPRulesEngine', :git => 'https://github.com/adobe/aepsdk-rulesengine-ios.git', :branch => 'dev-v5.0.0'
end

# test app against main branches
def test_main
    dev_main
    pod 'AEPAnalytics'
    pod 'AEPIdentity'
    pod 'AEPLifecycle'
    pod 'AEPSignal'
    pod 'AEPAssurance'
    pod 'AEPEdgeIdentity'
    pod 'AEPEdgeConsent'
    pod 'AEPEdge'
end

# test app against dev branches
def test_dev
    dev_dev
    pod 'AEPAnalytics'
    pod 'AEPIdentity', :git => 'https://github.com/adobe/aepsdk-core-ios.git', :branch => 'staging'
    pod 'AEPLifecycle', :git => 'https://github.com/adobe/aepsdk-core-ios.git', :branch => 'staging'
    pod 'AEPSignal', :git => 'https://github.com/adobe/aepsdk-core-ios.git', :branch => 'staging'
    pod 'AEPAssurance', :git => 'https://github.com/adobe/aepsdk-assurance-ios.git', :branch => 'dev-v5.0.0'
    pod 'AEPEdgeIdentity', :git => 'https://github.com/adobe/aepsdk-edgeidentity-ios.git', :branch => 'dev-v5.0.0'
    pod 'AEPEdgeConsent', :git => 'https://github.com/adobe/aepsdk-edgeconsent-ios.git', :branch => 'dev-v5.0.0'
    pod 'AEPEdge', :git => 'https://github.com/adobe/aepsdk-edge-ios.git', :branch => 'dev-v5.0.0'
end

# ==================
# TARGET DEFINITIONS
# ==================
target 'AEPPlaces' do
    dev_dev
end

target 'AEPPlacesTests' do
    dev_dev
    pod 'AEPTestUtils', :git => 'https://github.com/adobe/aepsdk-testutils-ios.git', :tag => 'v5.0.0-beta'
end

target 'PlacesTestApp' do
    test_dev
end

target 'PlacesTestApp_objc' do
    test_dev
end
