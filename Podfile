# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Inforu' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Inforu

    pod 'IQKeyboardManagerSwift'   #Required http://fabfile.org
    pod 'Alamofire', '~> 4.9.0'    #Required
    pod 'MBProgressHUD'            #Required
    pod 'AFDateHelper'             #Required
    pod 'KeychainAccess'           #Required
    pod 'ReachabilitySwift'
    pod 'UIGradient'
    pod 'GoogleMaps'
    pod 'GooglePlaces'
    pod 'FBSDKCoreKit'
    pod 'FBSDKLoginKit'
    pod 'FBSDKShareKit'
    pod 'PinCodeTextField'
    pod 'Firebase/Analytics'
    pod 'Firebase/Database'
    pod 'Kingfisher'
    pod 'LinearProgressBarMaterial'
    pod 'Google-Mobile-Ads-SDK'
    pod 'Hippo'
    pod 'SkeletonView'
    pod 'NotificationBannerSwift'
    pod 'FBAudienceNetwork'
    pod 'Bolts'
    
  target 'InforuTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'InforuUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
        target.build_configurations.each do |config|
          config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
      end
      if ['Starscream'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
      end
    end
    
  end

end
