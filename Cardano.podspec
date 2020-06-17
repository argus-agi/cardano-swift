Pod::Spec.new do |s|

  s.swift_versions         = '5.0'
  s.name                   = 'Cardano'
  s.version                = '0.0.1'
  s.summary                = 'Cardano Swift SDK'
  s.homepage               = 'https://github.com/hellc/cardano-swift'
  s.license                = 'MIT'
  s.author                 = { 'Ivan Manov' => 'ivanmanov@live.com' }
  s.social_media_url       = 'https://twitter.com/justhellc'
  s.requires_arc           = false
  s.ios.deployment_target  = '11.0'

  s.source                 = { :git => 'https://github.com/hellc/cardano-swift.git', :branch => 'develop' }

  s.default_subspec        = 'All'
  
  s.subspec 'All' do |all|
    all.dependency           'Cardano/Lib'
  end
  
  s.subspec 'Lib' do |lib|
    lib.source_files       = 'src/lib/**/*.{swift}'
  end

end
