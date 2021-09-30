workspace 'ttiTest.xcworkspace'

source 'https://github.com/CocoaPods/Specs.git'


platform :ios, '11.0'
inhibit_all_warnings!

def ttiTest_pods
    pod 'Alamofire', '~> 5.4.4'
    pod 'SnapKit', '~> 5.0.1'
    pod 'HandyJSON'
    pod 'ESPullToRefresh'
end

target 'ttiTest' do
    ttiTest_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts #{target.name}
  end
end
