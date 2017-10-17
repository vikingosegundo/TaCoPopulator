
Pod::Spec.new do |s|
  s.name             = 'TaCoPopulator'
  s.version          = '0.1.6'
  s.summary          = 'A datasource framework for Table and Collection Views.'

  s.description      = <<-DESC
TaCoPopulator allows to cretate datasources that will work with UITableViews and UICollectionViews. It is designed to not interfere with the way you use those view.
DESC

  s.homepage         = 'https://gitlab.com/vikingosegundo/TaCoPopulator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manuel Meyer' => 'vikingosegundo@gmail.com' }
  s.source           = { :git => 'https://gitlab.com/vikingosegundo/TaCoPopulator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/vikingosegundo'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TaCoPopulator/Classes/**/*'
end
