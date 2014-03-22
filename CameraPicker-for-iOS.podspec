
Pod::Spec.new do |s|
  s.name         = "CameraPicker-for-iOS"
  s.version      = "0.0.2"
  s.summary      = "A simple replacement for the default image picker of iPhone devices."
  s.description  = "A simple replacement for the default image picker of iPhone devices.
    ## FEATURES:
    * Button for accessing to the camera roll
    * Flash mode switcher
    * Rear-to-front camera switcher
    * Look and feel like the iPhone native picker"
  s.homepage     = "https://github.com/orlandoaleman/CameraPicker-for-iOS"
  s.authors      = { "Orlando Aleman Ortiz" => "contacto@orlandoaleman.com"}
  s.platform     = :ios, '5.0'
  s.license      = {:type => 'MIT', 
                    :text => <<-LICENSE
    LICENSE
  }
  s.source       = { :git => "https://github.com/orlandoaleman/CameraPicker-for-iOS.git", :tag => "0.0.2" }
  s.source_files = 'lib/**/*.{h,m}', 'CameraPicker/Classes/*.{h,m}'
  s.resources    = "CameraPicker/Resources"
  s.frameworks   = 'Foundation,UIKit'  
  s.requires_arc = true
  s.dependency   'UIImage-ResizeMagick', '>= 0.0.1'
end
