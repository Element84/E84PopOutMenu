Pod::Spec.new do |s|
  s.name         = 'E84PopOutMenu'
  s.version      = '0.0.4'
  s.license      = 'MIT'
  s.platform     = :ios, '7.0'  
  s.summary      = 'Small UIControl for presenting a menu with any number of menu items with a nice open and close animation.'
  s.homepage     = 'https://github.com/Element84/E84PopOutMenu'
  s.author       = { 'Paul Pilone' => 'paul@element84.com' }
  s.source       = { :git => 'https://github.com/Element84/E84PopOutMenu.git', :tag => s.version.to_s }
  s.source_files = 'E84PopOutMenu/*.{h,m}'
  s.requires_arc = true
end
