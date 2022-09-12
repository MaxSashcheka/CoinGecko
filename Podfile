platform :ios, '14.0'
inhibit_all_warnings!
use_frameworks! :linkage => :static

source 'https://cdn.cocoapods.org/'

workspace 'CoinGecko'

def common_pods
  pod 'SwiftLint'
  pod 'SwiftGen'
end

def ui_pods
  pod 'SnapKit'
end

def network_pods
  pod 'Alamofire'
end

def reactive_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'CoinGecko' do
  common_pods
  ui_pods
  reactive_pods

  project 'CoinGecko/CoinGecko.xcodeproj'
end

target 'Core' do
  common_pods
  network_pods
  
  project 'Core/Core.xcodeproj'
end

target 'Utils' do
  common_pods
  ui_pods
  
  project 'Utils/Utils.xcodeproj'
end
