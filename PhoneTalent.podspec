Pod::Spec.new do |s|
  s.name     = 'PhoneTalent'
  s.version  = '1.9'
  s.license  = 'MIT'
  s.homepage = 'https://github.com/GaoZhiChaoChina/PhoneTalent.git'
  s.author   = { "ran gaozhichao” => “gaozhihcao@wanda.cn" }
  s.summary  = '<#描述#>'

  s.platform = :ios, '8.0'
  s.source = { :git => 'https://github.com/GaoZhiChaoChina/PhoneTalent.git', :tag=>s.version.to_s }
  s.prefix_header_file = 'MobilePhone/Supporting Files/PrefixHeader.pch' 
  s.pod_target_xcconfig = { "__TARGET_NAME__" => "\"$(PRODUCT_NAME)\"" }
  s.source_files = 'PhoneTalent/**/*.{h,m,c,mm}'
  s.resources = ["PhoneTalent/**/*.ttf"]
  
  # s.dependency '<#WDWorkFlow#>'
end
