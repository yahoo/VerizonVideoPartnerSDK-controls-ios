Pod::Spec.new do |s|
  s.name             = "PlayerControls"
  s.version          = "1.0"
  s.summary          = "Data-driven player controls for content and advertisement videos."
  s.license          = { :type => 'MIT', :file => "LICENSE"}

  s.description      = <<-DESC
  Player controls include design (layout and assets) and data structures that describe player controls.
                       DESC

  s.homepage         = "https://github.com/vidible/OneMobileSDK-controls-ios"
  s.author           = {
    "Andrey Moskvin" => "andrey.moskvin@teamaol.com",
    "Alexey Demedetskiy" => "alexey.demedetskiy@teamaol.com"
  }

  s.source           =  { :git => 'https://github.com/vidible/OneMobileSDK-controls-ios.git', :tag => '1.0' }
  s.source_files     = "PlayerControls/sources/*"

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.frameworks = 'Foundation', 'UIKit'
end
