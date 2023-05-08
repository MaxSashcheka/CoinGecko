using_bundler = defined? Bundler
unless using_bundler
  puts "\nPlease re-run using:".red
  puts "  bundle exec pod install\n\n"
  exit(1)
end

platform :ios, '14.0'
inhibit_all_warnings!
use_frameworks! :linkage => :static
#$firebase_version = '~> 9.2.0'

source 'https://cdn.cocoapods.org/'

workspace 'CoinGecko'

def common_pods
  pod 'SwiftLint'
  pod 'SwiftGen'
end

def ui_pods
  pod 'SnapKit'
  pod 'SDWebImage'
  pod 'SVProgressHUD'
  pod 'SafeSFSymbols'
  pod 'Charts'
  pod 'NVActivityIndicatorView'
end

def network_pods
  pod 'Alamofire'
end

target 'CoinGecko' do
  common_pods
  ui_pods
  pod 'Firebase'
  pod 'Firebase/Storage'

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
