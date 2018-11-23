Pod::Spec.new do |s|
    s.name             = 'cardano-ios'
    s.version          = '0.0.1'
    s.summary          = 'Cardano blockchain tools for iOS'

    s.description      = <<-DESC
    Original rust-cardano library wrapper for iOS
    DESC

    s.homepage         = 'https://github.com/hellc/cardano-ios'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'hellc' => 'ivanmanov@live.com' }
    s.source           = { :git => 'https://github.com/hellc/cardano-ios.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/ivanmanoff'

    s.ios.deployment_target = '9.0'

    s.public_header_files = 'cardano-ios/src/cardano-ios.h'
    s.source_files = 'cardano-ios/src/cardano-ios.h'

    s.subspec 'Classes' do |ss|
        ss.source_files = 'cardano-ios/src/**/*.{h,m}'
        ss.public_header_files = 'cardano-ios/src/**/*.h'
    end
end

