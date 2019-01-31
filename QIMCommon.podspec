
Pod::Spec.new do |s|

  s.name         = "QIMCommon"
  s.version      = "1.1.9-beta"
  s.summary      = "Qunar chat App 9.0+ version QIMCommon"
  s.description  = <<-DESC
                   Qunar QIMCommon解决方案

                   DESC

  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.author        = { "Qunar IM" => "qtalk@qunar.com" }

  s.source       = { :git => "http://gitlab.corp.qunar.com/qchat/libQIMCommon-iOS.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '9.0'
  s.resource_bundles = {'QIMCommonResource' => ['QIMCommon/QIMKitCommonResource/*.{png,aac,caf,pem}']}

  s.platform     = :ios, "9.0"

  $lib = ENV['use_lib']
  $debug = ENV['debug']
  if $lib
    
    puts '---------QIMCommonSDK二进制-------'
    s.source_files = 'ios_libs/Headers/**/*.h'
    s.vendored_libraries = ['ios_libs/Frameworks/libQIMCommon.a']
    s.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}

  else

    puts '---------QIMCommonSDK源码-------'
    s.public_header_files = "QIMCommon/QIMKit/**/*.{h}", "QIMCommon/NoArc/**/*.{h}"

    s.source_files = "QIMCommon/Source/**/*.{h,m,c}", "QIMCommon/QIMKit/**/*.{h,m,c}", "QIMCommon/NoArc/**/*.{h,m}"
    s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'DEBUGLOG=1'}

    s.requires_arc = false  
    s.requires_arc = ['QIMCommon/Source/**/*', "QIMCommon/QIMKit/**/*.{h,m,c}"]

  end
  
  if $debug
    puts 'debug QIMCommon依赖第三方库'
    s.dependency 'QIMOpenSSL', '~> 1.beta'

  else
  
    puts '线上release QIMCommon依赖第三方库'
    s.dependency 'QIMOpenSSL', '~> 1.beta'
    s.dependency 'QIMKitVendor', '~> 1.beta'
    s.dependency 'QIMDataBase', '~> 1.beta'
    s.dependency 'QIMPublicRedefineHeader', '~> 0.beta'
  end
  
  s.dependency 'ASIHTTPRequest'
  s.dependency 'YYCache'
  s.dependency 'YYModel'
  s.dependency 'ProtocolBuffers'
  s.dependency 'CocoaAsyncSocket'
  s.dependency 'UICKeyChainStore'
  # 避免崩溃
  s.dependency 'AvoidCrash'
  
  s.dependency 'CocoaLumberjack'
  
  s.frameworks = 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AudioToolbox', 'AVFoundation', 'UserNotifications', 'CoreTelephony','QuartzCore', 'CoreGraphics', 'Security'
    s.libraries = 'sqlite3.0', 'stdc++', 'bz2'

end