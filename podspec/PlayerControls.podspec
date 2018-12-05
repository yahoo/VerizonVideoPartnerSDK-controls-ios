Pod::Spec.new do |s|
  s.name             = 'PlayerControls'
  s.version          = 'new_version'
  s.summary          = 'Data-driven player controls for content and advertisement videos.'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.platform         = :ios
  s.swift_version    = '4.2'
  
  s.description      = <<-DESC
  Player controls include design (layout and assets) and data structures that describe player controls.
DESC

  s.homepage         = 'https://github.com/OathAdPlatforms/OneMobileSDK-controls-ios'
  s.authors          = {
    'Andrey Moskvin' => 'andrey.moskvin@oath.com',
    'Alexey Demedetskiy' => 'alexey.demedetskiy@oath.com',
    'Bogdan Bilonog' => 'bogdan.bilonog@oath.com',
    'Roman Tysiachnik' => 'roman.tysiachnik@oath.com',
    'Vladyslav Anokhin' => 'vladyslav.anokhin@oath.com'
  }

  s.source = { :git => 'https://github.com/OathAdPlatforms/OneMobileSDK-controls-ios.git',
               :tag => s.version.to_s,
               :submodules => true }   
  s.source_files     = 'PlayerControls/**/*.swift'
  s.resources        = 'PlayerControls/resources/*'
  s.exclude_files    = 'PlayerControls/tests/*'
  
  s.ios.deployment_target = '9.0'

  s.frameworks = 'Foundation', 'UIKit', 'CoreMedia', 'SafariServices'
end
