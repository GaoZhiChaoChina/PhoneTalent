Pod::Spec.new do |s|
  s.name     = 'MobilePhone'
  s.version  = '1.9'
  s.license  = 'MIT'
  s.homepage = 'https://github.com/GaoZhiChaoChina/MobilePhone.git'
  s.author   = { "ran gaozhichao” => “gaozhihcao@wanda.cn" }
  s.summary  = '<#描述#>'

  s.platform = :ios, '8.0'
  s.source = { :git => 'https://github.com/GaoZhiChaoChina/MobilePhone.git', :tag=>s.version.to_s }
  s.prefix_header_file = 'MobilePhone/Supporting Files/PrefixHeader.pch' 
  s.pod_target_xcconfig = { "__TARGET_NAME__" => "\"$(PRODUCT_NAME)\"" }
  s.source_files = 'MobilePhone/**/*.{h,m,c,mm}'
  s.resources = ["MobilePhone/**/*.ttf"]
  
  # s.dependency '<#WDWorkFlow#>'
end
