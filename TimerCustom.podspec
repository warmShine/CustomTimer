Pod::Spec.new do |s|

  s.name         = 'TimerCustom'
  s.version      = '0.0.1'
  s.summary      = 'Custom Timer'

  s.description  = <<-DESC
                   Timer
                   DESC

  s.license     = {:type => 'BSD'}
  s.homepage    =  'https://github.com/warmShine/TimerDemo.git'
  s.author             = { 'L' => 'supersun_shine@126.com' }
  s.ios.deployment_target = '8.0'

  #s.source       = {}
  s.source_files  = 'src', 'src/*.{h,m,mm,cpp,c}', 'src/*/*.{h,m,mm,cpp,c}'#, 'src/**/*.{h,m,mm,cpp,c}'
  s.public_header_files = 'src/*.h', 'src/*/*.h'#, 'src/**/*.h'

  s.resource = "Resources/*.{png,jpg,jpeg,xib}"

  s.requires_arc = true
  
end
