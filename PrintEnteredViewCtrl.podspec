Pod::Spec.new do |s| 
  s.name = 'PrintEnteredViewCtrl' 
  s.version = '1.0' 
  s.summary = 'Kitty is good'
  s.homepage = 'http://www.58fo.com'
  s.license = { :'type' => 'Copyright', :'text' =>' Copyright 2017 foziquan '} 
  s.authors = 'chenqi' 
  s.source  = { :git => 'https://github.com/qi995971072/PrintEnteredViewCtrl.git', :tag => '1.0'}  
  s.platform = :ios, '8.0' 
  s.source_files = 'PrintEnteredViewCtrl', 'UIViewController+Print'
end 
