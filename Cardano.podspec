Pod::Spec.new do |s|

  s.swift_versions         = '5.0'
  s.name                   = 'Cardano'
  s.version                = '0.0.1'
  s.summary                = 'Cardano Swift SDK'
  s.homepage               = 'https://github.com/kxpone/cardano-swift'
  s.license                = 'MIT'
  s.author                 = { '@hellc' => 'info@kxp.one' }
  s.social_media_url       = 'https://twitter.com/kxpone'
  s.requires_arc           = false
  s.ios.deployment_target  = '11.0'

  s.source                 = { :git => 'https://github.com/kxpone/cardano-swift.git', :branch => 'develop' }

  s.default_subspec        = 'All'
  
  s.subspec 'All' do |all|
    all.dependency           'Cardano/Lib'
  end
  
  s.subspec 'Lib' do |lib|
    lib.source_files       = 'Cardano/Lib/**/*.{swift}'
  end
  
  spec.dependency 'CatalystNet', :git => 'https://github.com/hellc/CatalystNet.git', :commit => 'fedc632a349ae01284354903f99dfb0969c3fde6'
end
