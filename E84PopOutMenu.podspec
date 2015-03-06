Pod::Spec.new do |s|
  s.name         = 'E84PopOutMenu'
  s.version      = '0.0.1'
  s.license      = 'MIT'
  s.platform     = :ios, '7.0'  
  s.summary      = 'Menu control that opens/closes in a nice animation revealing all menu items.'
  s.homepage     = 'www.element84.com'
  s.author       = { 'Paul Pilone' => 'paul@element84.com' }
  s.source       = { :git => 'https://github.com/Element84/E84PopOutMenu.git', :tag => s.version.to_s }
  s.source_files = 'E84PopOutMenu/*.{h,m}'
  s.requires_arc = true
end