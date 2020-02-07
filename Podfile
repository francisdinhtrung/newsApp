# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
inhibit_all_warnings!

def rx_swift
    pod 'RxSwift'
end

def rx_cocoa
    pod 'RxCocoa'
end

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
end

def utilities_pods 
pod 'Kingfisher'
pod 'SwiftMessages'
pod 'Hero'
pod 'MBProgressHUD'
pod 'Swinject'
pod 'ReachabilitySwift'
pod 'Locksmith'
pod 'ObjectMapper'
pod 'EZSwiftExtensions', :git => 'https://github.com/goktugyil/EZSwiftExtensions.git', :branch => 'ceeyang-Swift5.0'
pod 'IQKeyboardManagerSwift'
pod 'UIAlertController+Blocks'
pod 'Moya/RxSwift'
pod 'XCGLogger'
pod 'SVProgressHUD'
pod "RxRealm"
pod 'RealmSwift'
pod "ESPullToRefresh"
pod 'RxDataSources'
pod 'SwifterSwift'
pod 'SwiftDate'
pod 'PureLayout'

end
target 'News' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  rx_cocoa
  rx_swift
  utilities_pods
  target 'NewsTests' do
    inherit! :search_paths
    test_pods
  end

end
