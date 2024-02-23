# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'PlatziTweets' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PlatziTweets
  pod 'NotificationBannerSwift', '~> 3.0.0'
  pod 'KeychainSwift'
  pod 'SVProgressHUD'
  pod 'Simple-Networking', '~> 0.3.2'
  pod 'Kingfisher', '~> 5.0'
  pod 'Firebase/Storage'
  pod 'Firebase/Analytics'
  pod 'FirebaseCrashlytics'

  # post install
  post_install do |installer|
    # ios deployment version
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
        file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
        next unless File.file?(file_path)
        configuration = Xcodeproj::Config.new(file_path)
        next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
        configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
        configuration.save_as(file_path)
      end
    end
  end
end
