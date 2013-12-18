Pod::Spec.new do |s|
  s.name         = "LHFontSelectionViewController"
  s.version      = "0.0.1"
  s.summary      = "An easy way to let users update fonts in your iOS application."
  s.license      = {
    :type => 'Apache 2.0',
    :file => 'LICENSE' }

  s.author       = { "Dan Loewenherz" => "dan@lionheartsw.com" }
  s.platform     = :ios, '7.0'
  s.source       = {
    :git => "https://github.com/lionheart/LHFontSelectionViewController.git",
    :tag => "v#{s.version}"
  }

  s.source_files  = 'Protocols/*.h', 'Classes/*.{h,m}'
  s.exclude_files = 'Classes/Exclude'

  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
end
