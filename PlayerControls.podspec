Pod::Spec.new do |s|
  s.name             = 'PlayerControls'
  s.version          = 'new_version'
  s.summary          = 'Data-driven player controls for content and advertisement videos.'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.swift_version    = '4.1'
  
  s.description      = <<-DESC
  Player controls include design (layout and assets) and data structures that describe player controls.
                       DESC

  s.homepage         = 'https://github.com/aol-public/OneMobileSDK-controls-ios'
  s.author           = {
    'Andrey Moskvin' => 'andrey.moskvin@oath.com',
    'Alexey Demedetskiy' => 'alexey.demedetskiy@oath.com',
    'Bogdan Bilonog' => 'bogdan.bilonog@oath.com',
    'Roman Tysiachnik' => 'roman.tysiachnik@oath.com',
    'Vladyslav Anokhin' => 'vladyslav.anokhin@oath.com'
  }

  s.source = { :git => 'https://github.com/aol-public/OneMobileSDK-controls-ios.git',
               :tag => s.version.to_s }   
  s.source_files     = 'PlayerControls/**/*.swift'
  s.exclude_files    = 'PlayerControls/tests/*'
  s.resource         = 'PlayerControls/resources/*'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  s.frameworks = 'Foundation', 'UIKit'
end
